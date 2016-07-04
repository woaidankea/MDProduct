//
//  MDLoginViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
#import "CALayer+Additions.h"
@interface MDLoginViewController : BaseViewController
//验证码倒计时
@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) NSInteger countTimerNumber;
@property (weak, nonatomic) IBOutlet UITextField *AccountField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UITextField *securityField;
@property (weak, nonatomic) IBOutlet UIButton *securityBtn;
@property (weak, nonatomic) IBOutlet UILabel *securityLabel;
@property (weak, nonatomic) IBOutlet UIButton *ForgotBtn;
@property (weak, nonatomic) IBOutlet UIButton *RegistBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
- (IBAction)ForgotClick:(id)sender;
- (IBAction)RegistClick:(id)sender;
- (IBAction)LoginClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Labelheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnHeight;
- (IBAction)getSecurityCode:(id)sender;

@end
