//
//  MDBeautifulPicViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDBeautifulPicViewController.h"
#import "MDBeautifulPicViewControlleCell.h"
#import "BeautifulPicRequest.h"
#import "MDBeautifulPicModel.h"
#import "MDBeautifulDetailViewController.h"
#import "AppDelegate.h"
#import "MDSettingViewController.h"
@interface MDBeautifulPicViewController ()

@end

@implementation MDBeautifulPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetTableView:_table];
    
    _currentPage = 0;
    _isLastPage = NO;
    self.items = [NSMutableArray array];
       //下拉刷新
    [self addHeaderRefresh];
    [self addFooterRefresh];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView.mj_header beginRefreshing];
    self.title = @"图赚";
    // Do any additional setup after loading the view.
}




- (void)HTTPLocationRequest:(NSString *)pageType{

    //TODO: 网络连接判断
   
        
        [self startBeautifulPicRequest:pageType];
   
}





//下拉刷新
- (void)tableViewHeaderRefresh{
    _currentPage = 0;
    _totalPage = 0;
    _isLastPage = 0;
    [self HTTPLocationRequest:@"up"];
}

//上拉 加载更多
- (void)tableViewFooterRefresh{
    if (_currentPage < _totalPage) {
        [self HTTPLocationRequest:@"down"];
        
    }
     [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MDBeautifulPicViewControlleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDBeautifulPicViewControlleCell"];
    
    MDBeautifulPicModel *model = self.items[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    

    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MDBeautifulPicViewController" bundle:nil];
    MDBeautifulDetailViewController *vc = [story instantiateViewControllerWithIdentifier:@"MDBeautifulDetailViewController"];
    
    vc.model =self.items[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
   [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
    
    
    
}

- (void)startBeautifulPicRequest:(NSString *)pageType
{
    BeautifulPicRequest *request = [[BeautifulPicRequest alloc] initWithCurrentPage:_currentPage
                                                                          totalPage:100 pageType:pageType success:^(AMBaseRequest *request)
                              {
                                [self.tableView.mj_header endRefreshing];
                                  
                                  _isLastPage = [[request.responseObject objectForKey:@"lastPage"] boolValue];
                                 NSArray *list =   [MDBeautifulPicModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"] ];
                                  //在数据后面添加数据或清空所有数据
                                  if (_currentPage == 0 ) {
                                      [self.items removeAllObjects];
                                      [self.items addObjectsFromArray:list];
                               
                                  }else if (_currentPage >= 1 ){
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

@end
