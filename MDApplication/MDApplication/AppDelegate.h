//
//  AppDelegate.h
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPublicConfig.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(UINavigationController *)rootController;
-(void)EnterMainViewController :(AMEnterMainViewControllerType)enterType;
-(void)exitAppToLandViewController;
@end

