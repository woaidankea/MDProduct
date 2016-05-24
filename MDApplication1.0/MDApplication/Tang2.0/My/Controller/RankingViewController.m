//
//  RankingViewController.m
//  MDApplication
//
//  Created by jieku on 16/5/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "RankingViewController.h"
#import "MDDiscipleCell.h"
#import "MDPupilRequest.h"
#import "MDPupilModel.h"
#import "MDRankingRequest.h"
#import "MDRankModel.h"
#import "MDTXModel.h"
#import "MDTXRequest.h"
#import "MDDiscipleCell.h"
@interface RankingViewController ()
@property (strong, nonatomic) UITableView *table;
@end

@implementation RankingViewController

-(void)viewDidDisappear:(BOOL)animated{
    [self.items removeAllObjects];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
       [self.tableView.mj_header beginRefreshing];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
      [self.view addSubview:self.table];
    [self resetTableView:self.table];
    _table.separatorColor = [UIColor clearColor];
    [self addFooterRefresh];
    [self addHeaderRefresh];
    [self setleftBarItemWith:@"back_ico"];
   
    
    
    // Do any additional setup after loading the view.
}
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _table.showsHorizontalScrollIndicator = NO;
        _table.showsVerticalScrollIndicator = NO;
//        [_table registerClass:[MDDiscipleCell class] forCellReuseIdentifier:@"MDDiscipleCell"];
        [_table registerNib:[UINib nibWithNibName:@"MDDiscipleCell" bundle:nil] forCellReuseIdentifier:@"MDDiscipleCell"];
        
    }
    return _table;
}


- (void)startRequest:(MD_ENTER_USERINFO)pageType
{

        MDRankingRequest *request = [[MDRankingRequest alloc]initRequestsuccess:^(AMBaseRequest *request) {
            [self.tableView.mj_header endRefreshing];
            NSArray *list  = [MDRankModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"] ];
            
            _isLastPage = YES;
            
            [self.items removeAllObjects];
            [self.items addObjectsFromArray:list];
            
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
    _isLastPage = NO;
    [self startRequest:self.enterType];
    
    
}

//上拉 加载更多
- (void)tableViewFooterRefresh{
    if (!_isLastPage) {
        [self startRequest:self.enterType];
        return;
    }
    //    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MDDiscipleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDDiscipleCell"];
    
    if(self.enterType==MD_Disciple||self.enterType==MD_DiscipleUp){
        
        cell.pupilModel = self.items[indexPath.row];
        cell.First.text = [NSString stringWithFormat:@"%ld",((long)(indexPath.row+1))];
    }
    if(self.enterType == MD_Ranking){
        cell.rankModel = self.items[indexPath.row];
        cell.First.text = [NSString stringWithFormat:@"%ld",((long)(indexPath.row+1))];
    }
    if(self.enterType == MD_DepositT){
        cell.txModel = self.items[indexPath.row];
        //        cell.First.text = [NSString stringWithFormat:@"%ld",((long)(indexPath.row+1))];
        
    }
    
    return cell;
}



@end
