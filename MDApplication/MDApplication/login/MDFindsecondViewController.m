//
//  MDFindsecondViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDFindsecondViewController.h"
#import "AMTools.h"
#import "MDPublicConfig.h"
#import "MDFindPassword.h"
#import "AppDelegate.h"
@interface MDFindsecondViewController ()

@end

@implementation MDFindsecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"找回密码";
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

- (IBAction)NextBtnClick:(id)sender {
    if (!
        [_passwordField.text isEqualToString:_surePasswordField.text] && _passwordField.text.length!=0) {
        [AMTools showAlertViewWithTitle:@"请确认密码" cancelButtonTitle:@"确定"];
        [_passwordField becomeFirstResponder];
        return;
    }
    AM_CheckPassword checkPassword =[AMTools checkPassword:_surePasswordField.text];
    if (checkPassword != AM_Password_IsRight) {
        NSString *passwordMessage =[AMTools getCheckPasswordMessage:checkPassword];
        [AMTools showAlertViewWithTitle:passwordMessage
                      cancelButtonTitle:@"确定"];
        return;
    }
     __weak MDFindsecondViewController *_weakSelf = self;
    
     __weak UINavigationController *_weakNav = ((AppDelegate *)[UIApplication sharedApplication].delegate).rootController;
    MDFindPassword *request=[[MDFindPassword alloc]initWithTelephone:_telePhone VerifyCode:_verifyCode PassWord:_surePasswordField.text success:^(AMBaseRequest *request) {
        [_weakSelf setBusyIndicatorVisible:NO];
        [_weakNav  popToRootViewControllerAnimated:YES];
        
    } failure:^(AMBaseRequest *request) {
        [_weakSelf setBusyIndicatorVisible:NO];
        if(request.response.statusCode==300){
        }
        else{
        [_weakSelf handleResponseError:self request:request treatErrorAsUnknown:YES];
        }
    }];
    
    [request start];
    

}
@end
