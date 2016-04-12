//
//  MDFullViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDFullViewController.h"

@interface MDFullViewController ()

@end

@implementation MDFullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        // 导航条上面高度
        CGFloat navBarH = 64;
        
        // 查看自己标题滚动视图设置的高度，我这里设置为44
        CGFloat titleScrollViewH = 44;
        
        self.tableView.contentInset = UIEdgeInsetsMake(navBarH + titleScrollViewH, 0, 0, 0);
    }
    
    
    // 如果有tabBarController，底部需要添加额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 44, 0, 49, 0);

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
