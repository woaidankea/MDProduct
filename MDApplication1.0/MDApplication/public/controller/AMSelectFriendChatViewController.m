//
//  AMSelectFriendChatViewController.m
//  AMen
//
//  Created by gaoxinfei on 15/8/15.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMSelectFriendChatViewController.h"
#import "MDPublicConfig.h"
#import "RDVTabBarController.h"

@interface AMSelectFriendChatViewController (){
    UIView *searchBackView;
    UISearchBar *searchFriendBar;
    UIScrollView *selectFriends;
    UIView *selectGroupView;
    UITableView *friendTable;
    UILabel *selectGroupLabel;
    NSMutableArray *selectFriendsArray;
    NSMutableArray *friendArray;
    
}

@end

@implementation AMSelectFriendChatViewController

-(void)dealloc{
    [searchBackView removeFromSuperview];
    searchBackView =nil;
    [selectGroupView removeFromSuperview];
    selectGroupView =nil;
    [friendTable removeFromSuperview];
    friendTable =nil;
    
    [selectFriendsArray removeAllObjects];
    selectFriendsArray =nil;
    [friendArray removeAllObjects];
    friendArray =nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"选择联系人"];
    
    UIBarButtonItem *makeSureBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(makeSureClick)];
    makeSureBtnItem.style =UIBarButtonSystemItemDone;
    [self.navigationItem setRightBarButtonItem:makeSureBtnItem];
    
    [self createSubView];

}
-(void)createSubView{
    searchBackView =[[UIView alloc]initWithFrame:CGRectMake(0,NavightBarHeight , FRAME_WIDTH, 50)];
    [self.view addSubview:searchBackView];
    searchFriendBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, FRAME_WIDTH,50)];
    searchFriendBar.translucent = YES;
    searchFriendBar.barStyle = UIBarStyleDefault;
    searchFriendBar.showsCancelButton = NO;
    [searchFriendBar sizeToFit];
    searchFriendBar.placeholder = @"搜索";
    [searchFriendBar setShowsCancelButton:NO];
    
    [searchBackView addSubview:searchFriendBar];
    

    
    selectGroupView =[[UIView alloc]initWithFrame:CGRectMake(0,NavightBarHeight + searchBackView.frame.size.height
                                                             , FRAME_WIDTH, 50)];
    [self.view addSubview:selectGroupView];
    selectGroupLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    selectGroupLabel.text =@"选择一个群";
    
    
    switch (self.enterType) {
        case AM_MessageEnterSelectFriendController:{
           
           [selectGroupView addSubview:selectGroupLabel];
             friendTable = [[UITableView alloc]initWithFrame:CGRectMake(0, selectGroupView.frame.origin.y+selectGroupView.frame.size.height, FRAME_WIDTH, FRAME_HEIGHT-selectGroupView.frame.origin.y -selectGroupView.frame.size.height) style:UITableViewStylePlain];
            [self.view addSubview:friendTable];
        }
            
            break;
        case AM_AddressEnterSelectFriendControlller:
            
            break;
        default:
            break;
    }
    
   
    
}
-(void)makeSureClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
