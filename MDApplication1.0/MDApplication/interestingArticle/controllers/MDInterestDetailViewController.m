//
//  MDInterestDetailViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDInterestDetailViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "MDShareModel.h"
#import "AppDelegate.h"
#import "DXShareTools.h"
#import <CommonCrypto/CommonDigest.h>

#import "CLProgress.h"
#import "JQIndicatorView.h"
@interface MDInterestDetailViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
{
//    NJKWebViewProgressView *_progressView;
//    NJKWebViewProgress *_progressProxy;
}
@property (strong,nonatomic)UIProgressView *progressview;
@end

@implementation MDInterestDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      
 
    [_wkwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.assignUrl]]];
     [[CLProgressHUD shareInstance] showsInsuperview:_wkwebview];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  
}



-(void)setrightBarItem:(NSString *)imageNamed{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -17;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBar,nil];
    
}


- (void)rightItemAction{
    [self share];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setrightBarItem:@"share_top"];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self setleftBarItemWith:@"back_ico@2x.png"];
    
    CGRect rect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+64, self.view.bounds.size.width, self.view.bounds.size.height-40-64);
    if(IOS_8){
    _wkwebview = [[YPWebView alloc]initWithFrame:rect];
    }
   
    _wkwebview.delegate = self;
    _wkwebview.wkUIDelegateViewController = self;
    [self.view addSubview:_wkwebview];
    
    
    _progressview = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    [_wkwebview addSubview:_progressview];
    //    _wkwebview.UIDelegate =self;
    [self.view addSubview:_wkwebview];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma mark - NJKWebViewProgressDelegate
#pragma mark - KVO
- (void)YPwebview:(YPWebView *)webview loadProgress:(double)progress{
    [_progressview setAlpha:1.0f];
    [_progressview setProgress:progress animated:YES];
    
    if(progress >= 1.0f) {
        
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_progressview setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [_progressview setProgress:0.0f animated:NO];
             [[CLProgressHUD shareInstance] dismiss];
        }];
        
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        
    }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)YPwebview:(YPWebView *)webview loadTitle:(NSString *)title{
    self.title = title;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //    if ([keyPath isEqual:@"estimatedProgress"]) {
    //        if ([self.delegate respondsToSelector:@selector(YPwebview:loadProgress:)]) {
    //            [self.delegate YPwebview:self loadProgress:self.wkWebView.estimatedProgress];
    //        }
    //    }
}

- (void)share{
    
    if(!USER_DEFAULT_KEY(@"token")){
        
        [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
        return;
        
        
    }

    
    
    
    NSMutableArray *shareAry = [NSMutableArray new];
    
    NSDictionary *share_wx = @{@"image":@"share_wx",
                               @"title":@"微信"};
    NSDictionary *share_wx_timeline = @{@"image":@"share_wx_timeline",
                                        @"title":@"朋友圈"};
    NSDictionary *share_qq = @{@"image":@"share_qq",
                               @"title":@"QQ"};
    NSDictionary *share_weibo = @{@"image":@"share_weibo",
                                  @"title":@"新浪微博"};
    NSDictionary *share_qzone = @{@"image":@"share_qzone",
                                  @"title":@"QQ空间"};
    
    
    ShareModel *sharemodel = [[ShareModel alloc]init];
    MDArticleModel *t_model = self.model;
    //   1.qq  kongjian  pengyouquan  wx  weibo
    
    for(MDShareModel *share in t_model.shareConfig){
        NSLog(@"titile = %@ show = %d platform = %@",share.title,share.show,share.platform);
        if(share.show==YES){
            if([share.platform isEqualToString:@"1"]){
                [shareAry addObject:share_qq];
            }
            if([share.platform isEqualToString:@"2"]){
                [shareAry addObject:share_qzone];
            }
            
            if([share.platform isEqualToString:@"3"]){
                [shareAry addObject:share_wx_timeline];
            }
            
            if([share.platform isEqualToString:@"4"]){
                [shareAry addObject:share_wx];
            }
            
            if([share.platform isEqualToString:@"5"]){
                [shareAry addObject:share_weibo];
            }
            
            
            
        }
        
    }
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];  //转为字符型
    NSString *newKey = [self md5:timeString];
    NSString *MD5 = [newKey substringWithRange:NSMakeRange(7,16)];

    
    
    sharemodel.title = t_model.title;
    sharemodel.url =  [NSString stringWithFormat:@"%@%@",t_model.url,MD5];
    sharemodel.imageArray = @[self.shareImage];
    sharemodel.desc = t_model.desc;
    sharemodel.key = [NSString stringWithFormat:@"%@%@",t_model.authcode,MD5];
    [DXShareTools shareToolsInstance].isPic = NO;

    
    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel  viewController:self];
}
- (IBAction)shareButtonClick:(id)sender {
    
    [self share];
}

//- (void)rightItemAction{
//    
//    [self share];
//    
//    
//}
- (NSString *)md5:(NSString *)string {
    
    // 1. 导入库文件
    //    #import <CommonCrypto/CommonDigest.h>
    
    // 需要MD5加密的字符
    const char *cStr = [string UTF8String];
    // 设置字符加密后存储的空间
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    // 参数三：编码的加密机制
    CC_MD5(cStr, (UInt32)strlen(cStr), digest);
    
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:16];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        
        [result appendFormat:@"%02x",digest];
        
    }
    
    result = (NSMutableString *)[result stringByAppendingString:@".png"];
    
    return result;
    
}


@end
