//
//  MDWKWebViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/31.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDWKWebViewController.h"
@interface MDWKWebViewController ()
@property (strong,nonatomic)UIProgressView *progressview;
@end
@implementation MDWKWebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_wkwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)viewWillDisappear:(BOOL)animated{
//    [_wkwebview.wkWebView removeObserver:_wkwebview forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) ];
     [_wkwebview.wkWebView removeObserver:_wkwebview forKeyPath:@"title"];
}
  
- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self setleftBarItemWith:@"back_ico@2x.png"];
    
    CGRect rect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+64, self.view.bounds.size.width, self.view.bounds.size.height-64);
    
    _wkwebview = [[YPWebView alloc]initWithFrame:rect];
    _wkwebview.delegate = self;
    _wkwebview.wkUIDelegateViewController = self;
    _progressview = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    [_wkwebview addSubview:_progressview];
//    _wkwebview.UIDelegate =self;
    [self.view addSubview:_wkwebview];
    //add KVO
//    [_wkwebview addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:nil];

}

#pragma mark - KVO
- (void)YPwebview:(YPWebView *)webview loadProgress:(double)progress{
    [_progressview setAlpha:1.0f];
    [_progressview setProgress:progress animated:YES];
    
    if(progress >= 1.0f) {
        
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_progressview setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [_progressview setProgress:0.0f animated:NO];
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

@end
