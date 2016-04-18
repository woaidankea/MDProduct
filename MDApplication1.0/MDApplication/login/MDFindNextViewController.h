//
//  MDFindNextViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"

@interface MDFindNextViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *passWord;


@property (weak, nonatomic) IBOutlet UITextField *surPassword;
- (IBAction)NextBtnClick:(id)sender;

@end
