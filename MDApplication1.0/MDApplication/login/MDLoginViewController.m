//
//  MDLoginViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDLoginViewController.h"
#import "MDRegistViewController.h"
#import "MDFindPasswordViewController.h"
#import "AppDelegate.h"
#import "MDLoginRequest.h"
#import "MDUserInfoModel.h"
#import "TDLoginRequest.h"
@interface MDLoginViewController ()

@end

@implementation MDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"登录";
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back_ico.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];

    self.view.backgroundColor = UIColorFromRGB(0xffffff);
//      [self setleftBarItemWith:@"back_ico@2x.png"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)ForgotClick:(id)sender {
    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDLoginViewController" bundle:nil];
    MDFindPasswordViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDFindPasswordViewController"];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];

}

- (IBAction)RegistClick:(id)sender {
    
    
    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDLoginViewController" bundle:nil];
    MDRegistViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDRegistViewController"];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];

    
}

- (IBAction)LoginClick:(id)sender {
    
    NSString *userName=[_AccountField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password=[_PasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (userName.length == 0) {
        [AMTools showAlertViewWithTitle:@"没有填写手机号" cancelButtonTitle:@"确定"];
        [_AccountField becomeFirstResponder];
        return;
    }
    if (password.length == 0) {
        [AMTools showAlertViewWithTitle:@"请填写密码" cancelButtonTitle:@"确定"];
        [_PasswordField becomeFirstResponder];
        return;
    }
    [_AccountField resignFirstResponder];
    [_PasswordField resignFirstResponder];
    
    
    [self setBusyIndicatorVisible:YES];
    __weak MDLoginViewController *weakSelf =self;

    
    
    TDLoginRequest *request = [[TDLoginRequest alloc]initWithTelephone:userName password:password success:^(AMBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
                MDUserInfoModel *model =[MDUserInfoModel mj_objectWithKeyValues:request.responseObject];
                    [USER_DEFAULT setObject:model.token forKey:@"token"];
                    [USER_DEFAULT setObject:model.memberId forKey:@"memberId"];
                    [USER_DEFAULT synchronize];
                     NSLog(@"111");
                 [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];

    } failure:^(AMBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
                        [self handleResponseError:self request:request treatErrorAsUnknown:YES];
 
    }];
      [request start];

}

- (void)leftItemAction{
    
    
    
//
    [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
    

}

@end
