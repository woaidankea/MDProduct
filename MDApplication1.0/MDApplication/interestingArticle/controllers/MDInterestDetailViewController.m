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
@interface MDInterestDetailViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@end

@implementation MDInterestDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    _bgView.layer.shadowColor = [UIColor yellowColor].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(4, 4);
    
    _bgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    _bgView.layer.shadowRadius = 4;//阴影半径，默认3
    [_wkwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.assignUrl]]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setrightBarItemWith:@"share_top"];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self setleftBarItemWith:@"back_ico@2x.png"];
    
    CGRect rect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+64, self.view.bounds.size.width, self.view.bounds.size.height-49-64);
    if(IOS_8){
    _wkwebview = [[WKWebView alloc]initWithFrame:rect];
    }
    [self.view addSubview:_wkwebview];
    
    
    
    
    //    //logoImageView左侧与父视图左侧对齐
    //    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem:_wkwebview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    //
    //    //logoImageView右侧与父视图右侧对齐
    //    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem:_wkwebview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    //
    //    //logoImageView顶部与父视图顶部对齐
    //    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:_wkwebview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    //
    //    //logoImageView高度为父视图高度一半
    //    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:_wkwebview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:49.0f];
    //
    //
    //    //iOS 6.0或者7.0调用addConstraints
    //    //[self.view addConstraints:@[leftConstraint, rightConstraint, topConstraint, heightConstraint]];
    //
    //    //iOS 8.0以后设置active属性值
    //    leftConstraint.active = YES;
    //    rightConstraint.active = YES;
    //    topConstraint.active = YES;
    //    heightConstraint.active = YES;
    
    //    _progressProxy = [[NJKWebViewProgress alloc] init];
    //    _wkwebview.navigationDelegate =_progressProxy;
    //    _webview.delegate = _progressProxy;
    //    _webview.hidden =YES;
    //
    //    _progressProxy.webViewProxyDelegate = self;
    //    _progressProxy.progressDelegate = self;
    //
    //    CGFloat progressBarHeight = 2.f;
    //    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    //    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    //    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    //    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    //
    // Do any additional setup after loading the view.
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
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webview stringByEvaluatingJavaScriptFromString:@"document.title"];
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
    
    
    
    
    sharemodel.title = t_model.title;
    sharemodel.url = t_model.url;
    sharemodel.imageArray = @[t_model.cover];
    sharemodel.desc = t_model.desc;
    sharemodel.key = t_model.authcode;
      [DXShareTools shareToolsInstance].isPic = NO;
    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel view:[UIApplication sharedApplication].keyWindow
     ];
}
- (IBAction)shareButtonClick:(id)sender {
    
    [self share];
}

- (void)rightItemAction{
    
    [self share];
    
    
}


@end
