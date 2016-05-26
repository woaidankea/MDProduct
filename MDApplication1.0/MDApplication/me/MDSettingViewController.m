//
//  MDSettingViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDSettingViewController.h"
#import "MDSettingCell.h"
#import "MDFindNextViewController.h"
#import "AppDelegate.h"
#import "MDAboutusViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UtilsMacro.h"
#import "MDWKWebViewController.h"

@interface MDSettingViewController ()

@end

@implementation MDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"设置";
      [self setleftBarItemWith:@"back_ico@2x.png"];
    [self resetTableView:_table];
    _table.separatorStyle =UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(section==0){
//        return 1;
//    }
//    if(section==1)
//    {
//        return 1;
//    }
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 7;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MDSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDSettingCell"];
    if(indexPath.section!=1){
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.row==1){
        cell.Name.text =@"清除缓存";
    }
    if(indexPath.row==0){
        cell.Name.text = @"修改登录密码";
    }
    if(indexPath.row==2){
        cell.Name.text = @"去评分";
    }
    if(indexPath.row == 3){
        cell.Name.text = @"隐私协议";
    }
    if(indexPath.row == 4){
        cell.Name.text = @"关于我们";
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==1){
    //@"清除缓存";
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在清除缓存";
        
        [[SDImageCache sharedImageCache] clearDisk];//清理磁盘
        [[SDImageCache sharedImageCache] clearMemory];//清理内存
        hud.labelText = @"缓存已清理";
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
    if(indexPath.row==0){
    //@"修改登录密码";
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MDLoginViewController" bundle:nil];
        MDFindNextViewController *vc = [story instantiateViewControllerWithIdentifier:@"MDFindNextViewController"];
         [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
    }
    if(indexPath.row==2){
    //@"去评分";
       NSString*   url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1101583170"];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        
        
    }
    if(indexPath.row == 3){
     //@"隐私协议";
        MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
        vc.url = @"http://h.51tangdou.com/weizuan/help/protocol.html";
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
        return;
    }
    if(indexPath.row == 4){
    //关于我们
        
        MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
        vc.url = @"http://h.51tangdou.com/weizuan/help/service.html";
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
        return;
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

- (IBAction)logoutClick:(id)sender {
    [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];

}
@end
