//
//  MDFindNextViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDFindNextViewController.h"
#import "MDModifyPassword.h"
#import "AppDelegate.h"
#import "TDResetpwdRequest.h"
@interface MDFindNextViewController ()

@end

@implementation MDFindNextViewController
- (void)awakeFromNib{
    [super awakeFromNib];
    [_oldPassword setFrame:CGRectMake(_oldPassword.frame.origin.x, _oldPassword.frame.origin.y, _oldPassword.frame.size.width, 0)];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self setleftBarItemWith:@"back_ico@2x.png"];
    
       self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    

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
        [_passWord.text isEqualToString:_surPassword.text] && _surPassword.text.length!=0) {
        [AMTools showAlertViewWithTitle:@"请确认密码" cancelButtonTitle:@"确定"];
        [_passWord becomeFirstResponder];
        return;
    }
    AM_CheckPassword checkPassword =[AMTools checkPassword:_surPassword.text];
    if (checkPassword != AM_Password_IsRight) {
        NSString *passwordMessage =[AMTools getCheckPasswordMessage:checkPassword];
        [AMTools showAlertViewWithTitle:passwordMessage
                      cancelButtonTitle:@"确定"];
        return;
    }
    __weak MDFindNextViewController *_weakSelf = self;
    
    __weak UINavigationController *_weakNav = ((AppDelegate *)[UIApplication sharedApplication].delegate).rootController;
//    MDModifyPassword *request=[[MDModifyPassword alloc]initWithOldPassword:_oldPassword.text Newpassword:_surPassword.text success:^(AMBaseRequest *request) {
//        [_weakSelf setBusyIndicatorVisible:NO];
//        
//     
//
//        
//        [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
//        
//           [AMTools showHUDtoView:[UIApplication sharedApplication].keyWindow title:@"修改成功" delay:2];
//        
//    } failure:^(AMBaseRequest *request) {
//        [_weakSelf setBusyIndicatorVisible:NO];
//        if(request.response.statusCode==300){
//        }
//        else{
//            [_weakSelf handleResponseError:self request:request treatErrorAsUnknown:YES];
//        }
//    }];
    
    
    TDResetpwdRequest *request = [[TDResetpwdRequest alloc]initRegisterWitholdpass:_oldPassword.text newpass:_surPassword.text success:^(AMBaseRequest *request) {
                [_weakSelf setBusyIndicatorVisible:NO];
        
        
        
        
                [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
        
                   [AMTools showHUDtoView:[UIApplication sharedApplication].keyWindow title:@"修改成功" delay:2];

    } failure:^(AMBaseRequest *request) {
        [_weakSelf setBusyIndicatorVisible:NO];
        [_weakSelf handleResponseError:self request:request treatErrorAsUnknown:YES];
        

    }];
    
    [request start];
    
    
    
}
@end
