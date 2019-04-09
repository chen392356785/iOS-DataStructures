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

#import "ChatListViewController.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "EMSearchBar.h"
//#import "NSDate+Category.h"
#import "RealtimeSearchUtil.h"
#import "ChatViewController.h"
#import "EMSearchDisplayController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "RobotManager.h"
#import "FindOutMeViewController.h"
#import "MTCommentForMeListViewController.h"
#import "RecommendChatGroupListViewController.h"
@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate,SRRefreshDelegate, UISearchBarDelegate, IChatManagerDelegate,ChatViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray        *dataSource;

@property (strong, nonatomic) UITableView           *tableView;
@property (nonatomic, strong) EMSearchBar           *searchBar;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@property (nonatomic, strong) UIView                *networkStateView;

@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ChatListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"社区"];
    selDic=[[NSMutableDictionary alloc]init];
    leftbutton.hidden = NO;
    
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    [self removeEmptyConversationsFromDB];

  //  [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
   // [self networkStateView];
//    [self addNavgationItem];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lookMeNotification:) name:@"lookMeNotification" object:nil];
   // [self searchController];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NetworkChanged2:) name:@"networkChanged2" object:nil];
   
  
}




-(void)lookMeNotification:(NSNotification *)notification{
    
     [_topView setData:BadgeMODEL.headArr num:BadgeMODEL.lookMeNum];
    
}


//
//- (void)addNavgationItem
//{
//    UIImage *collectImg = Image(@"clean.png");
//    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    cleanBtn.frame = CGRectMake(30, 0, collectImg.size.width, collectImg.size.height);
//    [cleanBtn setImage:collectImg forState:UIControlStateNormal];
//    [cleanBtn addTarget:self action:@selector(cleanNews) forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem *cleanBarItem = [[UIBarButtonItem alloc] initWithCustomView:cleanBtn];
//
//    self.navigationItem.rightBarButtonItem = cleanBarItem;
//}

- (void)cleanNews
{
    [[EaseMob sharedInstance].chatManager removeAllConversationsWithDeleteMessages:YES append2Chat:YES];
    [self.dataSource removeAllObjects];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"消息列表"];
    [self refreshDataSource];
    [self registerNotifications];
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMessageNum object:nil];
    [_topView setData:BadgeMODEL.headArr num:BadgeMODEL.lookMeNum];
 
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [MobClick endLogPageView:@"消息列表"];
    [self unregisterNotifications];
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

//- (void)removeChatroomConversationsFromDB
//{
//    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
//    NSMutableArray *needRemoveConversations;
//    for (EMConversation *conversation in conversations) {
//        if (conversation.conversationType == eConversationTypeChatRoom) {
//            if (!needRemoveConversations) {
//                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
//            }
//
//            [needRemoveConversations addObject:conversation.chatter];
//        }
//    }
//
//    if (needRemoveConversations && needRemoveConversations.count > 0) {
//        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
//                                                             deleteMessages:YES
//                                                                append2Chat:NO];
//    }
//}

#pragma mark - getter

- (SRRefreshView *)slimeView
{
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor whiteColor];
    }
    
    return _slimeView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WindowWith,iPhoneHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 195)];
         __weak ChatListViewController *weakSelf=self;
        MTTopView *topView = [[MTTopView alloc]initWithFrame:CGRectMake(5, 0, WindowWith-10, 65)];
        topView.clipsToBounds = YES;
        [topView setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:[UIColor clearColor]];
        [topView setData:BadgeMODEL.headArr num:BadgeMODEL.lookMeNum];
        _topView=topView;
        topView.selectBlock=^(NSInteger index)
        {
            [weakSelf pushToFindOut];
        };
        [headView addSubview:topView];
    
      
       
        CommentMeView *topView2=[[CommentMeView alloc]initWithFrame:CGRectMake(5, topView.bottom, WindowWith-10, 65)];
        [topView2 setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:[UIColor clearColor]];
        _topView2=topView2;
        [topView2 setData:BadgeMODEL.commentMeNum];
        topView2.selectBlock=^(NSInteger index)
        {
            [weakSelf pushCommentMe];
        };
        [headView addSubview:topView2];
      
        GroupView *groupView=[[GroupView alloc]initWithFrame:CGRectMake(5, topView2.bottom, WindowWith-10, 65)];
        groupView.selectBlock=^(NSInteger index)
        {
            [weakSelf recommendGroup];
        };
        [headView addSubview:groupView];
        
        _tableView.tableHeaderView=headView;
        
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    }
    
    return _tableView;
}
-(void)recommendGroup{
    RecommendChatGroupListViewController *vc=[[RecommendChatGroupListViewController alloc]init];
    [self pushViewController:vc];
}

-(void)pushCommentMe{
    [_topView2 setData:0];
    MTCommentForMeListViewController *controller=[[MTCommentForMeListViewController alloc]init];
    BadgeMODEL.commentMeNum=0;
    [self pushViewController:controller];
}

-(void)pushToFindOut{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    BadgeMODEL.lookMeNum=0;
    [_topView setData:BadgeMODEL.headArr num:BadgeMODEL.lookMeNum];
    FindOutMeViewController *vc=[[FindOutMeViewController alloc]init];
    [self pushViewController:vc];
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak ChatListViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ChatListCell";
            ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.name = conversation.chatter;
            if (conversation.conversationType == eConversationTypeChat) {
                if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.chatter]) {
                    cell.name = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.chatter];
                }
                cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
            }
            else{
                NSString *imageName = @"Group_head.png";
                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:conversation.chatter]) {
                        cell.name = group.groupSubject;
                        imageName = group.isPublic ? @"Group_head.png" : @"Group_head.png";
                        break;
                    }
                }
                cell.placeholderImage = [UIImage imageNamed:imageName];
            }
            cell.detailMsg = [weakSelf subTitleMessageByConversation:conversation];
            cell.time = [weakSelf lastMessageTimeByConversation:conversation];
            cell.unreadCount = [weakSelf unreadMessageCountByConversation:conversation];
//            if (indexPath.row % 2 == 1) {
//                cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
//            }else{
//                cell.contentView.backgroundColor = [UIColor whiteColor];
//            }
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [weakSelf.searchController.searchBar endEditing:YES];
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:conversation.chatter conversationType:conversation.conversationType];
            chatVC.title = conversation.chatter;
            [weakSelf.navigationController pushViewController:chatVC animated:YES];
        }];
    }
    
    return _searchController;
}



- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = sysFont(15);
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];

    NSArray* sorte = [conversations sortedArrayUsingComparator:
           ^(EMConversation *obj1, EMConversation* obj2){
               EMMessage *message1 = [obj1 latestMessage];
               EMMessage *message2 = [obj2 latestMessage];
               if(message1.timestamp > message2.timestamp) {
                   return(NSComparisonResult)NSOrderedAscending;
               }else {
                   return(NSComparisonResult)NSOrderedDescending;
               }
           }];
    
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableArray *Arr=[[NSMutableArray alloc]initWithArray:[[EaseMob sharedInstance].chatManager fetchMyGroupsListWithError:nil]];
    for (NSInteger i=0;i<sorte.count;i++) {
        EMConversation *conversation=sorte[i];
        [arr addObject:conversation.chatter];
        
    }
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
  
    for (NSInteger i=0;i<Arr.count;i++) {
        EMGroup *group=Arr[i];
        for (NSString *groupId in arr) {
            if ([groupId isEqualToString:group.groupId]) {
                [arr1 addObject:group];
            }
        }
    }
    if (arr1.count>0) {
        for (EMGroup *group in arr1) {
            [Arr removeObject:group];
        }
        
    }
    
  
    
    [ret addObjectsFromArray:Arr];

    
    return ret;
}

//被踢出群
- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error{
    
    if (!error) {
        
        NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[IHUtility getUserdefalutsList:USERMODEL.userID]];
        NSDictionary *dic1=nil;
        for (NSDictionary *dic in arr) {
            if ([group.groupId isEqualToString:dic.allKeys[0]]) {
                
                dic1=dic;
            }
        }
        [arr removeObject:dic1];
        [IHUtility saveUserDefaluts:arr key:USERMODEL.userID];
        
    }
   

    
    
}



// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                if ([[RobotManager sharedInstance] isRobotMenuMessage:lastMessage]) {
                    ret = [[RobotManager sharedInstance] getRobotMenuMessageDigest:lastMessage];
                } else {
                    ret = didReceiveText;
                }
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            default: {
            } break;
        }
    }
    return ret;
}

#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"chatListCell";
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    
    if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[EMConversation class]]) {
        
          EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
        
        EMMessage *lastMessage = [conversation latestMessage];;
        
        NSDictionary *extDic=lastMessage.ext;
        
        if (conversation.conversationType == eConversationTypeChat) {
            if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.chatter]) {
                cell.name = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.chatter];
            }
            
            cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
            
            if (extDic==nil) {
                if ([conversation.chatter isEqualToString:@"1"]) {
                    //                cell.imageURL=[NSURL URLWithString:[userDic objectForKey:kToHeadImage]];
                    //                cell.name = [userDic objectForKey:kToNickName];
                }else{
                    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
                    NSDictionary *userDic=[dic objectForKey:conversation.chatter];
                    cell.imageURL=[NSURL URLWithString:[userDic objectForKey:kToHeadImage]];
                    cell.name = [userDic objectForKey:kToNickName];
                }
            }else if ([conversation.chatter isEqualToString:@"1"]){ //系统通知
                NSString *kfromID=[[extDic objectForKey:kFromeUserID] lowercaseString];
                if ([conversation.chatter isEqualToString:kfromID]) {
                    cell.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,extDic[kFromeHeadImage]]];
                    cell.name = [extDic objectForKey:kFromeNickName];
                }else{
                    cell.imageURL=[NSURL URLWithString:extDic[kToHeadImage]];
                    cell.name = [extDic objectForKey:kToNickName];
                }
            }
            else{
                NSString* fromID=[extDic[kFromeUserID] lowercaseString];
                
                NSString *userHX=USERMODEL.hxUserName;
                if ([userHX  isEqualToString:fromID]) {
                    if ([extDic objectForKey:kToHeadImage]==nil || [extDic objectForKey:kToNickName]==nil) {
                        NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
                        NSDictionary *userDic=[dic objectForKey:conversation.chatter];
                        cell.imageURL=[NSURL URLWithString:[userDic objectForKey:kToHeadImage]];
                        cell.name = [userDic objectForKey:kToNickName];
                    }else{
                        cell.imageURL=[NSURL URLWithString:[extDic objectForKey:kToHeadImage]];
                        cell.name = [extDic objectForKey:kToNickName];
                    }
                }else{
                    if ([extDic objectForKey:kToHeadImage]==nil || [extDic objectForKey:kToNickName]==nil) {
                        NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
                        NSDictionary *userDic=[dic objectForKey:conversation.chatter];
                        cell.imageURL=[NSURL URLWithString:[userDic objectForKey:kToHeadImage]];
                        cell.name = [userDic objectForKey:kToNickName];
                    }else{
                        
                        cell.imageURL=[NSURL URLWithString:[extDic objectForKey:kFromeHeadImage]];
                        cell.name = [extDic objectForKey:kFromeNickName];
                    }
                }
            }
        }
        else{
            NSString *imageName = @"Group_head.png";
            if (![conversation.ext objectForKey:@"groupSubject"] || ![conversation.ext objectForKey:@"isPublic"])
            {
                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:conversation.chatter]) {
                        cell.name = group.groupSubject;
                         cell.imageURL=nil;
                        imageName = group.isPublic ? @"Group_head.png" : @"Group_head.png";
                        
                        NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                        [ext setObject:group.groupSubject forKey:@"groupSubject"];
                        [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                        conversation.ext = ext;
                        break;
                    }
                }
            }
            else
            {
                cell.imageURL=nil;
                cell.name = [conversation.ext objectForKey:@"groupSubject"];
                imageName = [[conversation.ext objectForKey:@"isPublic"] boolValue] ? @"Group_head.png" : @"Group_head.png";
            }
            cell.placeholderImage = [UIImage imageNamed:imageName];
        }
        cell.textLabel.textColor=cBlackColor;
        cell.textLabel.font=sysFont(15);
        
        
        cell.detailMsg = [self subTitleMessageByConversation:conversation];
        cell.time = [self lastMessageTimeByConversation:conversation];
        cell.unreadCount = [self unreadMessageCountByConversation:conversation];
        
    }else if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[EMGroup class]]){
        
        EMGroup *EMGroup=[self.dataSource objectAtIndex:indexPath.row];
        
        cell.name=EMGroup.groupSubject;
        cell.placeholderImage=Image(@"Group_head.png");
        cell.textLabel.textColor=cBlackColor;
        cell.textLabel.font=sysFont(15);
         cell.imageURL=nil;
         cell.detailMsg=@"";
        cell.unreadCount=0;
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
//        cell.time=[currentDate timeIntervalDescription];
        cell.time = dateString;
        
    }
//    if (indexPath.row % 2 == 1) {
//        cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
//    }else{
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[EMConversation class]]){
        
        EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
        ChatViewController *chatController;
        NSString *title = conversation.chatter;
        
        NSString *chatter = conversation.chatter;
        chatController = [[ChatViewController alloc] initWithChatter:chatter conversationType:conversation.conversationType];
        chatController.delelgate = self;
        
        
        
        
        chatType=conversation.conversationType;
        if (conversation.conversationType != eConversationTypeChat) {
            if ([[conversation.ext objectForKey:@"groupSubject"] length])
            {
                title = [conversation.ext objectForKey:@"groupSubject"];
            }
            else
            {
                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:conversation.chatter]) {
                        title = group.groupSubject;
                        break;
                    }
                }
            }
            chatController.nickName =title;
            
            NSArray *arr=[conversation loadAllMessages];
            NSDictionary *dic2=[IHUtility getUserDefalutsDicKey:kMessageDic];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:dic2];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作
                if (arr.count<100) {
                    for (EMMessage *message in arr) {
                        NSDictionary *ext=message.ext;
                        NSString *userID= [ext[kFromeUserID] lowercaseString];
                        
                        NSDictionary* ext2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSString stringWithFormat:@"%@",userID],kFromeUserID,
                                              ext[kFromeNickName],kFromeNickName,
                                              ext[kFromeHeadImage],kFromeHeadImage,
                                              nil];
                        [dic setObject:ext2 forKey:[NSString stringWithFormat:@"%@",userID]];
                    }
                    [IHUtility setUserDefaultDic:dic key:kMessageDic];
                }else {
                    for (NSInteger i=arr.count-100; i<arr.count;i++) {
                        EMMessage  *msg=arr[i];
                        NSDictionary *ext=msg.ext;
                        NSString *userID= [ext[kFromeUserID] lowercaseString];
                        NSDictionary* ext2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSString stringWithFormat:@"%@",userID],kFromeUserID,
                                              ext[kFromeNickName],kFromeNickName,
                                              ext[kFromeHeadImage],kFromeHeadImage,
                                              nil];
                        [dic setObject:ext2 forKey:[NSString stringWithFormat:@"%@",userID]];
                    }
                    [IHUtility setUserDefaultDic:dic key:kMessageDic];
                }

            
            });
            
            
            
            
        }else if (conversation.conversationType == eConversationTypeChat) {
            EMMessage *lastMessage = [conversation latestMessage];;
            
            NSDictionary *extDic=lastMessage.ext;
            
            
            [selDic setDictionary:extDic];
            
            
            //  chatController.nickName=[extDic objectForKey:@"nickName"];
            // chatController.title = title;
            
            if (extDic==nil) {
                
                NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
                NSDictionary *userDic=[dic objectForKey:chatter];
                chatController.nickName =[userDic objectForKey:kToNickName];
                chatController.HeadimgUrl=[userDic objectForKey:kToHeadImage];
                chatController.toUserID=[userDic objectForKey:kToUser_ID];
            }else if ([conversation.chatter isEqualToString:@"1"]){// 系统通知
                NSString *kfromID=[extDic objectForKey:kFromeUserID];
                
                if ([conversation.chatter isEqualToString:kfromID]) {
                    
                    
                    chatController.HeadimgUrl= [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,extDic[kFromeHeadImage]] ;
                    chatController.nickName = [extDic objectForKey:kFromeNickName];
                }else{
                    chatController.HeadimgUrl=extDic[kToHeadImage];
                    chatController.nickName = [extDic objectForKey:kToNickName];
                }
            }
            else{
                NSString * fromID=[extDic[kFromeUserID] lowercaseString];
                if ([USERMODEL.hxUserName isEqualToString:fromID]) {
                    chatController.nickName = [extDic objectForKey:kToNickName];
                    chatController.HeadimgUrl=[extDic objectForKey:kToHeadImage];
                    chatController.toUserID=[extDic objectForKey:kToUser_ID];
                }else{
                    chatController.nickName =[extDic objectForKey:kFromeNickName];
                    chatController.HeadimgUrl=[extDic objectForKey:kFromeHeadImage];
                    chatController.toUserID=[extDic objectForKey:kFromeUser_ID];
                }
            }
            
        }
        
        if ([[RobotManager sharedInstance] getRobotNickWithUsername:chatter]) {
            chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:chatter];
        }
        [self pushViewController:chatController];
        
    }else if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[EMGroup class]]){
        
        EMGroup *EMGroup=[self.dataSource objectAtIndex:indexPath.row];
        ChatViewController *chatController;
        NSString *title = EMGroup.groupSubject;
        
        NSString *chatter = EMGroup.groupId;
        chatController = [[ChatViewController alloc] initWithChatter:chatter conversationType:eConversationTypeGroupChat];
        chatController.delelgate = self;
         chatController.nickName =title;
        [self pushViewController:chatController];

    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[EMConversation class]]){
            EMConversation *converation = [self.dataSource objectAtIndex:indexPath.row];
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES append2Chat:YES];
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

        }else if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[EMGroup class]]){
              EMGroup *EMGroup=[self.dataSource objectAtIndex:indexPath.row];
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:EMGroup.groupId deleteMessages:YES append2Chat:NO];
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            
        }
        
           }
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    __weak typeof(self) weakSelf = self;
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataSource searchText:(NSString *)searchText collationStringSelector:@selector(chatter) resultBlock:^(NSArray *results) {
        if (results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.searchController.resultsSource removeAllObjects];
                [weakSelf.searchController.resultsSource addObjectsFromArray:results];
                [weakSelf.searchController.searchResultsTableView reloadData];
            });
        }
    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate
//刷新消息列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self refreshDataSource];
    [_slimeView endRefresh];
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"lookMeNotification" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"networkChanged2" object:nil];
}

#pragma mark - public

-(void)refreshDataSource
{
    self.dataSource = [self loadDataSource];
    
    
    [_tableView reloadData];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
    //    _tableView.tableHeaderView = _networkStateView;
    }
    else{
    //    _tableView.tableHeaderView = nil;
    }

}

-(void)NetworkChanged2:(NSNotification *)notification{
    NSNumber *number=[notification object];
    EMConnectionState connectionState=[number intValue];
    [self networkChanged:connectionState];
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
       // _tableView.tableHeaderView = _networkStateView;
    }
    else{
     //   _tableView.tableHeaderView = nil;
    }
}

- (void)willReceiveOfflineMessages{
    NSLog(NSLocalizedString(@"message.beginReceiveOffine", @"Begin to receive offline messages"));
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self refreshDataSource];
}

- (void)didFinishedReceiveOfflineMessages{
    NSLog(NSLocalizedString(@"message.endReceiveOffine", @"End to receive offline messages"));
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    
    
    if (chatType==eConversationTypeChat) {
        if (selDic.allKeys.count==0) {
            NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
            NSDictionary *userDic=dic[chatter];
            if (userDic!=nil) {
                return userDic[kToHeadImage];
            }
        }
        
        
        
        NSString *userID=[[selDic objectForKey:kFromeUserID] lowercaseString];
        NSString *touserID=[[selDic objectForKey:kToUserID] lowercaseString];
        if ([userID isEqualToString:chatter]) {
            if ([chatter isEqualToString:@"1"]) {        //系统通知
                return  [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,selDic[kFromeHeadImage]] ;
            }
            return selDic[kFromeHeadImage];
        }else if([touserID isEqualToString:chatter]){
            return selDic[kToHeadImage];
        }else if ([chatter isEqualToString:USERMODEL.hxUserName]){
            return USERMODEL.userHeadImge80;
        }

    }else if (chatType==eConversationTypeGroupChat){
        if ([chatter isEqualToString:USERMODEL.hxUserName]){
            return USERMODEL.userHeadImge80;
        }else {
            NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
            NSDictionary *userDic=dic[chatter];
            if (userDic!=nil) {
                return userDic[kFromeHeadImage];
            }
        }
 
    }
 
    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    if (chatType==eConversationTypeChat) {
        NSString *userID=[selDic objectForKey:kFromeUserID];
        if ([userID isEqualToString:chatter]) {
            return selDic[kFromeNickName];
        }else{
            return USERMODEL.nickName;
        }
        
        return chatter;
    }else if (chatType==eConversationTypeGroupChat){
        if ([chatter isEqualToString:USERMODEL.hxUserName]){
            return USERMODEL.nickName;
        }else {
            NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kMessageDic];
            NSDictionary *userDic=dic[chatter];
            if (userDic!=nil) {
                return userDic[kFromeNickName];
            }
        }
        
    }
    
    return nil;
    
}

@end
