//
//  MDApprenticeViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MDApprenticeViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgimage;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *barCode;
- (IBAction)shareButtonClick:(id)sender;

@end
