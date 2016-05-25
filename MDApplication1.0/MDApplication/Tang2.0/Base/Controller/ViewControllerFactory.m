//
//  ViewControllerFactory.m
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "MDWKWebViewController.h"
#import "MDMyViewController.h"
#import "MDApprenticeViewController.h"
#import "MDInfomationViewController.h"
@implementation ViewControllerFactory
+ (BaseViewController *)TabMenuFactoryCreateViewControllerWithType:(NSString *)type{
    
    if([type isEqualToString:@"MDApprenticeViewController"]){
    
        UIStoryboard *ReaderStoryboard = [UIStoryboard storyboardWithName:@"MDApprenticeViewController" bundle:nil];
        MDApprenticeViewController *reader = [ReaderStoryboard instantiateViewControllerWithIdentifier:@"MDApprenticeViewController"];
        return reader;
    }
    
    if([type isEqualToString:@"MDInfomationViewController"]){
        UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDInfomationViewController" bundle:nil];
        MDInfomationViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDInfomationViewController"];
         return myContr;

    }
    
    
    return [NSClassFromString(type) new];
}


+ (ArticleMoudleController *)TabMenuFactoryCreateArticleMoudleWithType:(NSString *)type{
                return [NSClassFromString(type) new];
}

+ (BaseViewController *)CreateArticleMoudleContentViewControllerWithId:(ContentModel *)model{
    
    UIStoryboard *MDRecViewController = [UIStoryboard storyboardWithName:@"MDRecViewController" bundle:nil];
    MDNewsViewController *Rec = [MDRecViewController instantiateViewControllerWithIdentifier:@"MDRecViewController"];
    
    Rec.title = model.type;
    
    
    return Rec;


}
@end
