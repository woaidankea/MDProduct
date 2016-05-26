//
//  ArticleMoudleController.m
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "ArticleMoudleController.h"
#import "ContentModel.h"
#import "ViewControllerFactory.h"
#import "BaseViewController.h"
#import "AMTools.h"
#import "UIButton+CenterImageAndTitle.h"
@interface ArticleMoudleController ()

@end

@implementation ArticleMoudleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setleftBar];
    [self setrightBar];
    // Do any additional setup after loading the view.
}
- (void)setrightBar{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [backButton setImage:[UIImage imageNamed:@"jinbi"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton setTitle:@"11.5" forState:UIControlStateNormal];

    [backButton horizontalCenterTitleAndImageRight:5];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -20;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:backItem, nil];

}
- (void)setleftBar{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    [backButton setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"news"] forState:UIControlStateSelected];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem, nil];
//    [self.navigationItem setLeftBarButtonItem:backItem];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getContent {
 
  
    //格式化成json数据
    id jsonObject = [AMTools getLocalJsonDataWithFileName:@"content"];
    if(jsonObject){
       
        NSArray *contentItems = [ContentModel mj_objectArrayWithKeyValuesArray:[jsonObject objectForKey:@"data"]];
        
        [self setViewControllers:contentItems];
    }

    
}


- (void)setViewControllers:(NSArray *)ContentModels{
    
    for(ContentModel *model in ContentModels){
    
        BaseViewController *vc =[ViewControllerFactory CreateArticleMoudleContentViewControllerWithId:model];
        
        [self addChildViewController:vc];
    
    
    }
 
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
