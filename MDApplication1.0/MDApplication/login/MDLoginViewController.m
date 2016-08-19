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
#import "UIWindow+UIWindow_SecondConfirm.h"
#import "LoginCodeRequest.h"
#import "OtherLoginRequest.h"
#import "UIColor+HexStringToColor.h"
#import "TDApnsTokenRequest.h"
#import "JPUSHService.h"
@interface MDLoginViewController ()
{
      NSInteger disabledTime;
}
@end

@implementation MDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"登录";
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back_ico.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TimeStart) name:@"TimeStart" object:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -17;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem, nil];
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    NSString *username = [self lastLoginUsername];
    if (username && username.length > 0) {
        _AccountField.text = username;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TimeStart) name:@"TimeStart" object:nil];

}
- (void)TimeStart {
    NSDate *curentTime =[NSDate date];
    disabledTime =curentTime.timeIntervalSince1970+60;
    
    
    
    _countTimerNumber = 60;
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
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
    
    
    
    
    if(_Labelheight.constant == 0){
    
    
    
    
    
    
    
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
        if(request.response.statusCode == 0){
                    [self setBusyIndicatorVisible:NO];
                    MDUserInfoModel *model =[MDUserInfoModel mj_objectWithKeyValues:request.responseObject];
                    [USER_DEFAULT setObject:model.token forKey:@"token"];
                    [USER_DEFAULT setObject:model.memberId forKey:@"memberId"];
                    [USER_DEFAULT synchronize];
                    [weakSelf saveLastLoginUsername];
           TDApnsTokenRequest *request = [[TDApnsTokenRequest alloc]initSecondCheckWithuid:model.memberId token:[JPUSHService registrationID] success:^(AMBaseRequest *request) {
               
           } failure:^(AMBaseRequest *request) {
               
           }];
            
            [request start];
            
        }else if(request.response.statusCode == 1023||request.response.statusCode == 1024 ){
          
//            NSLog(@"123123123123123123");
//                [[UIApplication sharedApplication].keyWindow initConfirmWindow:userName password:password withType:@"2"];
            [self showSecurityField];
            [self setBusyIndicatorVisible:NO];
              [AMTools showHUDtoView:self.view title:request.response.message delay:2];
//             [self handleResponseError:self request:request treatErrorAsUnknown:YES];
            return ;

        }
        
        [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];

    } failure:^(AMBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        [self handleResponseError:self request:request treatErrorAsUnknown:YES];
 
    }];
    [request start];
    }else {
        
        if (_securityField.text.length == 0) {
            [AMTools showAlertViewWithTitle:@"验证码不能为空" cancelButtonTitle:@"确定"];
            return;
        }
        [self setBusyIndicatorVisible:YES];
        OtherLoginRequest *request = [[OtherLoginRequest alloc]initWithTelephone:_AccountField.text password:_PasswordField.text code:_securityField.text success:^(AMBaseRequest *request) {
            if(request.response.statusCode == 0){
                
                MDUserInfoModel *model =[MDUserInfoModel mj_objectWithKeyValues:request.responseObject];
                [USER_DEFAULT setObject:model.token forKey:@"token"];
                [USER_DEFAULT setObject:model.memberId forKey:@"memberId"];
                [USER_DEFAULT synchronize];
                [self saveLastLoginUsername];
                 [self setBusyIndicatorVisible:NO];
                [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
            }
        } failure:^(AMBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            [self handleResponseError:self request:request treatErrorAsUnknown:YES];
        }];
        [request start];
        
        
        
        
    }

}

- (void)showSecurityField{
//    [self.securityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.mas_equalTo(@40);//这里变成高度为0
//    }];
    self.Labelheight.constant = 40;
    self.BtnHeight.constant = 30;
//     [self.securityLabel setNeedsUpdateConstraints];
}

- (void)leftItemAction{
    
    
    
//
    [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
    

}
#pragma  mark - private
- (void)saveLastLoginUsername
{
    NSString *username = _AccountField.text;

    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
      
        [ud synchronize];
    }
}

- (NSString*)lastLoginUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
    if (username && username.length > 0) {
        return username;
    }
    return nil;
}

- (IBAction)getSecurityCode:(id)sender {
    AM_CheckPhone checkPhone =[AMTools checkPhoneNumber:_AccountField.text];
    if (checkPhone==AM_Phone_IsRight) {
      [self setBusyIndicatorVisible:YES];
        WS(weakSelf);
        
        LoginCodeRequest *request = [[LoginCodeRequest alloc]initRegCodeWithPhone:_AccountField.text success:^(AMBaseRequest *request) {
            
            if(((NSString *)[request.responseObject objectForKey:@"codeurl"]).length != 0){
                 [self setBusyIndicatorVisible:NO];
                [[UIApplication sharedApplication].keyWindow initConfirmWindow:[request.responseObject objectForKey:@"codeurl"] Phone:_AccountField.text withType:@"2"];
//                NSDate *curentTime =[NSDate date];
//                disabledTime =curentTime.timeIntervalSince1970+60;
//                
//                
//            
//                _countTimerNumber = 60;
//                self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
                
                 [AMTools showHUDtoView:self.view title:request.response.message delay:2];
                
                
            }else {
                
                AMLog(@"验证码==============%@",request.responseObject);
                
                //            receiveCode = [NSString stringWithFormat:@"%@",[request.responseObject objectForKey:@"phonecode"]];
                NSDate *curentTime =[NSDate date];
                disabledTime =curentTime.timeIntervalSince1970+60;
                
                
                //                [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
                //获取验证码倒计时
                _countTimerNumber = 60;
                self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
                 [self setBusyIndicatorVisible:NO];
                [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
            }
            
            
        } failure:^(AMBaseRequest *request) {
              [self setBusyIndicatorVisible:NO];
             [AMTools showHUDtoView:self.view title:request.response.message delay:2];
            
            
            
        }];
        
        
        
        [request start];            //获取验证码
        
        
    }else{
        NSString *phoneMessage =[AMTools getCheckPhoneMessage:checkPhone];
        [AMTools showAlertViewWithTitle:phoneMessage
                      cancelButtonTitle:@"确定"];
    }


}

//计时器
- (void)timerFireMethod{
    if (_countTimerNumber>0) {
        [_securityBtn setUserInteractionEnabled:NO];
        //        [_getSecurityBtn setTitleColor:[UIColor ColorWithHexString:MD_Gray_Color] forState:UIControlStateNormal];
        //        _getSecurityBtn.backgroundColor = [UIColor ColorWithHexString:MD_Gray_Color];
        [_securityBtn setBackgroundImage:[UIImage imageNamed:@"getting"] forState:UIControlStateNormal];
        [_securityBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld)",(long)_countTimerNumber] forState:UIControlStateNormal];
    }else if (_countTimerNumber<0) {
        [_countTimer invalidate];
        [_securityBtn setUserInteractionEnabled:YES];
        _securityBtn.enabled=YES;
        //        [_getSecurityBtn setTitleColor:[UIColor ColorWithHexString:AM_COLOR_GREEN] forState:UIControlStateNormal];
//        _securityBtn.backgroundColor = [UIColor ColorWithHexString:MD_ButtonPink_Color];
        [_securityBtn setBackgroundImage:[UIImage imageNamed:@"yanzhengma"] forState:UIControlStateNormal];
        [_securityBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    _countTimerNumber --;
    
    
    
}

@end
