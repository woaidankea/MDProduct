//
//  RankingViewController.h
//  MDApplication
//
//  Created by jieku on 16/5/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewController.h"

@interface RankingViewController : BaseTableViewController
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isLastPage;

@property(assign,nonatomic)MD_ENTER_USERINFO enterType;

@end
