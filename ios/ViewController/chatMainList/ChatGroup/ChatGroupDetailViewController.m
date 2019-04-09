/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "ChatGroupDetailViewController.h"

#import "ContactSelectionViewController.h"
//#import "GroupSettingViewController.h"
//#import "EMGroup.h"
#import "ContactView.h"
#import "GroupBansViewController.h"
#import "GroupSubjectChangingViewController.h"
#import "MTOtherInfomationMainViewController.h"


#pragma mark - ChatGroupDetailViewController

#define kColOfRow 5
#define kContactSize (WindowWith-20)/5.0

@interface ChatGroupDetailViewController ()<IChatManagerDelegate, EMChooseViewDelegate, UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
//    EMGroup *_group;
    BOOL _isOwner;
    UISwitch *_pushSwitch;
    UISwitch *_blockSwitch;
}
- (void)unregisterNotifications;
- (void)registerNotifications;

@property (nonatomic) GroupOccupantType occupantType;
@property (strong, nonatomic) EMGroup *chatGroup;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *addButton;

@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIButton *exitButton;
@property (strong, nonatomic) UIButton *dissolveButton;
@property (strong, nonatomic) UIButton *configureButton;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) ContactView *selectedContact;

- (void)dissolveAction;
- (void)clearAction;
- (void)exitAction;
- (void)configureAction;

@end

@implementation ChatGroupDetailViewController

- (void)registerNotifications {
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)unregisterNotifications {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc {
    [self unregisterNotifications];
}

- (instancetype)initWithGroup:(EMGroup *)chatGroup
{
    self = [super init];
    if (self) {
        // Custom initialization
        _chatGroup = chatGroup;
        _dataSource = [NSMutableArray array];
        _occupantType = GroupOccupantTypeMember;
        [self registerNotifications];
        
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        _isOwner = [_chatGroup.owner isEqualToString:loginUsername];
    }
    return self;
}

- (instancetype)initWithGroupId:(NSString *)chatGroupId
{
    EMGroup *chatGroup = nil;
    NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
    for (EMGroup *group in groupArray) {
        if ([group.groupId isEqualToString:chatGroupId]) {
            chatGroup = group;
            break;
        }
    }
    
    if (chatGroup == nil) {
        chatGroup = [EMGroup groupWithId:chatGroupId];
    }
    
    self = [self initWithGroup:chatGroup];
    if (self) {
        //
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self setTitle:@"聊天信息"];
    UITableView *tableVIew=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth,kScreenHeight - TFNavigationBar) style:UITableViewStylePlain];
    tableVIew.delegate=self;
    _tableView=tableVIew;
    tableVIew.dataSource=self;
    [self.view addSubview:tableVIew];
    
    tableVIew.tableFooterView = self.footerView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(groupBansChanged) name:@"GroupBansChanged" object:nil];
    
    _pushSwitch = [[UISwitch alloc] init];
    [_pushSwitch addTarget:self action:@selector(pushSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [_pushSwitch setOn:_chatGroup.isPushNotificationEnabled animated:YES];
    
    _blockSwitch = [[UISwitch alloc] init];
    [_blockSwitch addTarget:self action:@selector(blockSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [_blockSwitch setOn:_chatGroup.isBlocked animated:YES];
    
    [self fetchGroupInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - getter

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, kContactSize)];
        _scrollView.tag = 0;
        
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kContactSize - 10, kContactSize - 10)];
        [_addButton setImage:[UIImage imageNamed:@"group_participant_add"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"group_participant_addHL"] forState:UIControlStateHighlighted];
        [_addButton addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
        
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteContactBegin:)];
        _longPress.minimumPressDuration = 0.5;
    }
    
    return _scrollView;
}

- (UIButton *)clearButton
{
    if (_clearButton == nil) {
        _clearButton = [[UIButton alloc] init];
        [_clearButton setTitle:NSLocalizedString(@"group.removeAllMessages", @"remove all messages") forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
        [_clearButton setBackgroundColor:[IHUtility colorWithHexString:@"#00c1af"]];
    }
    
    return _clearButton;
}

- (UIButton *)dissolveButton
{
    if (_dissolveButton == nil) {
        _dissolveButton = [[UIButton alloc] init];
        [_dissolveButton setTitle:NSLocalizedString(@"group.destroy", @"dissolution of the group") forState:UIControlStateNormal];
        [_dissolveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_dissolveButton addTarget:self action:@selector(dissolveAction) forControlEvents:UIControlEventTouchUpInside];
        [_dissolveButton setBackgroundColor: [IHUtility colorWithHexString:@"#ef7777"]];
    }
    
    return _dissolveButton;
}

- (UIButton *)exitButton
{
    if (_exitButton == nil) {
        _exitButton = [[UIButton alloc] init];
        [_exitButton setTitle:NSLocalizedString(@"group.leave", @"quit the group") forState:UIControlStateNormal];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
        [_exitButton setBackgroundColor:[IHUtility colorWithHexString:@"#ef7777"]];
    }
    
    return _exitButton;
}

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,_tableView.frame.size.width, 160)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        self.clearButton.frame = CGRectMake(20, 40, _footerView.frame.size.width - 40, 35);
        [_footerView addSubview:self.clearButton];
        
        self.dissolveButton.frame = CGRectMake(20, CGRectGetMaxY(self.clearButton.frame) + 30, _footerView.frame.size.width - 40, 35);
        
        self.exitButton.frame = CGRectMake(20, CGRectGetMaxY(self.clearButton.frame) + 30, _footerView.frame.size.width - 40, 35);
    }
    
    return _footerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.occupantType == GroupOccupantTypeOwner)
    {
//        return 6;
        if (_isOwner) {
            return 6;
        }
        else{
            if (_blockSwitch.isOn) {
                return 6;
            }
            else{
                return 7;
            }
        }
    }
    else
    {
//        return 4;
        if (_isOwner) {
            return 4;
        }
        else{
            if (_blockSwitch.isOn) {
                return 4;
            }
            else{
                return 5;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.scrollView];
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = NSLocalizedString(@"group.id", @"group ID");
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = _chatGroup.groupId;
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = NSLocalizedString(@"group.occupantCount", @"members count");
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%i / %i", (int)[_chatGroup.occupants count], (int)_chatGroup.groupSetting.groupMaxUsersCount];
    }
    else if ((_isOwner && indexPath.row == 3) || (!_isOwner && indexPath.row == 4)) {
        _pushSwitch.frame = CGRectMake(_tableView.frame.size.width - (_pushSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _pushSwitch.frame.size.height) / 2, _pushSwitch.frame.size.width, _pushSwitch.frame.size.height);
        
        if (_pushSwitch.isOn) {
            cell.textLabel.text = NSLocalizedString(@"group.setting.receiveAndPrompt", @"receive and prompt group of messages");
        }
        else{
            cell.textLabel.text = NSLocalizedString(@"group.setting.receiveAndUnprompt", @"receive not only hint of messages");
        }
        
        [cell.contentView addSubview:_pushSwitch];
        [cell.contentView bringSubviewToFront:_pushSwitch];
    }
    else if(!_isOwner && indexPath.row == 3){
        _blockSwitch.frame = CGRectMake(_tableView.frame.size.width - (_blockSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _blockSwitch.frame.size.height) / 2, _blockSwitch.frame.size.width, _blockSwitch.frame.size.height);
        
        cell.textLabel.text = NSLocalizedString(@"group.setting.blockMessage", @"shielding of the message");
        [cell.contentView addSubview:_blockSwitch];
        [cell.contentView bringSubviewToFront:_blockSwitch];
    }

//    else if (indexPath.row == 3)
//    {
//        cell.textLabel.text = NSLocalizedString(@"title.groupSetting", @"Group Setting");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    else if (indexPath.row == 4)
//    {
//        cell.textLabel.text = NSLocalizedString(@"title.groupSubjectChanging", @"Change group name");
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    else if (indexPath.row == 5)
    {
        cell.textLabel.text = NSLocalizedString(@"title.groupBlackList", @"Group black list");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    if (row == 0) {
        return self.scrollView.frame.size.height + 40;
    }
    else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
//        GroupSettingViewController *settingController = [[GroupSettingViewController alloc] initWithGroup:_chatGroup];
//        [self.navigationController pushViewController:settingController animated:YES];
    }
    else if (indexPath.row == 5)
    {
        GroupSubjectChangingViewController *changingController = [[GroupSubjectChangingViewController alloc] initWithGroup:_chatGroup];
        [self.navigationController pushViewController:changingController animated:YES];
    }
    else if (indexPath.row == 6) {
        GroupBansViewController *bansController = [[GroupBansViewController alloc] initWithGroup:_chatGroup];
        [self.navigationController pushViewController:bansController animated:YES];
    }
}

#pragma mark - EMChooseViewDelegate
- (BOOL)viewController:(EMChooseViewController *)viewController didFinishSelectedSources:(NSArray *)selectedSources
{
    NSInteger maxUsersCount = _chatGroup.groupSetting.groupMaxUsersCount;
    if (([selectedSources count] + _chatGroup.groupOccupantsCount) > maxUsersCount) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"group.maxUserCount", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alertView show];
        
        return NO;
    }
    
    [self showHudInView:self.view hint:NSLocalizedString(@"group.addingOccupant", @"add a group member...")];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *source = [NSMutableArray array];
        for (EMBuddy *buddy in selectedSources) {
            [source addObject:buddy.username];
        }
        
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *username = [loginInfo objectForKey:kSDKUsername];
        NSString *messageStr = [NSString stringWithFormat:NSLocalizedString(@"group.somebodyInvite", @"%@ invite you to join group \'%@\'"), username, weakSelf.chatGroup.groupSubject];
        EMError *error = nil;
        weakSelf.chatGroup = [[EaseMob sharedInstance].chatManager addOccupants:source toGroup:weakSelf.chatGroup.groupId welcomeMessage:messageStr error:&error];
        if (!error) {
            [weakSelf reloadDataSource];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
                [weakSelf showHint:error.description];
            });
        }
    });
    
    return YES;
}

- (void)groupBansChanged
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:self.chatGroup.occupants];
    [self refreshScrollView];
}

#pragma mark - data

- (void)fetchGroupInfo
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
    [[EaseMob sharedInstance].chatManager asyncFetchGroupInfo:_chatGroup.groupId completion:^(EMGroup *group, EMError *error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (!error) {
                weakSelf.chatGroup = group;
                [weakSelf reloadDataSource];
            }
            else{
                [weakSelf showHint:NSLocalizedString(@"group.fetchInfoFail", @"failed to get the group details, please try again later")];
            }
        });
    } onQueue:nil];
}

- (void)reloadDataSource
{
    [self.dataSource removeAllObjects];
    
    self.occupantType = GroupOccupantTypeMember;
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    if ([self.chatGroup.owner isEqualToString:loginUsername]) {
        self.occupantType = GroupOccupantTypeOwner;
    }
    
    if (self.occupantType != GroupOccupantTypeOwner) {
        for (NSString *str in self.chatGroup.members) {
            if ([str isEqualToString:loginUsername]) {
                self.occupantType = GroupOccupantTypeMember;
                break;
            }
        }
    }
    
    [self.dataSource addObjectsFromArray:self.chatGroup.occupants];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshScrollView];
        [self refreshFooterView];
        [self hideHud];
    });
}

- (void)refreshScrollView
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.scrollView removeGestureRecognizer:_longPress];
    [self.addButton removeFromSuperview];
    
    BOOL showAddButton = NO;
    if (self.occupantType == GroupOccupantTypeOwner) {
        [self.scrollView addGestureRecognizer:_longPress];
        [self.scrollView addSubview:self.addButton];
        showAddButton = YES;
    }
    else if (self.chatGroup.groupSetting.groupStyle == eGroupStyle_PrivateMemberCanInvite && self.occupantType == GroupOccupantTypeMember) {
        [self.scrollView addSubview:self.addButton];
        showAddButton = YES;
    }
    
    int tmp = ([self.dataSource count] + 1) % kColOfRow;
    int row = (int)([self.dataSource count] + 1) / kColOfRow;
    row += tmp == 0 ? 0 : 1;
    self.scrollView.tag = row;
    self.scrollView.frame = CGRectMake(10, 20, _tableView.frame.size.width - 20, row * kContactSize);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, row * kContactSize);
    
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    
    int i = 0;
    int j = 0;
    BOOL isEditing = self.addButton.hidden ? YES : NO;
    BOOL isEnd = NO;
    for (i = 0; i < row; i++) {
        for (j = 0; j < kColOfRow; j++) {
            NSInteger index = i * kColOfRow + j;
            if (index < [self.dataSource count]) {
                NSString *username = [self.dataSource objectAtIndex:index];
                ContactView *contactView = [[ContactView alloc] initWithFrame:CGRectMake(j * kContactSize, i * kContactSize, kContactSize, kContactSize)];
                contactView.userInteractionEnabled = YES;
                contactView.index = i * kColOfRow + j;
                NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
                NSDictionary *userDic=dic[username];
                if (userDic!=nil) {
                    [contactView setImageURL:userDic[kFromeHeadImage]];
                    contactView.remark = userDic[kFromeNickName];
                }else{
                    contactView.image = [UIImage imageNamed:@"chatListCellHead.png"];
                    contactView.remark = username;
                }
       
                if (![username isEqualToString:loginUsername]) {
                    contactView.editing = isEditing;
                }
                
                __weak typeof(self) weakSelf = self;
                [contactView setDeleteContact:^(NSInteger index) {
                    [weakSelf showHudInView:weakSelf.view hint:NSLocalizedString(@"group.removingOccupant", @"deleting member...")];
                    NSArray *occupants = [NSArray arrayWithObject:[weakSelf.dataSource objectAtIndex:index]];
                    [[EaseMob sharedInstance].chatManager asyncRemoveOccupants:occupants fromGroup:weakSelf.chatGroup.groupId completion:^(EMGroup *group, EMError *error) {
                        [weakSelf hideHud];
                        if (!error) {
                            weakSelf.chatGroup = group;
                            [weakSelf.dataSource removeObjectAtIndex:index];
                            [weakSelf refreshScrollView];
                        }
                        else{
                            [weakSelf showHint:error.description];
                        }
                    } onQueue:nil];
                }];
                
                [self.scrollView addSubview:contactView];
                
                UITapGestureRecognizer *tapHeardImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userHomePage:)];
                tapHeardImg.numberOfTapsRequired = 1;
                tapHeardImg.numberOfTouchesRequired = 1;
                
                [contactView addGestureRecognizer:tapHeardImg];
            }
            else{
                if(showAddButton && index == self.dataSource.count)
                {
                    self.addButton.frame = CGRectMake(j * kContactSize + 5, i * kContactSize + 10, kContactSize - 10, kContactSize - 10);
                }
                
                isEnd = YES;
                break;
            }
        }
        
        if (isEnd) {
            break;
        }
    }
    
    [_tableView reloadData];
}

//点击头像进入个人主页
- (void)userHomePage:(UITapGestureRecognizer *)tap
{
    //获取点击头像的环信ID
    ContactView *contactView = (ContactView *)tap.view;
    NSString *username = [self.dataSource objectAtIndex:contactView.index];
    
    //根据环信ID获取用户数据
    [self addWaitingView];
    [network getUserInfoByHxName:username success:^(NSDictionary *obj) {
        
        UserChildrenInfo *mod=[[UserChildrenInfo alloc]initWithDictionary:obj[@"content"] error:nil];
        if (mod.user_id == nil) {
                [self addSucessView:@"未查到该用户信息" type:2];
                return ;
            }
        [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
            [self removeWaitingView];
            MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
            controller.userMod=mod;
            controller.dic=obj[@"content"];
            [self pushViewController:controller];
        } failure:^(NSDictionary *obj2) {
            
        }];
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];

}

- (void)refreshFooterView
{
    if (self.occupantType == GroupOccupantTypeOwner) {
        [_exitButton removeFromSuperview];
        [_footerView addSubview:self.dissolveButton];
    }
    else{
        [_dissolveButton removeFromSuperview];
        [_footerView addSubview:self.exitButton];
    }
}

#pragma mark - action

- (void)tapView:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        if (self.addButton.hidden) {
            [self setScrollViewEditing:NO];
        }
    }
}

- (void)deleteContactBegin:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        for (ContactView *contactView in self.scrollView.subviews)
        {
            CGPoint locaton = [longPress locationInView:contactView];
            if (CGRectContainsPoint(contactView.bounds, locaton))
            {
                if ([contactView isKindOfClass:[ContactView class]]) {
                    if ([contactView.remark isEqualToString:loginUsername]) {
                        return;
                    }
                    _selectedContact = contactView;
                    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"delete", @"deleting member..."), NSLocalizedString(@"friend.block", @"add to black list"), nil];
                    [sheet showInView:self.view];
                }
            }
        }
    }
}

- (void)setScrollViewEditing:(BOOL)isEditing
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    
    for (ContactView *contactView in self.scrollView.subviews)
    {
        if ([contactView isKindOfClass:[ContactView class]]) {
            if ([contactView.remark isEqualToString:loginUsername]) {
                continue;
            }
            
            [contactView setEditing:isEditing];
        }
    }
    
    self.addButton.hidden = isEditing;
}

- (void)addContact:(id)sender
{
    ContactSelectionViewController *selectionController = [[ContactSelectionViewController alloc] initWithBlockSelectedUsernames:_chatGroup.occupants];
    selectionController.delegate = self;
    [self.navigationController pushViewController:selectionController animated:YES];
}

//清空聊天记录
- (void)clearAction
{
    __weak typeof(self) weakSelf = self;
    [EMAlertView showAlertWithTitle:NSLocalizedString(@"prompt", @"Prompt")
                            message:NSLocalizedString(@"sureToDelete", @"please make sure to delete")
                    completionBlock:^(NSUInteger buttonIndex, EMAlertView *alertView) {
                        if (buttonIndex == 1) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllMessages" object:weakSelf.chatGroup.groupId];
                        }
                    } cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                  otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    
}

//解散群组
- (void)dissolveAction
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"group.destroy", @"dissolution of the group")];
    [[EaseMob sharedInstance].chatManager asyncDestroyGroup:_chatGroup.groupId completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {
        [weakSelf hideHud];
        if (error) {
            [weakSelf showHint:NSLocalizedString(@"group.destroyFail", @"dissolution of group failure")];
        }
        else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroup" object:nil];
        }
    } onQueue:nil];
    
    //    [[EaseMob sharedInstance].chatManager asyncLeaveGroup:_chatGroup.groupId];
}

//设置群组
- (void)configureAction {
    // todo
    [[[EaseMob sharedInstance] chatManager] asyncIgnoreGroupPushNotification:_chatGroup.groupId
                                                                    isIgnore:_chatGroup.isPushNotificationEnabled];
    
//    return;
//    UIViewController *viewController = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

//退出群组
- (void)exitAction
{
    
         [IHUtility AlertMessage:@"温馨提示" message:@"确定退出群聊么" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:2016];
    
    
    
    
    //    [[EaseMob sharedInstance].chatManager asyncLeaveGroup:_chatGroup.groupId];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (alertView.tag==2016) {
        if (buttonIndex==0){
            __weak typeof(self) weakSelf = self;
            [self showHudInView:self.view hint:NSLocalizedString(@"group.leave", @"quit the group")];
            [[EaseMob sharedInstance].chatManager asyncLeaveGroup:_chatGroup.groupId completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {
                [weakSelf hideHud];
                if (error) {
                    [weakSelf showHint:NSLocalizedString(@"group.leaveFail", @"exit the group failure")];
                }
                else{
                    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[IHUtility getUserdefalutsList:USERMODEL.userID]];
                    NSDictionary *dic1=nil;
                    for (NSDictionary *dic in arr) {
                        if ([group.groupId isEqualToString:dic.allKeys[0]]) {
                            
                            dic1=dic;
                        }
                    }
                    [arr removeObject:dic1];
                    [IHUtility saveUserDefaluts:arr key:USERMODEL.userID];
                    NSDictionary *paramets = @{
                                               @"user_id"   :   USERMODEL.userID,
                                               @"group_id"  :   self->_chatGroup.groupId,
                                               };
                    [network httpRequestWithParameter:paramets method:ExitCharGroupUrl success:^(NSDictionary *dic) {
                        NSLog(@"-----  %@",dic);
                    }];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroup" object:nil];
                }
            } onQueue:nil];

        }
        
    }
    
}

//- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error {
//    __weak ChatGroupDetailViewController *weakSelf = self;
//    [weakSelf hideHud];
//    if (error) {
//        if (reason == eGroupLeaveReason_UserLeave) {
//            [weakSelf showHint:@"退出群组失败"];
//        } else {
//            [weakSelf showHint:@"解散群组失败"];
//        }
//    }
//}

- (void)didIgnoreGroupPushNotification:(NSArray *)ignoredGroupList error:(EMError *)error {
    // todo
    NSLog(@"ignored group list:%@.", ignoredGroupList);
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger index = _selectedContact.index;
    if (buttonIndex == 0)
    {
        //delete
        _selectedContact.deleteContact(index);
    }
    else if (buttonIndex == 1)
    {
        //add to black list
        [self showHudInView:self.view hint:NSLocalizedString(@"group.ban.adding", @"Adding to black list..")];
        NSArray *occupants = [NSArray arrayWithObject:[self.dataSource objectAtIndex:_selectedContact.index]];
        __weak ChatGroupDetailViewController *weakSelf = self;
        [[EaseMob sharedInstance].chatManager asyncBlockOccupants:occupants fromGroup:self.chatGroup.groupId completion:^(EMGroup *group, EMError *error) {
            if (weakSelf)
            {
                __weak ChatGroupDetailViewController *strongSelf = weakSelf;
                [strongSelf hideHud];
                if (!error) {
                    strongSelf.chatGroup = group;
                    [strongSelf.dataSource removeObjectAtIndex:index];
                    [strongSelf refreshScrollView];
                }
                else{
                    [strongSelf showHint:error.description];
                }
            }
        } onQueue:nil];
    }
    _selectedContact = nil;
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    _selectedContact = nil;
}


- (void)pushSwitchChanged:(id)sender
{
    if (_isOwner) {
        BOOL toOn = _pushSwitch.isOn;
        [self isIgnoreGroup:!toOn];
    }
    [_tableView reloadData];
    
    [self saveSetting];
}

- (void)blockSwitchChanged:(id)sender
{
    [_tableView reloadData];
    [self saveSetting];
}

#pragma mark - private

- (void)isIgnoreGroup:(BOOL)isIgnore
{
    [self showHudInView:self.view hint:NSLocalizedString(@"group.setting.save", @"set properties")];
    
    __weak ChatGroupDetailViewController *weakSelf = self;
    [[EaseMob sharedInstance].chatManager asyncIgnoreGroupPushNotification:_chatGroup.groupId isIgnore:isIgnore completion:^(NSArray *ignoreGroupsList, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            [weakSelf showHint:NSLocalizedString(@"group.setting.success", @"set success")];
        }
        else{
            [weakSelf showHint:NSLocalizedString(@"group.setting.fail", @"set failure")];
        }
    } onQueue:nil];
}

- (void)saveSetting
{
    if (_blockSwitch.isOn != _chatGroup.isBlocked) {
        __weak typeof(self) weakSelf = self;
        [self showHudInView:self.view hint:NSLocalizedString(@"group.setting.save", @"set properties")];
        if (_blockSwitch.isOn) {
            [[EaseMob sharedInstance].chatManager asyncBlockGroup:_chatGroup.groupId completion:^(EMGroup *group, EMError *error) {
                [weakSelf hideHud];
                [weakSelf showHint:NSLocalizedString(@"group.setting.success", @"set success")];
            } onQueue:nil];
        }
        else{
            [[EaseMob sharedInstance].chatManager asyncUnblockGroup:_chatGroup.groupId completion:^(EMGroup *group, EMError *error) {
                [weakSelf hideHud];
                [weakSelf showHint:NSLocalizedString(@"group.setting.success", @"set success")];
            } onQueue:nil];
        }
    }
    
    if (_pushSwitch.isOn != _chatGroup.isPushNotificationEnabled) {
        [self isIgnoreGroup:!_pushSwitch.isOn];
    }
}
@end
