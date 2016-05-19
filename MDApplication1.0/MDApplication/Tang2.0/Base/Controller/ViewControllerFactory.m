//
//  ViewControllerFactory.m
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "MDWKWebViewController.h"
@implementation ViewControllerFactory
+ (BaseViewController *)TabMenuFactoryCreateViewControllerWithType:(NSString *)type{
    return [NSClassFromString(type) new];
}
@end
