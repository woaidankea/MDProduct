//
//  MDNewsViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ContentModel.h"
@interface MDNewsViewController : BaseTableViewController
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic,assign)BOOL isLastPage;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong)NSString *model;

@end
