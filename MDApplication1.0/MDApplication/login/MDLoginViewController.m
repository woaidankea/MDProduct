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

@interface MDLoginViewController ()

@end

@implementation MDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"登录";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
      [self setleftBarItemWith:@"back_ico@2x.png"];
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
    
//    AM_CheckPhone checkPhone =[AMTools checkPhoneNumber:userName];
//    if (checkPhone != AM_Phone_IsRight) {
//        NSString *phoneMessage =[AMTools getCheckPhoneMessage:checkPhone];
//        [AMTools showAlertViewWithTitle:phoneMessage
//                      cancelButtonTitle:@"确定"];
//        return;;
//    }
//    
    [_AccountField resignFirstResponder];
    [_PasswordField resignFirstResponder];
    
    
    [self setBusyIndicatorVisible:YES];
    __weak MDLoginViewController *weakSelf =self;
    MDLoginRequest *request=[[MDLoginRequest alloc]initWithTelephone:userName password:password success:^(AMBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        MDUserInfoModel *model =[MDUserInfoModel mj_objectWithKeyValues:request.responseObject];
            [USER_DEFAULT setObject:model.token forKey:@"token"];
            [USER_DEFAULT setObject:model.memberId forKey:@"memberId"];
            [USER_DEFAULT synchronize];
             NSLog(@"111");
         [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
        
        
    } failure:^(AMBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
//        if(request.response.statusCode==300){
//                   }
//        else{
        
        
            [self handleResponseError:self request:request treatErrorAsUnknown:YES];
//        }
    }];
    
    [request start];

}

- (void)leftItemAction{
    
    
    
//
    [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
    

}

@end
