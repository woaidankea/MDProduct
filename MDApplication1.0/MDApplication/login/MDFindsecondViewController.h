//
//  MDFindsecondViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"

@interface MDFindsecondViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordField;
@property (copy, nonatomic) NSString *verifyCode;
@property (copy, nonatomic) NSString *telePhone;
- (IBAction)NextBtnClick:(id)sender;

@end
