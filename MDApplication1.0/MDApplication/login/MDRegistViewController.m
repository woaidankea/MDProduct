//
//  MDRegistViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDRegistViewController.h"
#import "MDPublicConfig.h"
#import "AMTools.h"
#import "UIColor+HexStringToColor.h"
#import "MDForgotPasswordRequest.h"
#import "MDRegistRequest.h"
#import "AppDelegate.h"
#import "MDWKWebViewController.h"
@interface MDRegistViewController ()
{
    NSString *shortCode;
    NSTimer *shortUserTime;
    NSInteger shortUserTimes;
    NSInteger disabledTime;
    NSString *inPutIphoneNumber;
//    NSString *receiveCode;
    BOOL Selected;

}
@end

@implementation MDRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Selected = YES;
    self.title = @"注册";
    [self setleftBarItemWith:@"back_ico@2x.png"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
    self.protocolImage.userInteractionEnabled =YES;
    [self.protocolImage addGestureRecognizer:imageViewTap];
    // Do any additional setup after loading the view.
}
- (void)imageViewTap:(UIGestureRecognizer *)sender{

    if(!Selected){
        [self.protocolImage setImage:[UIImage imageNamed:@"duihao"]];
       
    }else{
      [self.protocolImage setImage:[UIImage imageNamed:@"duihaokuang"]];
    }
     Selected = !Selected;
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
//        _getSecurityBtn.backgroundColor = [UIColor ColorWithHexString:MD_Gray_Color];
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

- (IBAction)getSecurityCode:(id)sender {
    AM_CheckPhone checkPhone =[AMTools checkPhoneNumber:_PhoneField.text];
    if (checkPhone==AM_Phone_IsRight) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MDForgotPasswordRequest *request=[[MDForgotPasswordRequest alloc]initWithTelephone:_PhoneField.text m:@"reg" success:^(AMBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            AMLog(@"验证码==============%@",request.responseObject);
            
//            receiveCode = [NSString stringWithFormat:@"%@",[request.responseObject objectForKey:@"phonecode"]];
            NSDate *curentTime =[NSDate date];
            disabledTime =curentTime.timeIntervalSince1970+60;
            
            
            [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
            //获取验证码倒计时
            _countTimerNumber = 60;
            _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
            
            [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
        } failure:^(AMBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            if(request.response.statusCode==300){
            }
            else{
                [self handleResponseError:self request:request treatErrorAsUnknown:YES];
            }
        }];
        
        [request start];            //获取验证码
             
        
    }else{
        NSString *phoneMessage =[AMTools getCheckPhoneMessage:checkPhone];
        [AMTools showAlertViewWithTitle:phoneMessage
                      cancelButtonTitle:@"确定"];
    }

}
//登录点击事件
- (IBAction)loginClick:(id)sender {
         [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
}
//协议点击事件
- (IBAction)protocolClick:(id)sender {
    MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
    vc.url =@"http://h.51tangdou.com/weizuan/help/protocol.html";
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];

}

- (IBAction)registerClick:(id)sender {
    
//    if (!Selected) {
//        [AMTools showAlertViewWithTitle:@"请勾选阅读魔豆相关协议" cancelButtonTitle:@"确定"];
//        return;
//    }

    if (_PhoneField.text.length == 0) {
        [AMTools showAlertViewWithTitle:@"手机号不能为空" cancelButtonTitle:@"确定"];
        [_PhoneField becomeFirstResponder];
        return;
    }
    
//    if (![_securityCodeTextField.text isEqualToString:receiveCode]) {
//        [AMTools showAlertViewWithTitle:@"请输入正确的验证码" cancelButtonTitle:@"确定"];
//        [_PhoneField becomeFirstResponder];
//        return;
//    }

    if (_securityCodeTextField.text.length == 0) {
        [AMTools showAlertViewWithTitle:@"验证码不能为空" cancelButtonTitle:@"确定"];
        return;
    }
//    if (!
//        [_NewPassword.text isEqualToString:_SurePassword.text] && _NewPassword.text.length!=0) {
//        [AMTools showAlertViewWithTitle:@"请确认密码" cancelButtonTitle:@"确定"];
//        [_NewPassword becomeFirstResponder];
//        return;
//    }
    
    
    
    AM_CheckPhone checkPhone =[AMTools checkPhoneNumber:_PhoneField.text];
    if (checkPhone != AM_Phone_IsRight) {
        NSString *phoneMessage =[AMTools getCheckPhoneMessage:checkPhone];
        [AMTools showAlertViewWithTitle:phoneMessage
                      cancelButtonTitle:@"确定"];
        return;
    }
    
    AM_CheckPassword checkPassword =[AMTools checkPassword:_NewPassword.text];
    if (checkPassword != AM_Password_IsRight) {
        NSString *passwordMessage =[AMTools getCheckPasswordMessage:checkPassword];
        [AMTools showAlertViewWithTitle:passwordMessage
                      cancelButtonTitle:@"确定"];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:_PhoneField.text forKey:@"telephone"];
    [dict setObject:_securityCodeTextField.text forKey:@"verifyCode"];
    [dict setObject:_NewPassword.text forKey:@"password"];
    [dict setObject:_Invitecode.text  forKey:@"teacher"];
    MDRegistRequest *request=[[MDRegistRequest alloc]initWithParams:dict success:^(AMBaseRequest *request) {
             [AMTools showHUDtoWindow:nil title:@"注册成功" delay:2];
        
        
        [USER_DEFAULT setObject:[request.responseObject objectForKey:@"token"] forKey:@"token"];
        NSString *memberID = [NSString stringWithFormat:@"%@",[request.responseObject objectForKey:@"id"]];
        [USER_DEFAULT setObject:memberID  forKey:@"memberId"];
        [USER_DEFAULT synchronize];
        [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];

        
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
   

@end

