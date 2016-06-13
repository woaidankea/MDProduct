//
//  RootViewController.m
//  UUChatTableView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "RootViewController.h"
#import "UUInputFunctionView.h"
#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import "MJRefresh.h"
#import "TDTicketinfoRequest.h"
#import "MMTService.h"
@interface RootViewController ()<UUInputFunctionViewDelegate,UUMessageCellDelegate,UITableViewDataSource,UITableViewDelegate>

//@property (strong, nonatomic) MJRefreshHeaderView *head;
@property (strong, nonatomic) ChatModel *chatModel;

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation RootViewController{
    UUInputFunctionView *IFView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initBar];
    [self setleftBarItemWith:nil];
    [self addRefreshViews];
    [self loadBaseViewsAndData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)initBar
{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@" private ",@" group "]];
    [segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
}
- (void)segmentChanged:(UISegmentedControl *)segment
{
    self.chatModel.isGroupChat = segment.selectedSegmentIndex;
    [self.chatModel.dataSource removeAllObjects];
    [self.chatModel populateRandomDataSource];
    [self.chatTableView reloadData];
}

- (void)addRefreshViews
{
    __weak typeof(self) weakSelf = self;
    
    //load more
    int pageNum = 3;
    self.chatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
//        [weakSelf.chatModel addRandomItemsToDataSource:pageNum];
        
                if (weakSelf.chatModel.dataSource.count > pageNum) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
        
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.chatTableView reloadData];
                        [weakSelf.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
                    });
                }
                [weakSelf.chatTableView.mj_header endRefreshing];

    }];
}

- (void)loadBaseViewsAndData
{
    self.chatModel = [[ChatModel alloc]init];
    self.chatModel.isGroupChat = NO;
    [self populateRandomDataSource];
    
    IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    IFView.delegate = self;
    [self.view addSubview:IFView];
    
   
}

- (void)populateRandomDataSource {
    self.chatModel.dataSource = [NSMutableArray array];
    //    [self.dataSource addObjectsFromArray:[self additems:5]];
    
    TDTicketinfoRequest *request = [[TDTicketinfoRequest alloc]initWithPage:0 success:^(AMBaseRequest *request) {
        NSArray *items = [UUMessage mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"list"]];
        
        
        NSMutableArray *result = [NSMutableArray array];
        
        for (UUMessage *message in items) {
            
            //            NSDictionary *dataDic = [self getDic];
            UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
            
            //            [message setWithDict:dataDic];
            [message minuteOffSetStart:nil end:message.strTime];
            messageFrame.showTime = message.showDateLabel;
            [messageFrame setMessage:message];
            
            if (message.showDateLabel) {
                //                previousTime = dataDic[@"strTime"];
            }
            [result addObject:messageFrame];
            
        }
        
        
        [self.chatModel.dataSource addObjectsFromArray:result];
        [self.chatTableView reloadData];
        [self tableViewScrollToBottom];
        
        
    } failure:^(AMBaseRequest *request) {
        
    }];
    [request start];
    
    
    
    
    
}




-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    //adjust ChatTableView's height
    if (notification.name == UIKeyboardWillShowNotification) {
        self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
    }else{
        self.bottomConstraint.constant = 40;
    }
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    CGRect newFrame = IFView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    IFView.frame = newFrame;
    
    [UIView commitAnimations];
    
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.chatModel.dataSource.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - InputFunctionViewDelegate
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
//    NSDictionary *dic = @{@"strContent": message,
//                          @"type": @(UUMessageTypeText)};
//    funcView.TextViewInput.text = @"";
//
//    [self dealTheFunctionData:dic];
    
    
    [[MMTService shareInstance]postTicketWithcontent:message images:nil Success:^(id responseObject) {
        if([[responseObject objectForKey:@"code"]floatValue]==0){
            [funcView changeSendBtnWithPhoto:YES];
            [self populateRandomDataSource];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image
{
//    NSDictionary *dic = @{@"picture": image,
//                          @"type": @(UUMessageTypePicture)};
//    [self dealTheFunctionData:dic];
    NSData *img = UIImageJPEGRepresentation(image, 0.5);
    NSArray *array = [NSArray arrayWithObject:img];
    [[MMTService shareInstance]postTicketWithcontent:nil images:array Success:^(id responseObject) {
        if([[responseObject objectForKey:@"code"]floatValue]==0){
            [funcView changeSendBtnWithPhoto:YES];
            [self populateRandomDataSource];
        }
    } failure:^(NSError *error) {
        
    }];
    

}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    NSDictionary *dic = @{@"voice": voice,
                          @"strVoiceTime": [NSString stringWithFormat:@"%d",(int)second],
                          @"type": @(UUMessageTypeVoice)};
    [self dealTheFunctionData:dic];
}

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.messageFrame.message.strName message:@"headImage clicked" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [alert show];
}

@end
