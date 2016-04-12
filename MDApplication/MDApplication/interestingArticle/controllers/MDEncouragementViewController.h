//
//  MDEncouragementViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MDEncouragementViewController : BaseTableViewController
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic,assign)BOOL isLastPage;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
