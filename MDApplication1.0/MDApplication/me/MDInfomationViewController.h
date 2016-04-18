//
//  MDInfomationViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewController.h"



@interface MDInfomationViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)SaveMotify:(id)sender;

@end
