//
//  YZXiMaViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZXiMaViewController.h"

#import "ChildViewController.h"

#import "FullChildViewController.h"
#import "UIColor+HexStringToColor.h"
#import "AMColorAndFontConfig.h"
#import "MDNewsViewController.h"
#import "AppDelegate.h"
#import "MDRecViewController.h"
#import "MDSmileViewController.h"
#import "MDLifeViewController.h"
#import "MDFinanceViewController.h"
#import "MDCuriousViewController.h"
#import "MDEntertainmentViewController.h"
#import "MDMotherChildViewController.h"
#import "MDEncouragementViewController.h"
#import "MDEncyclopediasViewController.h"
#import "MDDeliciousViewController.h"
#import "MDTechnologyViewController.h"
#import "MDCarViewController.h"
#import "MDFashionViewController.h"
#import "MDTourViewController.h"
#import "MDMilitaryViewController.h"
@implementation YZXiMaViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"趣文";
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 添加所有子控制器
//    [self setUpAllViewController];
    
    
    // 设置标题字体

//        方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
 
    // 推荐方式
    
    
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        
            // 设置标题字体
        *norColor = [UIColor ColorWithHexString:MD_UnSelGray_Color];
        *selColor =[UIColor ColorWithHexString:MD_TitleRed_Color];
        *titleScrollViewColor = [UIColor whiteColor];
        *titleHeight = 40;
        
    }];
    
    // 设置下标
    /*
        方式一
     // 是否显示标签
     self.isShowUnderLine = YES;
     
     // 标题填充模式
     self.underLineColor = [UIColor redColor];
     
     // 是否需要延迟滚动,下标不会随着拖动而改变
     self.isDelayScroll = YES;
     */

    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = [UIColor ColorWithHexString:MD_TitleRed_Color];
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
//        *isDelayScroll = YES;
        
    }];
    
    
       
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = YES;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 段子
    
    UIStoryboard *MDRecViewController = [UIStoryboard storyboardWithName:@"MDRecViewController" bundle:nil];
    MDNewsViewController *Rec = [MDRecViewController instantiateViewControllerWithIdentifier:@"MDRecViewController"];
  
    Rec.title = @"推荐";
    
    [self addChildViewController:Rec];
//    推荐
//    情感
//    搞笑
//    健康
//    娱乐
//    减肥
//    美容
//    健身
//    趣闻
//    两性
//    科技
//    百科
//    星座
//    汽车
//    旅游
// 资讯
    UIStoryboard *neighborStoryboard = [UIStoryboard storyboardWithName:@"MDNewsViewController" bundle:nil];
    MDNewsViewController *newsVc = [neighborStoryboard instantiateViewControllerWithIdentifier:@"MDNewsViewController"];
    newsVc.title = @"情感";
    
    
    [self addChildViewController:newsVc];

    
    
    // 搞笑
    UIStoryboard *Smilestory = [UIStoryboard storyboardWithName:@"MDSmileViewController" bundle:nil];
    MDSmileViewController *Smile = [Smilestory instantiateViewControllerWithIdentifier:@"MDSmileViewController"];
    

    Smile.title = @"搞笑";
    [self addChildViewController:Smile];
    
    // 养生
    UIStoryboard *Lifestory = [UIStoryboard storyboardWithName:@"MDLifeViewController" bundle:nil];
    MDLifeViewController *Lifes = [Lifestory instantiateViewControllerWithIdentifier:@"MDLifeViewController"];
    

    Lifes.title = @"健康";
    [self addChildViewController:Lifes];
    
    // 母婴
    UIStoryboard *Motherstory = [UIStoryboard storyboardWithName:@"MDMotherChildViewController" bundle:nil];
    MDMotherChildViewController *Mother = [Motherstory instantiateViewControllerWithIdentifier:@"MDMotherChildViewController"];
    
    
    Mother.title = @"娱乐";
    [self addChildViewController:Mother];
    
    // 娱乐
    UIStoryboard *EntertaimentStory = [UIStoryboard storyboardWithName:@"MDEntertainmentViewController" bundle:nil];
    MDEntertainmentViewController *Entertaiment = [EntertaimentStory instantiateViewControllerWithIdentifier:@"MDEntertainmentViewController"];
    
    
    Entertaiment.title = @"减肥";
    [self addChildViewController:Entertaiment];

    
    // 猎奇
    UIStoryboard *CuriousStory = [UIStoryboard storyboardWithName:@"MDCuriousViewController" bundle:nil];
    MDCuriousViewController *Curious = [CuriousStory instantiateViewControllerWithIdentifier:@"MDCuriousViewController"];
    
    
    Curious.title = @"美容";
    [self addChildViewController:Curious];
    // 财经7
    UIStoryboard *FinancStory = [UIStoryboard storyboardWithName:@"MDFinanceViewController" bundle:nil];
    MDFinanceViewController *Financ = [FinancStory instantiateViewControllerWithIdentifier:@"MDFinanceViewController"];
    
    
    Financ.title = @"健身";
    [self addChildViewController:Financ];
    // 科技
    UIStoryboard *TechnologyStory = [UIStoryboard storyboardWithName:@"MDTechnologyViewController" bundle:nil];
    MDTechnologyViewController *Technology = [TechnologyStory instantiateViewControllerWithIdentifier:@"MDTechnologyViewController"];
    
    
    Technology.title = @"趣文";
    [self addChildViewController:Technology];
    
    // 美食
    UIStoryboard *DeliciousStory = [UIStoryboard storyboardWithName:@"MDDeliciousViewController" bundle:nil];
    MDDeliciousViewController *Delicious = [DeliciousStory instantiateViewControllerWithIdentifier:@"MDDeliciousViewController"];
    
    
    Delicious.title = @"两性";
    [self addChildViewController:Delicious];
    // 励志
    UIStoryboard *EncouragementStory = [UIStoryboard storyboardWithName:@"MDEncouragementViewController" bundle:nil];
    MDEncouragementViewController *Encouragement = [EncouragementStory instantiateViewControllerWithIdentifier:@"MDEncouragementViewController"];
    //    两性
    //    科技
    //    百科
    //    星座
    //    汽车
    //    旅游
    
    Encouragement.title = @"科技";
    [self addChildViewController:Encouragement];
    // 百科
    UIStoryboard *EncyclopediasStory = [UIStoryboard storyboardWithName:@"MDEncyclopediasViewController" bundle:nil];
    MDEncyclopediasViewController *Encyclopedias = [EncyclopediasStory instantiateViewControllerWithIdentifier:@"MDEncyclopediasViewController"];
    
    
    Encyclopedias.title = @"百科";
    [self addChildViewController:Encyclopedias];
    
    // 汽车
    UIStoryboard *CarStory = [UIStoryboard storyboardWithName:@"MDCarViewController" bundle:nil];
    MDCarViewController *Car= [CarStory instantiateViewControllerWithIdentifier:@"MDCarViewController"];
    
    
    Car.title = @"星座";
    [self addChildViewController:Car];
    
    // 时尚
    UIStoryboard *FashionStory = [UIStoryboard storyboardWithName:@"MDFashionViewController" bundle:nil];
    MDFashionViewController *Fashion= [FashionStory instantiateViewControllerWithIdentifier:@"MDFashionViewController"];
    
    
    Fashion.title = @"汽车";
    [self addChildViewController:Fashion];
    
    // 时尚
    UIStoryboard *MilitaryStory = [UIStoryboard storyboardWithName:@"MDMilitaryViewController" bundle:nil];
    MDMilitaryViewController *Military= [MilitaryStory instantiateViewControllerWithIdentifier:@"MDMilitaryViewController"];
    
    
    Military.title = @"旅游";
    [self addChildViewController:Military];
    
}


@end
