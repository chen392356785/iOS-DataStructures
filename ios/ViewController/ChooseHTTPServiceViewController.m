//
//  ChooseHTTPServiceViewController.m
//  Owner
//
//  Created by Neely on 2018/4/2.
//

#import "ServerConfig.h"
#import "UIBarButtonItem+Extents.h"
#import "ChooseHTTPServiceViewController.h"

@interface ChooseHTTPServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ChooseHTTPServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"切换服务器";
    [self setLeftButtonImage:Image(@"cancleActivOrder.png") forState:UIControlStateNormal];

    self.dataSource = [NSMutableArray arrayWithObjects:[ServerConfig getDevelopHTTP],[ServerConfig getTestHTTP],[ServerConfig getHTTP], nil];
    
    self.navigationItem.rightBarButtonItems =
    [UIBarButtonItem defaultRightTitleItemTarget:self
                                          action:@selector(inputIP)
                                            text:@"输入IP"];
    [self.view addSubview:self.tableView];
}

-(void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)inputIP
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"手动切换IP地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSString *url = @"http://192.168.1.140:8081/zmh/";
        textField.text = url;
        [self.tableView reloadData];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ServerConfig setHTTPServer:alert.textFields[0].text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [ServerConfig setHTTPServer:[[alertView textFieldAtIndex:0] text]];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    NSString *httpUrl = [self.dataSource objectAtIndex:indexPath.row];
    NSString *currentUrl = [ServerConfig HTTPServer];
    cell.textLabel.textColor = ([httpUrl isEqualToString:currentUrl]) ? [UIColor redColor] : [UIColor blackColor];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSInteger count = [tableView numberOfRowsInSection:0];
    
    [UIAlertView alertViewWithTitle:@"提示" message:@"是否切换服务器" cancelButtonTitle:@"取消" otherButtonTitles:@[ @"确定" ] onDismiss:^(NSInteger buttonIndex) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [ServerConfig setHTTPServer:cell.textLabel.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    } onCancel:^{
        
    }];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource= self;
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

@end

