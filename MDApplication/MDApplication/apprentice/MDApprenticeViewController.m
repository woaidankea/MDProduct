//
//  MDApprenticeViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDApprenticeViewController.h"
#import "DXBarCode.h"
#import "UtilsMacro.h"
#import "DXShareTools.h"
@interface MDApprenticeViewController ()

@end

@implementation MDApprenticeViewController
//- (void)awakeFromNib{
//    [super awakeFromNib];
//    [self.view sendSubviewToBack:self.bgimage];
//
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *memberCode = USER_DEFAULT_KEY(@"memberId");
    self.code.text = memberCode;
     self.barCode.image= [[DXBarCode shareInstance]createBarCodeImageFrom:[NSString stringWithFormat:@"http://m.yuechezhu.com/register.html?uid=%@",memberCode] withSize:170];
   
    self.title = @"收徒";
    if(iPhone5){
        [self.bgimage setImage:[UIImage imageNamed:@"bg1136"]];
    }else if(iPhone6){
          [self.bgimage setImage:[UIImage imageNamed:@"bg750"]];
    
    }else if(iPhone6Pus){
          [self.bgimage setImage:[UIImage imageNamed:@"bg1242"]];
    
    }else{
          [self.bgimage setImage:[UIImage imageNamed:@"bg640"]];
    
    }
 
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)share{
    
//    NSDictionary *share_wx = @{@"image":@"share_wx",
//                               @"title":@"微信"};
//    NSDictionary *share_wx_timeline = @{@"image":@"share_wx_timeline",
//                                        @"title":@"朋友圈"};
//    NSDictionary *share_qq = @{@"image":@"share_qq",
//                               @"title":@"QQ"};
//    NSDictionary *share_weibo = @{@"image":@"share_weibo",
//                                  @"title":@"新浪微博"};
//    NSDictionary *share_qzone = @{@"image":@"share_qzone",
//                                  @"title":@"QQ空间"};

    
    NSArray *shareAry = @[@{@"image":@"share_qq",@"title":@"QQ"},
                          @{@"image":@"share_wx_timeline",@"title":@"朋友圈"},
                          @{@"image":@"share_wx",@"title":@"微信"},
                          @{@"image":@"share_weibo",@"title":@"新浪微博"},
                          @{@"image":@"share_qzone",@"title":@"QQ空间"}];
    
    ShareModel *sharemodel = [[ShareModel alloc]init];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"];
    
    
    
    sharemodel.title = @"碎片时间轻松玩";
    sharemodel.url = [NSString stringWithFormat:@"http://m.yuechezhu.com/register.html?uid=%@", USER_DEFAULT_KEY(@"memberId")];
    sharemodel.imageArray = @[imagePath];
    sharemodel.desc = @"测试";
    [DXShareTools shareToolsInstance].isPic = NO;
    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel view:[UIApplication sharedApplication].keyWindow];
}


//- (void)share{
//    //1、创建分享参数
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"];
//    NSArray* imageArray = @[imagePath];
//    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    if (imageArray) {
//        
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        
//        [shareParams SSDKSetupShareParamsByText:nil
//                                         images:imageArray
//                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.yuechezhu.com/register.html?uid=%@", USER_DEFAULT_KEY(@"memberId")]]
//                                           title:@"碎片时间轻松玩"
//                                           type:SSDKContentTypeAuto];
//        
//        [shareParams SSDKEnableUseClientShare];
//        //2、分享（可以弹出我们的分享菜单和编辑界面）
//        SSUIShareActionSheetController *sheet =   [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                                                                           items:nil
//                                                                     shareParams:shareParams
//                                                             onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                                                                 
//                                                                 switch (state) {
//                                                                     case SSDKResponseStateSuccess:
//                                                                     {
//                                                                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                                                             message:nil
//                                                                                                                            delegate:nil
//                                                                                                                   cancelButtonTitle:@"确定"
//                                                                                                                   otherButtonTitles:nil];
//                                                                         [alertView show];
//                                                                         break;
//                                                                     }
//                                                                     case SSDKResponseStateFail:
//                                                                     {
//                                                                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                                                                         message:[NSString stringWithFormat:@"%@",error]
//                                                                                                                        delegate:nil
//                                                                                                               cancelButtonTitle:@"OK"
//                                                                                                               otherButtonTitles:nil, nil];
//                                                                         [alert show];
//                                                                         break;
//                                                                     }
//                                                                     default:
//                                                                         break;
//                                                                 }
//                                                             }
//                                                   ];
//        
//        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareButtonClick:(id)sender {
    [self share];
}
@end
