//
//  MDDiscipleDetailViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDDiscipleDetailViewController.h"
#import "MDDiscipleCell.h"
#import "MDPupilRequest.h"
#import "MDPupilModel.h"
#import "MDRankingRequest.h"
#import "MDRankModel.h"
@interface MDDiscipleDetailViewController ()

@end

@implementation MDDiscipleDetailViewController
-(void)viewDidDisappear:(BOOL)animated{
    [self.items removeAllObjects];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    if(self.enterType==MD_Disciple||self.enterType==MD_DiscipleUp){
        
        [self createMDDisciple];
//        NSInteger accountId=[[NSUSERDEFAULIT objectForKey:AM_USER_ACCOUNTID]integerValue];
//        _userInfo=[[AMDataManager shareInstance]getFriendInfoByFriendId:accountId];
//        //先使用本地数据加载界面
//        [self.tableView reloadData];
//        //获取网络数据刷新界面
//        [self loadUserInfoData];
    }
    if(self.enterType == MD_DepositT){
        [self createMDDeposity];
    }
    if(self.enterType == MD_Ranking){
        [self createMDRanking];
    }
    [self.tableView.mj_header beginRefreshing];
  


}
//转客排行
-(void)createMDRanking{
    self.title = @"转客排行";
    self.ROW_First.text = @"排名";
    self.ROW_Second.text = @"用户";
    self.ROW_Third.text = @"收益";

}
//我的提现记录
- (void)createMDDeposity{
    self.title = @"提现记录";
    self.ROW_First.text = @"时间";
    self.ROW_Second.text = @"状态";
    self.ROW_Third.text = @"金额";

}
//我的收徒


- (void)createMDDisciple{
    
    self.title = @"我的徒弟";
    self.ROW_First.text = @"排名";
    self.ROW_Second.text = @"徒弟";
    self.ROW_Third.text = @"进贡收益";

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetTableView:_table];
    _table.separatorColor = [UIColor clearColor];
    [self addFooterRefresh];
    [self addHeaderRefresh];
    [self setleftBarItemWith:@"back_ico@2x.png"];
    
    

    // Do any additional setup after loading the view.
}



- (void)startRequest:(MD_ENTER_USERINFO)pageType
{
    if(pageType==MD_Disciple || pageType==MD_DiscipleUp){
            MDPupilRequest *request = [[MDPupilRequest alloc]initWithPage:_currentPage  success:^(AMBaseRequest *request) {
                   [self.tableView.mj_header endRefreshing];
                NSArray *list  = [MDPupilModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"] ];
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
            }];
            [request start];
            
    }else if(pageType == MD_Ranking){
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
        }];
        [request start];
    
    
    }
    
    
    
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
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
