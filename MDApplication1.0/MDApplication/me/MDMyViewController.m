//
//  MDMyViewController.m
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMyViewController.h"
#import "ChatRoomCell.h"
#import "Masonry.h"
#import "MyModel.h"
#import "MyContentModel.h"
#import "DoubleLabelView.h"
#import "MDDiscipleDetailViewController.h"
#import "MDReciveDetailViewController.h"
#import "AppDelegate.h"
#import "JYSlideSegmentController.h"
#import "CustomSegmentController.h"
#import "RankingViewController.h"
#import "ViewControllerFactory.h"
#import "MDSettingViewController.h"
#import "RewardInfo.h"
#import "UIWindow+RedPacket.h"
@interface MyHeadView : UICollectionReusableView
- (void) setLabelText:(NSString *)text;
@property (strong, nonatomic) UILabel *label;
@property (strong,nonatomic)UIImageView *backgroundImage;
@property (strong,nonatomic)DoubleLabelView *balanceLabel;
@property (strong,nonatomic)DoubleLabelView *incomeLabel;
@property (strong,nonatomic)DoubleLabelView *studentLabel;
@property (strong,nonatomic)UILabel *incomeTitle;
@property (strong,nonatomic)UILabel *todayLabel;
@property (strong,nonatomic)UIButton *settingButton;

@property (strong,nonatomic)NSArray *line1;

@end


@implementation MyHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //        self.label = [[UILabel alloc] init];
        //        self.label.font = [UIFont systemFontOfSize:18];
        //        [self addSubview:self.label];
       
        [self setUpView];
        
        [self setUpConstriant];
        
    }
    return self;
}

- (UILabel *)todayLabel{
    if(!_todayLabel){
        _todayLabel = [[UILabel alloc]init];
        _todayLabel.font = [UIFont systemFontOfSize:50.0f];
        _todayLabel.textColor  =[UIColor whiteColor];
        
        _todayLabel.textAlignment = NSTextAlignmentCenter;
         _todayLabel.text = @"156.00";
    }
    return _todayLabel;
}

- (UILabel *)incomeTitle{
    if(!_incomeTitle){
        _incomeTitle = [[UILabel alloc]init];
        _incomeTitle.font = [UIFont systemFontOfSize:14.0];
        _incomeTitle.text = @"今日收入(元)";
        _incomeTitle.textColor  =[UIColor whiteColor];
        _incomeTitle.textAlignment = NSTextAlignmentCenter;
        _incomeTitle.textColor  =[UIColor whiteColor];
        
    }
    return _incomeTitle;
}

- (UIImageView *)backgroundImage{
    if(!_backgroundImage){
       
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.image = [UIImage imageNamed:@"w"];
    }
    
    return _backgroundImage;


}
- (UIButton *)settingButton{
    if(!_settingButton){
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingButton setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
   
    
    }
    return _settingButton;
}


- (void)setUpConstriant{
    
    WS(weakSelf);
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
        //        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(0);
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.height.width.equalTo(@24);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
//        make.centerX.equalTo(weakSelf.mas_centerX);
        
    }];
    
    [self.incomeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(20);
        make.height.equalTo(@15);
        make.left.right.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.mas_centerX);
        
    }];
    
    [self.todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.incomeTitle.mas_bottom).offset(5);
        make.height.equalTo(@50);
        make.left.right.equalTo(weakSelf);

        make.centerX.equalTo(weakSelf.mas_centerX);
        
    }];
    
    [_line1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.height.equalTo(@45);
    }];

}


- (void)setUpView
{
    self.backgroundColor = [UIColor whiteColor];
     [self addSubview:self.backgroundImage];
     [self addSubview:self.incomeTitle];
     [self addSubview:self.todayLabel];
     [self addSubview:self.settingButton];
    _balanceLabel = [[DoubleLabelView alloc]init];
    _balanceLabel.firstLabel.text = @"18.57";
      _balanceLabel.lastLabel.text = @"余额(元)";
    [self addSubview:_balanceLabel];
    _incomeLabel = [[DoubleLabelView alloc]init];
    [self addSubview:_incomeLabel];
    
    _incomeLabel.firstLabel.text = @"11.57";
    _incomeLabel.lastLabel.text = @"总收入(元)";
    _studentLabel = [[DoubleLabelView alloc]init];
    [self addSubview:_studentLabel];
    
    _studentLabel.firstLabel.text = @"5";
    _studentLabel.lastLabel.text = @"徒弟数量";
     _line1 = [NSArray arrayWithObjects:_balanceLabel,_incomeLabel,_studentLabel,nil];
}


@end

@interface MDMyViewController ()
@property (nonatomic,strong)MyModel *myModel;
@end

@implementation MDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myModel = [[MyModel alloc]init];
    [self getContent];
    
    
    [self.view addSubview:self.collection];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)getContent {
    
    
    //格式化成json数据
    id jsonObject = [AMTools getLocalJsonDataWithFileName:@"my"];
    if(jsonObject){
        
        _myModel = [MyModel mj_objectWithKeyValues:[jsonObject objectForKey:@"data"]];
        
//        [self setViewControllers:contentItems];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addConstraint{

}

- (UICollectionView *)collection{
    if(!_collection){
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        _collection.backgroundColor = UIColorFromRGB(0xe7e6e5);
        _collection.alwaysBounceVertical = YES;
       
//        _collection.
        [_collection registerClass:[ChatRoomCell class] forCellWithReuseIdentifier:@"myCell"];
        [_collection registerClass:[MyHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hxwHeader"];
        _collection.delegate = self;
        _collection.dataSource = self;
    }
    
    return _collection;
    
    
}
#pragma mark UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _myModel.list.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChatRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
//    cell.titleLabel.text = @"测试测试";
    MyContentModel *content = [_myModel.list objectAtIndex:indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:content.imageurl];
    cell.titleLabel.text = content.modulename;
  
    return cell;
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MyHeadView *headView;
    
    if([kind isEqual:UICollectionElementKindSectionHeader])
    {
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hxwHeader" forIndexPath:indexPath];
        if(indexPath.section == 0 ){
            headView.label.text = @"头部";
        }
        headView.todayLabel.text = _myModel.todayincome;
        headView.balanceLabel.firstLabel.text = _myModel.discipleincome;
        headView.incomeLabel.firstLabel.text = _myModel.allincome;
        headView.studentLabel.firstLabel.text = _myModel.disciplenum;
        [headView.settingButton addTarget:self action:@selector(SettingClick) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
        [headView.studentLabel addGestureRecognizer:myTap];
    }
    return headView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyContentModel *model = [_myModel.list objectAtIndex:indexPath.row];
    if([model.moduletype isEqualToString:@"1"]){

        NSArray *arr = @[@"全部",@"收徒明细",@"阅读明细",@"其他奖励"];
        NSMutableArray *vcs = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
      
        UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
        MDReciveDetailViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDReciveDetailViewController"];
              myContr.title = [arr objectAtIndex:i];
            [vcs addObject:myContr];
        }
        JYSlideSegmentController *slideSegmentController = [[JYSlideSegmentController alloc] initWithViewControllers:vcs];
        slideSegmentController.title = @"资金明细";
        //  self.slideSegmentController.indicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        slideSegmentController.indicatorColor = UIColorFromRGB(0xcc3333);
        slideSegmentController.itemWidth = FRAME_WIDTH/4;
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:slideSegmentController animated:YES];
        return;
    }
    if([model.moduletype isEqualToString:@"3"]){
        RewardInfo *info = [[RewardInfo alloc] init];
        info.money = 0.03;
        info.rewardName = @"(每日一次签到抽奖机会)";
        info.rewardContent = @"已奖励到你的账户";
        info.rewardStatus = 0;
        //
        [[UIApplication sharedApplication].keyWindow initRedPacketWindowNeedOpen:info];
        return ;
    }
    
    if([model.moduletype isEqualToString:@"6"]){
        NSArray *arr = @[@"分享榜",@"阅读榜",@"收入榜"];
        NSMutableArray *vcs = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            
//            UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
//            MDDiscipleDetailViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDDiscipleDetailViewController"];
        RankingViewController *myContr = [[RankingViewController alloc]init];
      

        myContr.title = [arr objectAtIndex:i];
        [vcs addObject:myContr];
        }
        CustomSegmentController *slideSegmentController = [[CustomSegmentController alloc] initWithViewControllers:vcs];
        slideSegmentController.title = @"排行榜";
        //  self.slideSegmentController.indicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        slideSegmentController.indicatorColor = [UIColor clearColor];
        slideSegmentController.itemWidth = FRAME_WIDTH/4;
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:slideSegmentController animated:YES];
        return;
    }
    
    if([model.moduletype isEqualToString:@"2"]){
    
        BaseViewController *vc = [ViewControllerFactory TabMenuFactoryCreateViewControllerWithType:kWebViewController];
       
       
        vc.url = model.url;
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
        return;
    }
    if([model.moduletype isEqualToString:@"7"]){
     BaseViewController *vc = [ViewControllerFactory TabMenuFactoryCreateViewControllerWithType:kMDApprenticeViewController];
    
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
        return;
    }
    
    if([model.moduletype isEqualToString:@"5"]){
        BaseViewController *vc = [ViewControllerFactory TabMenuFactoryCreateViewControllerWithType:kMDInfomationViewController];
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
        return;
    }
    
    
    
    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
    MDDiscipleDetailViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDDiscipleDetailViewController"];
    
    
    
     if(indexPath.section==1&&indexPath.row==2){
        myContr.enterType = MD_Disciple;
        
    } if(indexPath.section==1&&indexPath.row==3){
        myContr.enterType = MD_DiscipleUp;
    }
    
    
    if(indexPath.section==2&&indexPath.row==1){
        myContr.enterType = MD_DepositT;
    }

    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];
  
}
#pragma mark UICollectionViewFlowLayoutDelegate
//元素大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(iPhone5){
        return CGSizeMake(106, 90);
    }
    else if(iPhone6Pus){
        
        return CGSizeMake(137, 117);
        
    }
    return CGSizeMake(124, 106);
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {kScreenWidth,140};
    return size;
}
//
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
       int temp = 0;
    if(iPhone5){
        temp = 12.5;
    }else if (iPhone6){
        temp =26.25;
    }else if (iPhone6Pus){
        temp =36;
    }else {
        temp = 12.5;
    }
    
    
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

- (void)SettingClick{
    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDSettingViewController" bundle:nil];
    MDSettingViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDSettingViewController"];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];
}

- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    NSLog(@"111");
    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
    MDDiscipleDetailViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDDiscipleDetailViewController"];
    myContr.enterType = MD_Disciple;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];


}
@end
