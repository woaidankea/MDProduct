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
#import "TangRankingCell.h"
#import "TDRevrankRequest.h"
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
//    [self addFooterRefresh];
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
      [_table registerClass:[TangRankingCell class] forCellReuseIdentifier:@"rankCell"];
        
    }
    return _table;
}


- (void)startRequest:(MD_ENTER_USERINFO)pageType
{
    
    TDRevrankRequest *request = [[TDRevrankRequest alloc]initTDRevrankWithtype:_type date:@"3" success:^(AMBaseRequest *request) {
        [self.tableView.mj_header endRefreshing];
                NSArray *list  = [MDRankModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"] ];
        
                    _isLastPage = YES;
        
                    [self.items removeAllObjects];
                    [self.items addObjectsFromArray:list];
        
                    [self.tableView reloadData];
        

    } failure:^(AMBaseRequest *request) {
        [self handleResponseError:self request:request treatErrorAsUnknown:YES];
                   [self.tableView.mj_header endRefreshing];
        
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TangRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankCell"];
    
    [cell.sortImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row + 1]]];
    MDRankModel *model = [self.items objectAtIndex:indexPath.row];
    [cell.avatorView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"avatorplaceorder"]];
    cell.contentLabel.text = [NSString stringWithFormat:@"%.2f￥",[model.totalmoney floatValue]];
    cell.accountLabel.text =  [model.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return cell;
}



@end
