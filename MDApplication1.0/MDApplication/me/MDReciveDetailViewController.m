//
//  MDReciveDetailViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDReciveDetailViewController.h"
#import "MDReceiveDetailCell.h"
#import "MDMoneyDetailModel.h"
#import "MDMoneyDetailRequest.h"
#import "TDUserearningsRequest.h"
@interface MDReciveDetailViewController ()

@end

@implementation MDReciveDetailViewController

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    [self resetTableView:_tableview];
    [self addHeaderRefresh];
    [self addFooterRefresh];
//    [self setleftBarItemWith:@"back_ico"];
    [self.tableView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}


- (void)startNeighborFriendsRequest:(NSInteger)page
{
    TDUserearningsRequest *request = [[TDUserearningsRequest alloc]initWithPage:page type:[NSString stringWithFormat:@"%d",_vcType] success:^(AMBaseRequest *request) {
        [self.tableView.mj_header endRefreshing] ;
        
        
        NSArray *list =   [MDMoneyDetailModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"] ];
        if(list.count==0)
            _isLastPage = YES;
        //在数据后面添加数据或清空所有数据
        if (_currentPage == 0 ) {
            [self.items removeAllObjects];
            [self.items addObjectsFromArray:list];
            
        }else if (_currentPage > 0 ){
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    [request start];
}




//下拉刷新
- (void)tableViewHeaderRefresh{
    _currentPage = 0;
    _isLastPage = 0;
    [self startNeighborFriendsRequest:_currentPage];
}

//上拉 加载更多
- (void)tableViewFooterRefresh{
    if (!_isLastPage) {
        
        [self startNeighborFriendsRequest:_currentPage];
        return;
        
    }
//    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MDReceiveDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDReceiveDetailCell"];
    
    cell.model = self.items[indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
