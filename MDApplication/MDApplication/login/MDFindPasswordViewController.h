//
//  MDFindPasswordViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"

@interface MDFindPasswordViewController : BaseViewController

@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) NSInteger countTimerNumber;

@property (weak, nonatomic) IBOutlet UITextField *PhoneField;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityBtn;

- (IBAction)getSecruityBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *NextBtn;

- (IBAction)NextBtnClick:(id)sender;
@end
