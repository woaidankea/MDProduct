//
//  ViewControllerFactory.h
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "ArticleMoudleController.h"
#import "MDNewsViewController.h"
#import "ContentModel.h"
static NSString *kWebViewController = @"MDWKWebViewController";
static NSString *kArticleMoudle = @"ArticleMoudleController";
static NSString *kArticleContent = @"MDNewsViewController";
static NSString *kMyMoudle = @"MDMyViewController";


@interface ViewControllerFactory : NSObject

+ (BaseViewController *)TabMenuFactoryCreateViewControllerWithType:(NSString *)type;


+ (ArticleMoudleController *)TabMenuFactoryCreateArticleMoudleWithType:(NSString *)type;


+ (BaseViewController *)CreateArticleMoudleContentViewControllerWithId:(ContentModel *)model;
@end
