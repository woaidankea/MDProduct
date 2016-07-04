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
#import "MDGetDomain.h"
#import "MDApprenticeModel.h"
#import "TDShareinfoRequest.h"

@interface MDApprenticeViewController ()
{
    NSString *domailUrl ;
    MDApprenticeModel *apprenticeModel;
    UIImageView *shareBgimage;
    UIImage *shareBG;
}
@end

@implementation MDApprenticeViewController
//- (void)awakeFromNib{
//    [super awakeFromNib];
//    [self.view sendSubviewToBack:self.bgimage];
//
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.bgimage addSubview:self.barCode];
    [self.bgimage addSubview:self.code];
    [self getdomain];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *memberCode = USER_DEFAULT_KEY(@"memberId");
    [self setleftBarItemWith:nil];
    
//
    shareBgimage =  [[UIImageView alloc]init];
      self.code.text = [NSString stringWithFormat:@"您的邀请码:%@",memberCode];
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
    
    [self.bgimage setImage:[self addImage_iphone6:  [[DXBarCode shareInstance]createBarCodeImageFrom:[NSString stringWithFormat:@"http://h.51tangdou.com/weizuan/reg.html?uid=%@",memberCode] withSize:170] toImage:[UIImage imageNamed:@"bg750"]]];
    
 
    
    
    // Do any additional setup after loading the view.
}
- (void)getdomain {
    
    
    __weak MDApprenticeViewController *weakSelf = self;


    
    TDShareinfoRequest *request = [[TDShareinfoRequest alloc]initShareinfosuccess:^(AMBaseRequest *request) {
        apprenticeModel = [MDApprenticeModel mj_objectWithKeyValues:request.responseObject];
        domailUrl = [request.responseObject objectForKey:@"domain"];
        NSString *memberCode = USER_DEFAULT_KEY(@"memberId");
        weakSelf.barCode.image= [[DXBarCode shareInstance]createBarCodeImageFrom:[NSString stringWithFormat:@"%@?uid=%@",apprenticeModel.domain,memberCode] withSize:170];
        [weakSelf.bgimage setImage:[self addImage_iphone6: [[DXBarCode shareInstance]createBarCodeImageFrom:[NSString stringWithFormat:@"%@?uid=%@",apprenticeModel.domain,memberCode] withSize:185]toImage:[UIImage imageNamed:@"bg750"]]];
        
        if(apprenticeModel.imageBig!=nil){
            [shareBgimage sd_setImageWithURL:[NSURL URLWithString:apprenticeModel.imageBig] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                shareBG = [weakSelf addImage:_barCode.image toImage:shareBgimage.image];
            }];
        }

    } failure:^(AMBaseRequest *request) {
        
    }];
    
    
    
    [request start];




}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)share{
    


    
    NSArray *shareAry = @[@{@"image":@"share_qq",@"title":@"QQ"},
                          @{@"image":@"share_wx_timeline",@"title":@"朋友圈"},
                          @{@"image":@"share_wx",@"title":@"微信"},
                          @{@"image":@"share_weibo",@"title":@"新浪微博"},
                          @{@"image":@"share_qzone",@"title":@"QQ空间"}];
    
    
    ShareModel *sharemodel = [[ShareModel alloc]init];
    
    
//    self.barCode.image = [self captureScreen];
    if(apprenticeModel.title != nil){
        sharemodel.title = apprenticeModel.title;
    }else{
      sharemodel.title = @"这个应用好玩,推荐大家下载。好多人都在玩!";
    }
    
    if(apprenticeModel.desc != nil){
     sharemodel.desc = apprenticeModel.desc;
    }else {
     sharemodel.desc = @"利用闲余时间,随便点点就可以轻松拿零花";
    }
   
     sharemodel.url = [NSString stringWithFormat:@"%@?uid=%@",apprenticeModel.domain, USER_DEFAULT_KEY(@"memberId")];
    if(apprenticeModel.imageSmall != nil && shareBG != nil){
     sharemodel.imageArray = @[apprenticeModel.imageSmall,shareBG];
    }else if (shareBG != nil){
        sharemodel.imageArray = @[[UIImage imageNamed:@"Icon"],shareBG];

    }else {
        
          shareBG = [self addImage_local:_barCode.image toImage:[UIImage imageNamed:@"apprentice"]];
          sharemodel.imageArray = @[[UIImage imageNamed:@"Icon"],shareBG];
    
    }
    
    [DXShareTools shareToolsInstance].isApprentice = YES;
    
    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel viewController:self];
    
    

    
    
//    ShareModel *sharemodel = [[ShareModel alloc]init];
//    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"];
//    
//    
//    
//    sharemodel.title = @"碎片时间轻松玩";
//    sharemodel.url = [NSString stringWithFormat:@"%@?uid=%@",domailUrl, USER_DEFAULT_KEY(@"memberId")];
//    sharemodel.imageArray = @[imagePath];
//    sharemodel.desc = @"碎片时间轻松玩，分享就能赚大钱";
//    [DXShareTools shareToolsInstance].isPic = YES;
//    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel view:[UIApplication sharedApplication].keyWindow];
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

- (UIImage *) captureScreen {
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGRect rect = [keyWindow bounds];
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [keyWindow.layer renderInContext:context];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect rect = [keyWindow bounds];
    
    UIGraphicsBeginImageContextWithOptions(self.bgimage.frame.size, YES, 0);
    [[self.bgimage layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
//    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect getRect = CGRectMake(0,64,_bgimage.frame.size.width, _bgimage.frame.size.height);//这里可以设置想要截图的区域
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, getRect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    return viewImage;
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);
//    
//    //设置截屏大小
//    
//    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    CGImageRef imageRef = viewImage.CGImage;
//    CGRect rect = CGRectMake(0, 0, 641, SCREEN_HEIGHT + 300);//这里可以设置想要截图的区域
//    
//    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
//    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
//    return  sendImage;
}
//合成图片

- (UIImage *)addImage_local:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(CGSizeMake(621, 1104));
    
    // Draw image1
    [image2 drawInRect:CGRectMake(0, 0,621,1104)];
    
    // Draw image2
    NSLog(@"%f",image2.size.width);
    [image1 drawInRect:CGRectMake(150,510,320,320)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return resultingImage;
}

- (UIImage *)addImage_iphone6:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(CGSizeMake(750, 1334));
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0,750,1334
                                  )];
    
    // Draw image1
    NSLog(@"%f",image2.size.width);
    [image1 drawInRect:CGRectMake(270,620,190,190)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return resultingImage;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image2.size);
    NSLog(@"is Web Big Share Image");
    // Draw image1
    [image2 drawInRect:CGRectMake(0, 0,image2.size.width,image2.size.height)];
    
    // Draw image2
    NSLog(@"%f",image2.size.width);
    
    if(iPhone6Pus){
     [image1 drawInRect:CGRectMake([apprenticeModel.startX integerValue]/3, [apprenticeModel.startY integerValue]/3,[apprenticeModel.size integerValue]/3,[apprenticeModel.size integerValue]/3)];
    }else{
     [image1 drawInRect:CGRectMake([apprenticeModel.startX integerValue]/2, [apprenticeModel.startY integerValue]/2,[apprenticeModel.size integerValue]/2,[apprenticeModel.size integerValue]/2)];
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return resultingImage;
}
- (IBAction)shareButtonClick:(id)sender {
    [self share];
}
@end
