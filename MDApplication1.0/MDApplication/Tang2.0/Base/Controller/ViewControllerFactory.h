//
//  ViewControllerFactory.h
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
static NSString *kWebViewController = @"MDWKWebViewController";
static NSString *kOperationSub = @"OperationSub";



@interface ViewControllerFactory : NSObject

+ (BaseViewController *)TabMenuFactoryCreateViewControllerWithType:(NSString *)type;

@end
