//
//  MainViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "RDVTabBarController.h"
#import "RDVTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "MDPublicConfig.h"
@interface MainViewController : RDVTabBarController<RDVTabBarControllerDelegate>
@property(nonatomic,assign)AMEnterMainViewControllerType enterType;

@property(nonatomic, strong)NSMutableArray *conversationList;


@end
