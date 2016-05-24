//
//  MDWKWebViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/31.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
#import "YPWebView.h"
@interface MDWKWebViewController : BaseViewController<WKNavigationDelegate,WKUIDelegate,YPWebViewDelegate>
@property (strong,nonatomic)YPWebView *wkwebview;

@end
