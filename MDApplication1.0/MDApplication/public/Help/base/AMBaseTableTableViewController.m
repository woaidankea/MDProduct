//
//  AMBaseTableTableViewController.m
//  AMen
//
//  Created by 曾宏亮 on 15/10/22.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import "AMBaseTableTableViewController.h"
#import "Header.h"
#import "MJRefresh.h"
#import "MDPublicConfig.h"
#import "AMTools.h"
#import "MBProgressHUD.h"

@interface AMBaseTableTableViewController (){
    int _busyCount;
}

@property (strong, nonatomic)MBProgressHUD *busyIndicator;


@end

@implementation AMBaseTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationController.navigationBarHidden=NO;
    
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    self.tableView.backgroundColor = UIColorFromRGB(0xf6f6f6);

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBarHidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)delayToEnableUserInteraction:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    [self performSelector:@selector(delayToEnableUser:) withObject:sender afterDelay:1];
}

- (void)delayToEnableUser:(UIButton *)sender{
    sender.userInteractionEnabled = YES;
}

-(NSMutableArray *)items{
    if(_items==nil){
        _items=[NSMutableArray array];
    }
    return _items;
}


-(void)setBusyIndicatorVisible:(BOOL)visible{
    if(visible){
        _busyCount++;
        if(self.busyIndicator==nil){
            self.busyIndicator=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
            self.busyIndicator.dimBackground=YES;
        }
    }else{
        _busyCount--;
        if(_busyCount==0 || _busyCount<0){
            _busyCount=0;
            [self.busyIndicator hide:YES];
            [self.busyIndicator removeFromSuperview];
            self.busyIndicator=nil;
        }
    }
}

-(BOOL)handleResponseError:(AMBaseTableTableViewController *)currentController
                   request:(AMBaseRequest *)request
       treatErrorAsUnknown:(BOOL) treated{
    
    NSString *confirmTitle=UILocalizedString(@"UI_TEXT_CONFIRM");
    if(request.response.statusCode==-100){
        [AMTools showAlertViewWithMessage:request.response.errorMessage cancelButtonTitle:confirmTitle];
        return YES;
    }
    
    if(treated){
        [AMTools showAlertViewWithMessage:UILocalizedString(@"UI_UNKOWN_ERROR_MESSAGE") cancelButtonTitle:confirmTitle];
        return YES;
    }
    
    return NO;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)addNotification{}

- (void)removeNotification{}


#pragma mark -- 刷新相关

- (void)addHeaderRefresh{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self tableViewHeaderRefresh];
    }];
    
    // 马上进入刷新状态
    //    [self.tableView.header beginRefreshing];
}

- (void)addFooterRefresh{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self tableViewFooterRefresh];
    }];
}


- (void)tableViewHeaderRefresh{
    NSLog(@"Header refresh");
}

- (void)tableViewFooterRefresh{
    NSLog(@"Footer refresh");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
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
