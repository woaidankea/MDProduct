//
//  MainViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MainViewController.h"
#import "MDInterestingArticleViewController.h"
#import "MDBeautifulPicViewController.h"
#import "MDApprenticeViewController.h"
#import "MDSchoolViewController.h"
#import "MDMeViewController.h"
#import "KSGuideManager.h"
#import "UtilsMacro.h"
#import "MDMeCollectionViewController.h"
#import "YZXiMaViewController.h"
#import "MDLoginViewController.h"
#import "AppDelegate.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewDidLoad{
//    self.view.backgroundColor = [UIColor redColor];
    
    
    
    
    
    [super viewDidLoad];
    
    
    
    
    [self addSubViewControllers];
    [self addTabBarImage];
    
    if(!USER_DEFAULT_KEY(@"FisrtLogin")){
    NSMutableArray *paths = [NSMutableArray new];
    
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_1" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_2" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_3" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_4" ofType:@"png"]];
    
    [[KSGuideManager shared] showGuideViewWithImages:paths];
    }
    [USERDEFAULTS setObject:@"1" forKey:@"FisrtLogin"];
}



- (void)addSubViewControllers{
//    //趣文
//    UIStoryboard *neighborStoryboard = [UIStoryboard storyboardWithName:@"MDInterestingArticleViewController" bundle:nil];
//    MDInterestingArticleViewController *neighborFirendContr = [neighborStoryboard instantiateViewControllerWithIdentifier:@"MDInterestingArticleViewController"];
    YZXiMaViewController *neighborFirendContr = [[YZXiMaViewController alloc]init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:neighborFirendContr];
    //美图
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"MDBeautifulPicViewController" bundle:nil];
    MDBeautifulPicViewController *messageContr = [messageStoryboard instantiateViewControllerWithIdentifier:@"MDBeautifulPicViewController"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:messageContr];
    
    //收徒
    UIStoryboard *ReaderStoryboard = [UIStoryboard storyboardWithName:@"MDApprenticeViewController" bundle:nil];
    MDApprenticeViewController *reader = [ReaderStoryboard instantiateViewControllerWithIdentifier:@"MDApprenticeViewController"];
//    [reader addShareNotifi];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:reader];
    
    //学堂
    UIStoryboard *addressStoryboard = [UIStoryboard storyboardWithName:@"MDSchoolViewController" bundle:nil];
    MDSchoolViewController *addressBookContr = [addressStoryboard instantiateViewControllerWithIdentifier:@"MDSchoolViewController"];
    [addressBookContr addNotification];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:addressBookContr];
    
    //我
//    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDLoginViewController" bundle:nil];
//    MDMeViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDLoginViewController"];
////    myContr.enterType =AM_ME;
//    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:myContr];
//    
    
    //我
    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
    MDMeCollectionViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDMeCollectionViewController"];
    //    myContr.enterType =AM_ME;
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:myContr];
   
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.87 green:0.17 blue:0.16 alpha:1]];
    
   
    
    
    
    [self setViewControllers:@[nav1,nav2,nav3,nav4,nav5]];
}

- (void)addTabBarImage{
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *selectedImages = @[@"mune_ico1_hov",
                                @"mune_ico2_hov",
                                @"mune_ico3_hov",
                                @"mune_ico4_hov",
                                @"mune_ico5_hov"];

    NSArray *unselectedImages = @[@"mune_ico1",
                                  @"mune_ico2",
                                  @"mune_ico3",
                                  @"mune_ico4",
                                  @"mune_ico5"];
//    NSArray *titles = @[];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in self.tabBar.items) {
        UIImage *selectedimage = [UIImage imageNamed:selectedImages[index]];
        UIImage *unselectedimage = [UIImage imageNamed:unselectedImages[index]];
        
        [item setFinishedSelectedImage:selectedimage
           withFinishedUnselectedImage:unselectedimage];
//        [item setTitle:titles[index]];
    
//        item.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        index++;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index{
    if(index==2||index==4){
        if(!USER_DEFAULT_KEY(@"token")){
        [self setSelectedIndex:0];
        
        if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
            [[self delegate] tabBarController:self didSelectViewController:[self viewControllers][0]];
        }
            [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];

      
            return;
        }
       

    }
    [super tabBar:tabBar didSelectItemAtIndex:index];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
