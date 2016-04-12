//
//  AMBaseTableTableViewController.h
//  AMen
//
//  Created by 曾宏亮 on 15/10/22.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMBaseRequest.h"

@interface AMBaseTableTableViewController : UITableViewController

-(void)setBusyIndicatorVisible:(BOOL)visible;

-(BOOL)handleResponseError:(AMBaseTableTableViewController *)currentController
                   request:(AMBaseRequest *)request
       treatErrorAsUnknown:(BOOL) treated;


//延迟butten的点击
- (void)delayToEnableUserInteraction:(UIButton *)sender;

- (void)addNotification;

- (void)removeNotification;


@property (nonatomic, strong) UINib *cellNib;

@property (nonatomic, strong) NSMutableArray *items;//存放tableView的数据

#pragma mark -- 刷新相关

/**
 *  添加下拉刷新
 */
- (void)addHeaderRefresh;

/**
 *  添加上拉刷新
 */
- (void)addFooterRefresh;

/**
 *  下拉刷新回调
 */
- (void)tableViewHeaderRefresh;

/**
 *  上拉刷新回调
 */
- (void)tableViewFooterRefresh;






@end
