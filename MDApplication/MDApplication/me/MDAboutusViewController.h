//
//  MDAboutusViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
#import "MDPublicConfig.h"
@interface MDAboutusViewController : BaseViewController
@property (assign,nonatomic)MD_EnterWebControl enterType;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
