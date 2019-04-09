//
//  MTBaseTableView.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTBaseTableView.h"

@implementation MTBaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setupData:(NSArray *)data index:(int)index{
    if (self.datasource!=nil) {
        //      [datasource release];
        self.datasource=nil;
    }
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.styleIndex=index;
    if (self.datasource==nil) {
        if (index==1) {//地图标注列表
            self.datasource=[[MapUserListDataSource alloc] init];
            
        }else if (index==2)//供求列表
        {   GongQiuListDataSource *Datasource=[[GongQiuListDataSource alloc]init];
            Datasource.type=self.type;
            Datasource.personType=self.personType;
            self.datasource=Datasource;
           
        }else if (index==3)//评论列表
        {
            self.datasource=[[GongQiuDetailsListDataSource alloc]init];
        }else if (index==4)//话题列表
        {
            
            GuangChangTopicDataSource *Datasource=[[GuangChangTopicDataSource alloc]init];
            Datasource.type=self.type;
            self.datasource=Datasource;
        }else if (index==5)//人脉列表
        {
           MTContactDataSource *Datasource=[[MTContactDataSource alloc]init];
            Datasource.type=self.type2;
            
            self.datasource=Datasource;
           
        }else if (index==7){//评论我的
            self.datasource=[[CommentForMeListDataSource alloc]init];
  
        }else if (index==8)//地图搜索列表
        {
            
            self.datasource=[[MapSearchListDataSource alloc]init];
        }else if (index==9)//看过我的人
        {
            self.datasource=[[FindOutListDataSource alloc]init];
        }else if (index==10)//省份列表
        {   
            self.datasource=[[ProvinceListDataSource alloc]init];;
        }else if (index==11)//城市列表
        {
            self.datasource=[[CityListDataSource alloc]init];
        }
        else if (index==12){  //我收藏的供应 求购
            MTMyCollectionSupplyAndBuyDataSource* Datasource=[[MTMyCollectionSupplyAndBuyDataSource alloc]init];
             Datasource.type=self.type;
            self.datasource=Datasource;
        }else if (index==13){ //我收藏的 话题
            MTMyCollectionTopicDataSource *Datasource=[[MTMyCollectionTopicDataSource alloc]init];
            Datasource.type=self.type;
            self.datasource=Datasource;
        }else if (index==14){  //主页 供应 ，求购
            MTOtherChildSupplyBuyDataSource *Datasource=[[MTOtherChildSupplyBuyDataSource alloc]init];
            Datasource.type=self.type;
            self.datasource=Datasource;

        }else if (index==15){

            MTOtherChildTopicListDataSource *Datasource=[[MTOtherChildTopicListDataSource alloc]init];
            Datasource.isMe=self.isMe;
            self.datasource=Datasource;
           
           
        }else if (index==16){
            self.datasource=[[MTMeListDataSource alloc]init];
            
            MTMeListDataSource *dataSource=[[MTMeListDataSource alloc]init];
            dataSource.ifMe=self.isMe;
            self.datasource=dataSource;
            
            
        }else if (index==17)
        {
            //行业资讯
            self.datasource=[[MTNewsDataSource alloc]init];
            
        }else if (index==18){
            MtActivityDataSource *dataSource = [[MtActivityDataSource alloc] init];
            dataSource.actvType = self.actvType;
            self.datasource = dataSource;
        }else if (index==19){
            self.datasource=[[MTIdentDataSource alloc]init];
        }else if (index==20){ //主题
            self.datasource=[[MTThemeListDataSource alloc]init];

        }else if (index==21){
            self.datasource=[[MTlogisticsFindCarDataSource alloc]init];
        }else if (index==22){
            self.datasource=[[MTlogisticsFindGoodsDataSource alloc]init];
        }else if (index==25){
            self.datasource=[[MTNewTopicDataSource alloc]init];
        }else if (index==24){
            self.datasource=[[HomePageDataSource alloc]init];
            

        }else if (index==23){
            self.datasource=[[MTActivtiesClikeDataSource alloc]init];

        }else if (index==26){
            self.datasource = [[MTRecommentDataSource alloc] init];
        }else if (index == 29){
            //企业云
             self.datasource=[[EPCloudDataSource alloc]init];
        }else if (index == 28){
             self.datasource=[[CompanyTrackDataSource alloc]init];
        }else if (index==27){
            self.datasource=[[EPCloudCumlativeDataSource alloc]init];

        }else if (index == 30){
            self.datasource=[[EPCloudCommentListDataSource alloc]init];


        }else if (index ==33){
            self.datasource=[[EPCloudConnectionDataSource alloc]init];
        }else if (index==32){
            self.datasource=[[EPCloudFansDataSource alloc]init];

        }else if (index == 31){
            self.datasource=[[InvitedFriendsDataSource alloc]init];

        }else if (index == 34)
        {
            self.datasource=[[BindCompanyListDataCell alloc]init];

        }else if (index==35){
            self.datasource=[[MTNewSupplyAndBuyDataSoure alloc]init];
        }else if (index==36){
            self.datasource=[[MTChartsDataSource alloc]init];
        }else if (index==37){
            self.datasource=[[CrowdFundingDataSource alloc]init];//众筹
        }else if (index == 38){
            self.datasource = [[EPCloudCompanyDataSource alloc] init];
        }else if (index==39){
           ZhaoPingDataSource *Datasource = [[ZhaoPingDataSource alloc] init];//招聘
            Datasource.Mytype=self.Mytype;
            self.datasource=Datasource;
            
        }else if (index ==40){
            JobWantedDataSource *dataSource = [[JobWantedDataSource alloc] init];//求职
            dataSource.type = self.type;
            self.datasource = dataSource;


        }else if (index==41){
            self.datasource=[[CurriculumVitaeDataSource alloc]init];//简历详情
        }else if (index==42){
            
            self.datasource= [[MyPositionDataSource alloc]init];
        }else if (index==43){
            self.datasource=[[ChoosePositionDataSource alloc]init];//选择职位 
        }else if (index==44){
            self.datasource=[[SearchPositionDataSource alloc]init];//搜索职位
        }else if (index==45){
            self.datasource=[[NewECloudConnectionSearchDataSource alloc]init];//搜索历史
        }else if (index==46){
           QuestionDataSource *dataSoure=[[QuestionDataSource alloc]init];//问吧首页
            dataSoure.integer=self.i;
            self.datasource=dataSoure;

        }else if (index==48){
            self.datasource=[[AskBarContentDataSource alloc]init];//问吧
        }else if(index==47){
            QuestionCommentDataSource *Datasource=[[QuestionCommentDataSource alloc]init];//问吧评论cell
            Datasource.type = self.personType;//ENT_Other 为评论列表 ENT_self 为为回复的问题
            self.datasource = Datasource;

        }else if (index==49){
            MyReleaseSupplyOrBuyDataSource *dataSource=[[MyReleaseSupplyOrBuyDataSource alloc]init];
            dataSource.type=self.buyType;//我的发布供求
            self.datasource=dataSource;
        }else if (index==50){
            self.datasource=[[MyReleaseTopicDataSource alloc]init];//我的发布话题
        }else if (index==51){
            self.datasource=[[MyReleaseQuestionDataSource alloc]init];//我的发布问吧
        }else if (index==52){
            self.datasource=[[NurseryDataSource alloc]init];//苗木云列表
        }else if (index==53){
            self.datasource=[[MyNerseryDataSource alloc]init];//我的苗木云
        }else if (index==54){
            self.datasource=[[NewsSearchDataSource alloc]init];//搜索资讯结果
        }else if (index==56){
            self.datasource=[[ScoreHistoryDataSource alloc]init];//积分兑换记录
        }else if (index==55){
            self.datasource=[[ScoreDataSource alloc]init];

        }else if (index==57){
            self.datasource=[[ScoreConvertDataSource alloc]init];//积分明细记录
        }else if (index==58){
            self.datasource=[[NerseryLeftDataSource alloc]init];//苗木云左边tableview
        }else if (index==59){
            self.datasource=[[RecommendGroupDataSource alloc]init]; //推荐圈子
            
        }else if (index==60){
            self.datasource=[[FindCarDataSource alloc] init];//找车
        }else if (index==61){
            self.datasource=[[LogisicsMyFaBuDataSource alloc] init];//我的发布
        }else if (index==62){
            self.datasource=[[DriverCheYuanDataSource alloc]init];//车主的车源
        }else if (index==63){
            self.datasource=[[DriverRenZhengDataSource alloc]init];//车主的认证信息
        }
            
    }
    self.datasource.attributes=self.attribute;
    self.datasource.allowEdit=self.allowEdit;
    self.datasource.datasource=data;
    self.table.backgroundView=nil;
    self.table.backgroundColor=[UIColor clearColor];
    self.table.dataSource=self.datasource;
    if (self.datasource!=nil) {
        [self.table reloadData];
    }
    
    
}


//
//-(float)getCellHeight{
//    int index=self.styleIndex;
//    if (index==1) {
//        self.tableViewCellHeight=44;
//    }else if (index==2)
//    {
//        self.tableViewCellHeight=495;
//
//    }else if (index==3)
//    {
//        self.tableViewCellHeight=70;
//    }else if (index==4)
//    {
//        self.tableViewCellHeight=500;
//    }else if(index==5)
//    {
//        self.tableViewCellHeight=70;
//    }else if (index==6)
//    {
//        self.tableViewCellHeight=489;
//    }
//
//    return self.tableViewCellHeight;
//}



@end
