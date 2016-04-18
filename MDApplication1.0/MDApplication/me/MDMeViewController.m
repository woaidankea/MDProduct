//
//  MDMeViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMeViewController.h"
#import "MeTopCell.h"
#import "MeBottomCell.h"

@interface MDMeViewController ()

@end

@implementation MDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.separatorColor = [UIColor whiteColor];
    
    [self resetTableView:_table];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTopCell"];
    
    if(indexPath.row==1){
        MeBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeBottomCell"];
        return cell;
    }
    //    AMUserInfoModel *model = self.items[indexPath.row];
    //    cell.user = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    AMUserInfoModel *model = self.items[indexPath.row];
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AMFriendInfoViewController" bundle:nil];
    //    AMFriendInfoViewController *friendInfoController = [storyboard instantiateViewControllerWithIdentifier:@"AMFriendInfoViewController"];
    //    friendInfoController.userInfo = model;
    //    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:friendInfoController animated:YES];
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
