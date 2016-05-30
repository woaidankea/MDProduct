//
//  MDSchoolViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDSchoolViewController.h"
#import "MDSchoolHeadCell.h"
#import "MDSchoolSecondCell.h"
#import "MDAboutusViewController.h"
#import "AppDelegate.h"
#import "MDWKWebViewController.h"
#import "AppDelegate.h"
#import "UIButton+CenterImageAndTitle.h"
#define YZScreenW [UIScreen mainScreen].bounds.size.width
@interface MDSchoolViewController ()

@end

@implementation MDSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新手学堂";
    [self resetTableView:_table];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0,64, YZScreenW, 30);
    [button setImage:[UIImage imageNamed:@"gengduo"]forState:UIControlStateNormal];
    [button setTitle:@"iOS如何分享到朋友圈" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xDE3748) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = UIColorFromRGB(0xe2e2e2);
    [button horizontalCenterTitleAndImage:YZScreenW - 100];
    //    button.backgroundColor =[UIColor redColor];
    [self.view addSubview:button];
}

- (void)helpClick{
    MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
    NSString *outCome = [NSString stringWithFormat:@"http://h.51tangdou.com/help/ios/index.html"];
    vc.url = outCome;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0||section==1){
        return 0.01;
    }
    return 7;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
        return 140;
    }else{
        return 49;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSMutableAttributedString *attributedString_str = [[NSMutableAttributedString alloc] initWithString:@"在糖豆如何赚钱?"];
    
    [attributedString_str addAttribute:NSForegroundColorAttributeName                                                      value:[UIColor redColor] range:NSMakeRange(0,8)];
    if(indexPath.section==0){
        
       
        
        MDSchoolHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDSchoolHeadCell"];
        cell.image.image = [UIImage imageNamed:@"banner"];
        return cell;
    }else{
        MDSchoolSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDSchoolSecondCell"];
        
        switch (indexPath.section) {
            case 1:
            
//                NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:@"为什么我们能给您钱？[必读]"];
//                [aAttributedString addAttribute:NSForegroundColorAttributeName                                                      value:[UIColor redColor] range:NSMakeRange(0, 4)];
             
               cell.TitleLabel.attributedText = attributedString_str;
                
                break;
            case 2:
                cell.TitleLabel.text = @"转发文章为什么糖豆给您钱?";
                break;
            case 3:
                cell.TitleLabel.text = @"提高收入技巧![必读]";
                cell.TitleLabel.textColor = [UIColor blueColor];
                break;
            case 4:
                
                cell.TitleLabel.text = @"邀请好友加入，能让您收入倍增！";
                break;
            case 5:
                cell.TitleLabel.text = @"满20元如何申请提现？";
                break;

            case 6:
                cell.TitleLabel.text = @"常见问题";
                break;

            default:
                
            break;}
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *webUrl = [[NSString alloc]init];
    switch (indexPath.section) {
        case 0:
            return;
            break;
        case 1:
            webUrl = @"http://60.173.8.139/weizuan/help/1.html";
            break;
        case 2:
            webUrl = @"http://60.173.8.139/weizuan/help/2.html";
            break;
        case 3:
            webUrl = @"http://60.173.8.139/weizuan/help/3.html";
            break;
        case 4:
            webUrl = @"http://60.173.8.139/weizuan/help/4.html";
            break;
        case 5:
            webUrl = @"http://60.173.8.139/weizuan/help/5.html";
            break;
        case 6:
            webUrl = @"http://60.173.8.139/weizuan/help/6.html";
            break;
        default:
            
        break;
    
    }
    
    
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MDSettingViewController" bundle:nil];
//    MDAboutusViewController *vc = [story instantiateViewControllerWithIdentifier:@"MDAboutusViewController"];
//    vc.enterType = MD_AboutController;
    
    
    MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
    vc.url = webUrl;
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];


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
