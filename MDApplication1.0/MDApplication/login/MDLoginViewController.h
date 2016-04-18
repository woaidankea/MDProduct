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
@property (weak, nonatomic) IBOutlet UITextField *AccountField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UIButton *ForgotBtn;
@property (weak, nonatomic) IBOutlet UIButton *RegistBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
- (IBAction)ForgotClick:(id)sender;
- (IBAction)RegistClick:(id)sender;
- (IBAction)LoginClick:(id)sender;

@end
