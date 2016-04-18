//
//  BaseTableViewController.h
//  AMen
//
//  Created by boli on 15/9/16.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//


#import "AMBaseViewController.h"
#import "Header.h"
#import "MJRefresh.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MDPublicConfig.h"
//#import "DataBase.h"
#import "RDVTabBarController.h"
//#import "LBUserInfo.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
//#import "LBObject.h"
//#import "LBUserInfo.h"
#import "BaseViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;//存放tableView的数据

/**
 *  设定tableView
 *
 *  @param table
 */
- (void)resetTableView:(UITableView *)table;

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


#pragma mark - 缓存数据 -

//- (void)loadCacheData;
//
//- (void)saveCacheData:(NSArray *)items name:(NSString *)name;
//
//- (NSArray *)readCacheDataName:(NSString *)name;
//
//- (void)deleteCacheDataName:(NSString *)name;
//
//
//- (void)saveHTTPCacheData:(id)result name:(NSString *)name;
//
//- (id)readHTTPCacheDataName:(NSString *)name;

@end
