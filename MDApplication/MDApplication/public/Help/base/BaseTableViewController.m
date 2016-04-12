//
//  BaseTableViewController.m
//  AMen
//
//  Created by boli on 15/9/16.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MDArticleCell.h"
#import "FCFileManager.h"
#import "MDShareModel.h"
#import "DXShareTools.h"
#import "UtilsMacro.h"
#import "AppDelegate.h"
@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.items = [NSMutableArray array];
    
    
//    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
}

//-(void)viewDidLayoutSubviews {
//        
//        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//            
//        }
//        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
//            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//        }
//        
//    }
//
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [_tableView setSeparatorInset: UIEdgeInsetsZero];
//    }
//    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [_tableView setLayoutMargins: UIEdgeInsetsZero];
//    }
//
//}
- (void)resetTableView:(UITableView *)table{
    _tableView = table;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = UIColorFromRGB(0xf6f6f6);
        _tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
}

- (void)addHeaderRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self tableViewHeaderRefresh];
    }];
    
    // 马上进入刷新状态
//    [self.tableView.header beginRefreshing];
}

- (void)addFooterRefresh{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self tableViewFooterRefresh];
    }];
}


- (void)tableViewHeaderRefresh{
    NSLog(@"Header refresh");
}

- (void)tableViewFooterRefresh{
    NSLog(@"Footer refresh");
}



#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 缓存数据 -
- (void)saveCacheData:(NSArray *)items name:(NSString *)name{
    NSError *error = nil;
    NSString *path = [NSString stringWithFormat:@"/item/%@/",NSStringFromClass([self class])];
    [FCFileManager createDirectoriesForPath:path error:&error];
    NSAssert(!error, @"创建目录失败");
    NSString *filePath = [NSString stringWithFormat:@"/item/%@/%@.txt",NSStringFromClass([self class]),name];
    [FCFileManager createFileAtPath:filePath withContent:items error:&error];
    NSAssert(!error, @"创建文件失败");
//    [LBFinder enumerateFilesInFolder:path];
}

- (NSArray *)readCacheDataName:(NSString *)name{
//    [LBFinder enumerateFilesInFolder:[NSString stringWithFormat:@"/item/%@",NSStringFromClass([self class])]];
    NSString *path = [NSString stringWithFormat:@"/item/%@/%@.txt",NSStringFromClass([self class]),name];
    NSArray *array = [FCFileManager readFileAtPathAsArray:path];
    return array;
}

- (void)deleteCacheDataName:(NSString *)name{
    NSString *path = [NSString stringWithFormat:@"/item/%@/%@.txt",NSStringFromClass([self class]),name];
    [FCFileManager removeFilesInDirectoryAtPath:path];
}


- (void)saveHTTPCacheData:(id)result name:(NSString *)name{
    NSError *error = nil;
    NSString *path = [NSString stringWithFormat:@"/item/%@/",NSStringFromClass([self class])];
    [FCFileManager createDirectoriesForPath:path error:&error];
    NSAssert(!error, @"创建目录失败");
    NSString *filePath = [NSString stringWithFormat:@"/item/%@/%@.txt",NSStringFromClass([self class]),name];
    [FCFileManager createFileAtPath:filePath withContent:result error:&error];
    NSAssert(!error, @"创建文件失败");
//    [LBFinder enumerateFilesInFolder:path];
}

- (id)readHTTPCacheDataName:(NSString *)name{
//    [LBFinder enumerateFilesInFolder:[NSString stringWithFormat:@"/item/%@",NSStringFromClass([self class])]];
    NSString *path = [NSString stringWithFormat:@"/item/%@/%@.txt",NSStringFromClass([self class]),name];
    return [FCFileManager readFileAtPathAsDictionary:path];
}

- (void)choseButton:(UIButton *)sender{
    
    if(!USER_DEFAULT_KEY(@"token")){
        
              [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
        return;
        

    }
    UIView *v = [sender superview];//获取父类view
    
    UITableViewCell *cell = (UITableViewCell *)[v superview];//获取cell
    NSIndexPath *indexPathAll = [self.tableView indexPathForCell:cell];//获取cell对应的section
    //    [self share:self.items[indexPathAll.row]];
    NSMutableArray *shareAry = [NSMutableArray new];
    
    NSDictionary *share_wx = @{@"image":@"share_wx",
                               @"title":@"微信"};
    NSDictionary *share_wx_timeline = @{@"image":@"share_wx_timeline",
                                        @"title":@"朋友圈"};
    NSDictionary *share_qq = @{@"image":@"share_qq",
                               @"title":@"QQ"};
    NSDictionary *share_weibo = @{@"image":@"share_weibo",
                                  @"title":@"新浪微博"};
    NSDictionary *share_qzone = @{@"image":@"share_qzone",
                                  @"title":@"QQ空间"};
    
    
    ShareModel *sharemodel = [[ShareModel alloc]init];
    MDArticleModel *t_model = self.items[indexPathAll.row];
    
    
    for(MDShareModel *share in t_model.shareConfig){
   
        if(share.show==YES){
            if([share.platform isEqualToString:@"1"]){
                [shareAry addObject:share_qq];
            }
            if([share.platform isEqualToString:@"2"]){
                [shareAry addObject:share_weibo];
            }
            
            if([share.platform isEqualToString:@"3"]){
                [shareAry addObject:share_wx];
            }
            
            if([share.platform isEqualToString:@"4"]){
                [shareAry addObject:share_wx_timeline];
            }
            
            if([share.platform isEqualToString:@"5"]){
                [shareAry addObject:share_qzone];
            }
            
            
            
        }
        
    }
    
    
    
    
    sharemodel.title = t_model.title;
    sharemodel.url = t_model.assignUrl;
    sharemodel.imageArray = @[t_model.cover];
    sharemodel.desc = t_model.desc;
    [DXShareTools shareToolsInstance].isPic = NO;
    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel view:[UIApplication sharedApplication].keyWindow];
    
    
}

@end
