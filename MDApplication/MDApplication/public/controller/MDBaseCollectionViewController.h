//
//  MDBaseCollectionViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
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
@interface MDBaseCollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic, weak) UICollectionView *collectionview;
@property (nonatomic, strong) NSMutableArray *items;//存放tableView的数据


/**
 *  设定collectionview
 *
 *  @param table
 */
- (void)resetCollectionView:(UICollectionView *)collection;

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
