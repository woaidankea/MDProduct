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

@interface ArticleMoudleController ()

@end

@implementation ArticleMoudleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
