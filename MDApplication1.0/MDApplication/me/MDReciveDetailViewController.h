//
//  MDReciveDetailViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MDPublicConfig.h"
@interface MDReciveDetailViewController : BaseTableViewController
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isLastPage;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,assign)MD_Receive_Type *vcType;

@end
