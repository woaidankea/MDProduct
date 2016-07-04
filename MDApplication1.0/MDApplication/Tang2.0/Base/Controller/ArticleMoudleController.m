//
//  ArticleMoudleController.m
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "ArticleMoudleController.h"
#import "ContentModel.h"
#import "ViewControllerFactory.h"
#import "BaseViewController.h"
#import "AMTools.h"
#import "UIButton+CenterImageAndTitle.h"
#import "RewardInfo.h"
#import "UIWindow+ShareSucAlert.h"
#import "TDColclassRequest.h"
#import "UUProgressHUD.h"
#import "MMTService.h"
#import "JYSlideSegmentController.h"
#import "MDReciveDetailViewController.h"
#import "AppDelegate.h"
#import "IndexbalRequest.h"
@interface ArticleMoudleController ()
@property (nonatomic,strong)UIButton *backButton;
@end

@implementation ArticleMoudleController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
//    if(!USER_DEFAULT_KEY(@"token")){
//        [self setrightLogin];
//    }else{
//        
//        [self setrightBar];
//        
//        
//    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setleftBar];
    
    if(!USER_DEFAULT_KEY(@"token")){
        [self setrightLogin];
    }else{
        
        [self setrightBar];
        IndexbalRequest *request = [[IndexbalRequest alloc]initColsuccess:^(AMBaseRequest *request) {
            NSString *balance =[[request.responseObject objectForKey:@"member"]objectForKey:@"balance"];
            [_backButton setTitle:[NSString stringWithFormat:@"%.2f",[balance floatValue]]
                         forState:UIControlStateNormal];
            [_backButton horizontalCenterTitleAndImageRight:5];
        } failure:^(AMBaseRequest *request) {
            
        }];
        [request start];
        
    }
    
    
   
    

    // Do any additional setup after loading the view.
}

- (void)setrightLogin{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
//    [backButton setImage:[UIImage imageNamed:@"jinbi"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton setTitle:@"登录" forState:UIControlStateNormal];
    
//    [backButton horizontalCenterTitleAndImageRight:5];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -17;
    
    
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem,nil];
    
}


- (void)setrightBar{
     _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [_backButton setImage:[UIImage imageNamed:@"jinbi"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_backButton setTitle:@"" forState:UIControlStateNormal];

    [_backButton horizontalCenterTitleAndImageRight:5];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -17;
    
    
    
    
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem,nil];

}
- (void)rightClick{
//    RewardInfo *info = [[RewardInfo alloc] init];
//    info.money = 0.03;
//    //                info.rewardName = @"分享成功获得";
//    //                info.rewardContent = @"恭喜你得到奖励";
//    //                info.rewardStatus = 0;
//    //
//    [[UIApplication sharedApplication].keyWindow initRedPacketWindow1:info];
      if(!USER_DEFAULT_KEY(@"token")){
        [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
      }else{
        [self ReceiveDetail];
      }
    
    
}




- (void)ReceiveDetail{
    
    NSArray *arr = @[@"全部",@"收徒明细",@"阅读明细",@"其他奖励"];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        
        UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
        MDReciveDetailViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDReciveDetailViewController"];
        myContr.title = [arr objectAtIndex:i];
        myContr.vcType = i + 1;
        
        
        [vcs addObject:myContr];
    }
    JYSlideSegmentController *slideSegmentController = [[JYSlideSegmentController alloc] initWithViewControllers:vcs];
    slideSegmentController.title = @"资金明细";
    //  self.slideSegmentController.indicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    slideSegmentController.indicatorColor = UIColorFromRGB(0xcc3333);
    slideSegmentController.itemWidth = FRAME_WIDTH/4;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:slideSegmentController animated:YES];
 
}

- (void)setleftBar{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    [backButton setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"news"] forState:UIControlStateSelected];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem, nil];
//    [self.navigationItem setLeftBarButtonItem:backItem];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getContent {
 

    [UUProgressHUD show];
    NSDictionary *result = [[MMTService shareInstance]syncgetArticleClassWith:_moduleId];
    if([[result objectForKey:@"code"]floatValue]==0 && result){
        NSArray *contentItems = [ContentModel mj_objectArrayWithKeyValuesArray:[[result objectForKey:@"data"] objectForKey:@"list"]];
        [self setViewControllers:contentItems];
        [UUProgressHUD dismissWithSuccess:nil];
    }else{
            //格式化成json数据
            id jsonObject = [AMTools getLocalJsonDataWithFileName:@"content"];
            if(jsonObject){
        
                NSArray *contentItems = [ContentModel mj_objectArrayWithKeyValuesArray:[jsonObject objectForKey:@"data"]];
        
                [self setViewControllers:contentItems];
            }
        [UUProgressHUD dismissWithSuccess:nil];
    }
    
    
    
    
    
}


- (void)setViewControllers:(NSArray *)ContentModels{
    
    for(ContentModel *model in ContentModels){
    
        BaseViewController *vc =[ViewControllerFactory CreateArticleMoudleContentViewControllerWithId:model];
        
        [self addChildViewController:vc];
    
    
    }
 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
