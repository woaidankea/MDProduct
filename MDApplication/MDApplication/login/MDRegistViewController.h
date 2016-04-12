//
//  MDRegistViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
#import "CALayer+Additions.h"
@interface MDRegistViewController : BaseViewController
//验证码倒计时
@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) NSInteger countTimerNumber;



@property (weak, nonatomic) IBOutlet UIButton *getSecurityBtn;
@property (weak, nonatomic) IBOutlet UITextField *PhoneField;
@property (weak, nonatomic) IBOutlet UITextField *NewPassword;
@property (weak, nonatomic) IBOutlet UITextField *SurePassword;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *Invitecode;

@property (weak, nonatomic) IBOutlet UIImageView *protocolImage;

- (IBAction)loginClick:(id)sender;


- (IBAction)protocolClick:(id)sender;

- (IBAction)registerClick:(id)sender;
- (IBAction)getSecurityCode:(id)sender;

@end
