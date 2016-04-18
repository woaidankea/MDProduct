//
//  MDFindPasswordViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDFindPasswordViewController.h"
#import "CALayer+Additions.h"
#import "MDPublicConfig.h"
#import "AMTools.h"
#import "UIColor+HexStringToColor.h"
#import "MDFindNextViewController.h"
#import "AppDelegate.h"
#import "MDFindsecondViewController.h"
#import "MDForgotPasswordRequest.h"
#import "MDCheckVertifyRequest.h"
@interface MDFindPasswordViewController ()
{
    NSString *shortCode;
    NSTimer *shortUserTime;
    NSInteger shortUserTimes;
    NSInteger disabledTime;
    NSString *inPutIphoneNumber;
    NSString *receiveCode;
}
@end

@implementation MDFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
      self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self setleftBarItemWith:@"back_ico@2x.png"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//计时器
- (void)timerFireMethod{
    if (_countTimerNumber>0) {
        [_getSecurityBtn setUserInteractionEnabled:NO];
        //        [_getSecurityBtn setTitleColor:[UIColor ColorWithHexString:MD_Gray_Color] forState:UIControlStateNormal];
        _getSecurityBtn.backgroundColor = [UIColor ColorWithHexString:MD_Gray_Color];
         [_getSecurityBtn setBackgroundImage:[UIImage imageNamed:@"getting"] forState:UIControlStateNormal];
        [_getSecurityBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld)",(long)_countTimerNumber] forState:UIControlStateNormal];
    }else if (_countTimerNumber<0) {
        [_countTimer invalidate];
        [_getSecurityBtn setUserInteractionEnabled:YES];
        _getSecurityBtn.enabled=YES;
        //        [_getSecurityBtn setTitleColor:[UIColor ColorWithHexString:AM_COLOR_GREEN] forState:UIControlStateNormal];
        _getSecurityBtn.backgroundColor = [UIColor ColorWithHexString:MD_ButtonPink_Color];
         [_getSecurityBtn setBackgroundImage:[UIImage imageNamed:@"yanzhengma"] forState:UIControlStateNormal];
        [_getSecurityBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    _countTimerNumber --;
    
    
    
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
    if (_PhoneField.text.length == 0) {
        [AMTools showAlertViewWithTitle:@"手机号不能为空" cancelButtonTitle:@"确定"];
        [_PhoneField becomeFirstResponder];
        return;
    }
    
    if (![_securityCodeTextField.text isEqualToString:receiveCode]) {
        [AMTools showAlertViewWithTitle:@"验证码输入错误" cancelButtonTitle:@"确定"];
        return;
    }
    if (_securityCodeTextField.text.length == 0) {
        [AMTools showAlertViewWithTitle:@"验证码不能为空" cancelButtonTitle:@"确定"];
        return;
    }
    AM_CheckPhone checkPhone =[AMTools checkPhoneNumber:_PhoneField.text];
    if (checkPhone != AM_Phone_IsRight) {
        NSString *phoneMessage =[AMTools getCheckPhoneMessage:checkPhone];
        [AMTools showAlertViewWithTitle:phoneMessage
                      cancelButtonTitle:@"确定"];
        return;
    }
    __weak UINavigationController *_weakNav = ((AppDelegate *)[UIApplication sharedApplication].delegate).rootController;
    
    MDCheckVertifyRequest *request=[[MDCheckVertifyRequest alloc]initWithTelephone:_PhoneField.text VerifyCode:_securityCodeTextField.text success:^(AMBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        AMLog(@"验证码==============%@",request.responseObject);
        
        UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDLoginViewController" bundle:nil];
        MDFindsecondViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDFindsecondViewController"];
        myContr.verifyCode = _securityCodeTextField.text;
        myContr.telePhone = _PhoneField.text;
        [_weakNav pushViewController:myContr animated:YES];

    } failure:^(AMBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        if(request.response.statusCode==300){
        }
        else{
            [self handleResponseError:self request:request treatErrorAsUnknown:YES];
        }
    }];
    
    [request start];
  
    

}
- (IBAction)getSecruityBtnClick:(id)sender {
    AM_CheckPhone checkPhone =[AMTools checkPhoneNumber:_PhoneField.text];
    if (checkPhone==AM_Phone_IsRight) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       
        MDForgotPasswordRequest *request=[[MDForgotPasswordRequest alloc]initWithTelephone:_PhoneField.text m:@"user" success:^(AMBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            AMLog(@"验证码==============%@",[request.responseObject objectForKey:@"phonecode"]);
            receiveCode =[NSString stringWithFormat:@"%@",[request.responseObject objectForKey:@"phonecode"]];
            [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
        } failure:^(AMBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
           
            [self handleResponseError:self request:request treatErrorAsUnknown:YES];
            
        }];
        
        [request start];

        
        //获取验证码
        NSDate *curentTime =[NSDate date];
        disabledTime =curentTime.timeIntervalSince1970+60;
        
        
     
        //获取验证码倒计时
        _countTimerNumber = 60;
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
        
    }else{
        NSString *phoneMessage =[AMTools getCheckPhoneMessage:checkPhone];
        [AMTools showAlertViewWithTitle:phoneMessage
                      cancelButtonTitle:@"确定"];
    }
 
}
@end
