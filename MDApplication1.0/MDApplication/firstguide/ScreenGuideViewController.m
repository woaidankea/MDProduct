//
//  ScreenGuideViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "ScreenGuideViewController.h"
#import "KSGuideManager.h"
@interface ScreenGuideViewController ()

@end

@implementation ScreenGuideViewController
-(void)viewDidAppear:(BOOL)animated
{
    NSMutableArray *paths = [NSMutableArray new];
    
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_1" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_2" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_3" ofType:@"png"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"5_index_4" ofType:@"png"]];
    
    [[KSGuideManager shared] showGuideViewWithImages:paths];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor redColor];
 
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
