//
//  MDRecViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDRecViewController.h"
#import "MDNewsCell.h"
#import "MDArticleCell.h"
#import "MDNewsRequest.h"
#import "MDPublicConfig.h"
#import "MDArticleModel.h"
#import "MDInterestDetailViewController.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "HXEasyCustomShareView.h"
#import "DXShareTools.h"
#import "MDShareModel.h"

#define CGMMainScreenWidth            ([[UIScreen mainScreen] bounds].size.width)
#define CGMMainScreenHeight           ([[UIScreen mainScreen] bounds].size.height)

@interface MDRecViewController ()<ArticleCellDelegate>

@end

@implementation MDRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self resetTableView:_table];
  
    _table.contentInset = UIEdgeInsetsMake(64 + 50, 0, 49, 0);
    [_table registerNib:[UINib nibWithNibName:@"MDArticleCell" bundle:nil] forCellReuseIdentifier:@"MDArticleCell"];
    _table.cellLayoutMarginsFollowReadableWidth = NO;
    _currentPage = 0;
    _isLastPage = NO;
    self.items = [NSMutableArray array];
    //下拉刷新
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
    [self.tableView.mj_header beginRefreshing];
    

    // Do any additional setup after loading the view.
}
- (void)HTTPLocationRequest:(MD_Request_Type)pageType{
    
    //TODO: 网络连接判断
    
    
    [self startBeautifulPicRequest:pageType];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // Remove seperator inset
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
//这样  分割线的长度 随意控制 想怎么改变怎么改变

//下拉刷新
- (void)tableViewHeaderRefresh{
    _currentPage = 0;
    _totalPage = 0;
    _isLastPage = 0;
//    [self.tableView.mj_header endRefreshing];
    [self HTTPLocationRequest:MD_Rec];
}

//上拉 加载更多
- (void)tableViewFooterRefresh{
    if (!_isLastPage) {
        [self HTTPLocationRequest:MD_Rec];
        
    }
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
- (void)startBeautifulPicRequest:(MD_Request_Type)pageType
{
    MDNewsRequest *request = [[MDNewsRequest alloc] initWithCurrentPage:_currentPage
                                                                          totalPage:100 pageType:pageType success:^(AMBaseRequest *request)
                                    {
                                        [self.tableView.mj_header endRefreshing];
                                        
                                 
                                        NSArray *list =   [MDArticleModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"] ];
                                        
                                      
                                     
                                        
                                        
                                        if(list.count==0)
                                        _isLastPage = YES;
                                        //在数据后面添加数据或清空所有数据
                                        if (_currentPage == 0 ) {
                                            [self.items removeAllObjects];
                                            [self.items addObjectsFromArray:list];
                                            
                                        }else if (_currentPage >=1 ){
                                            [self.items addObjectsFromArray:list];
                                            
                                        }else{
                                            NSLog(@"数据对接顺序错误");
                                        }
                                        
                                        _currentPage++;
                                        
                                        [self.tableView reloadData];
                                        
                                        //添加上拉刷新
                                        if (!_isLastPage) {
                                            [self.tableView.mj_footer resetNoMoreData];
                                        }else{
                                            [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                        }
                                        
                                        
                                    } failure:^(AMBaseRequest *request) {
                                        [self handleResponseError:self request:request treatErrorAsUnknown:YES];
                                        //                                             [self.tableView.header endRefreshing];
                                    }];
    [request start];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MDArticleCell";
    MDArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    MDArticleModel *model = self.items[indexPath.row];
    cell.model = model;
    cell.delegate =self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MDInterestingArticleViewController" bundle:nil];
    MDInterestDetailViewController *vc = [story instantiateViewControllerWithIdentifier:@"MDInterestDetailViewController"];
    
    vc.model =self.items[indexPath.row];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
    
    
    
}

@end
