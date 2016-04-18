//
//  MDDiscipleDetailViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MDPublicConfig.h"
@interface MDDiscipleDetailViewController : BaseTableViewController

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isLastPage;

@property(assign,nonatomic)MD_ENTER_USERINFO enterType;
@property (weak, nonatomic) IBOutlet UITableView *table;


@property (weak, nonatomic) IBOutlet UILabel *ROW_First;
@property (weak, nonatomic) IBOutlet UILabel *ROW_Second;

@property (weak, nonatomic) IBOutlet UILabel *ROW_Third;

@end
