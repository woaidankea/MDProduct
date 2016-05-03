//
//  MdMeCollectionViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMeCollectionViewController.h"
#import "MDMeTopCollectionViewCell.h"
#import "MDMeSecondCell.h"
#import "MDReciveDetailViewController.h"
#import "MDDiscipleDetailViewController.h"
#import "AppDelegate.h"
#import "MDSettingViewController.h"
#import "MDInfomationViewController.h"
#import "MDLoginViewController.h"
#import "MDGetMemberInfoRequest.h"
#import "MDUserInfoModel.h"
#import "MDMeCollectionCell.h"
#import "MDFourthCollectionCell.h"
#import "MDWKWebViewController.h"


#import "AMColorAndFontConfig.h"
#import "RewardInfo.h"
#import "UIWindow+RedPacket.h"
#import "AppDelegate.h"
#import "RewardInfo.h"
#import "UIWindow+RedPacket.h"
#import "MDRedPacketRequest.h"
@interface MDMeCollectionViewController ()
@property (nonatomic,strong)MDUserInfoModel *model;
@end
NSString * const kMeReloadData = @"MeReloadData";
@implementation MDMeCollectionViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startBeautifulPicRequest];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MeReloadData) name:kMeReloadData object:nil];

}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kMeReloadData object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    _model = [[MDUserInfoModel alloc]init];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self resetCollectionView:_collection];
    _collection.alwaysBounceVertical = YES;
    _collection.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    [self addHeaderRefresh];
   
    [_collection registerNib:[UINib nibWithNibName:@"MDMeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MDMeCollectionCell"];
    [_collection registerNib:[UINib nibWithNibName:@"MDFourthCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MDFourthCollectionCell"];
    self.title = @"我";

}

- (void)MeReloadData {
    [self startBeautifulPicRequest];
}


//下拉刷新
- (void)tableViewHeaderRefresh{
//    _currentPage = 1;
//    _totalPage = 0;
//    _isLastPage = 0;
    [self  startBeautifulPicRequest];
//    [self.collectionview.mj_header endRefreshing];
//    [self HTTPLocationRequest:MD_Rec];
}

- (void)startBeautifulPicRequest
{
    
    __weak MDMeCollectionViewController *weakSelf =self;
    MDGetMemberInfoRequest *request = [[MDGetMemberInfoRequest alloc]initWithToken:USER_DEFAULT_KEY(@"token")success:^(AMBaseRequest *request) {
        
        [weakSelf.collectionview.mj_header endRefreshing];
        _model =  request.responseObject;
        [weakSelf.collectionview reloadData];
        if(!_model.issign){
        
//            [self initRedPacketWindowNeedOpen:info];
            RewardInfo *info = [[RewardInfo alloc] init];
            info.money = 100.0;
            info.rewardName = @"每日签到";
            info.rewardContent = @"恭喜你得到红包~";
            info.rewardStatus = 0;
//
            [[UIApplication sharedApplication].keyWindow initRedPacketWindow:info];
        }
        

        
    } failure:^(AMBaseRequest *request) {
          [weakSelf.collectionview.mj_header endRefreshing];
          [weakSelf handleResponseError:self request:request treatErrorAsUnknown:YES];
        
    }];
    
    
    [request start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }
    if(section ==1)
    {
        return 4;
    }
    return 8;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"cell";
    MDMeTopCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if(indexPath.section==1){
        
        static NSString * CellIdentifier = @"MDMeCollectionCell";
        MDMeCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        //           cell.backgroundColor = [UIColor redColor];
        if(indexPath.row==0){
            cell.Title.text = @"今日收入(元)";
            if(ServerJieKu){
                cell.content.text = _model.todayincome;
            }else{
                cell.content.text = _model.todayIncome;
            }
          
        }
        if(indexPath.row==1){
            cell.Title.text = @"昨日收入(元)";
            if(ServerJieKu){
                cell.content.text = _model.yesterdayincome;
            }else{
                cell.content.text = _model.yesterdayIncome;
            }

           
        }
        if(indexPath.row==2){
            cell.Title.text = @"我的徒弟人数";
            if(ServerJieKu){
                cell.content.text = _model.tudicount;
            }else{
                cell.content.text = _model.pupilNum;
            }
           
        }
        if(indexPath.row==3){
            cell.Title.text = @"徒弟进贡";
            
            if(ServerJieKu){
                cell.content.text = _model.tudijingong;
            }else{
                cell.content.text = _model.pupilPayIncome;
            }

           
        }
        return cell;
    }
    
    if(indexPath.section==2){
        
        static NSString * CellIdentifier = @"secondcell";
        MDMeSecondCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//           cell.backgroundColor = [UIColor redColor];
            if(indexPath.section==2&&indexPath.row==0){
            cell.Title.text = @"我要提现";
            cell.Image.image = [UIImage imageNamed:@"ico5"];
            cell.SubTitle.text = @"微信提现,支付宝提现";
        } if(indexPath.section==2&&indexPath.row==1){
            cell.Title.text = @"提现记录";
            cell.Image.image = [UIImage imageNamed:@"ico6"];
            cell.SubTitle.text = @"记录明细";

        }
        
        
       
        if(indexPath.section==2&&indexPath.row>=2){
            static NSString * CellIdentifier = @"MDFourthCollectionCell";
            MDFourthCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
            
        if(indexPath.section==2&&indexPath.row==2){
            cell.Title.text = @"个人设置";
            cell.Image.image = [UIImage imageNamed:@"ico7"];
            
        }
        if(indexPath.section==2&&indexPath.row==3){
            cell.Title.text = @"完善资料";
            cell.Image.image = [UIImage imageNamed:@"ico8"];
            
        }
        if(indexPath.section==2&&indexPath.row==4){
            cell.Title.text = @"转客排行";
            cell.Image.image = [UIImage imageNamed:@"ico9"];
           
        }
        if(indexPath.section==2&&indexPath.row==5){
            cell.Title.text = @"收徒教程";
            
            cell.Image.image = [UIImage imageNamed:@"ico10"];
            
        }
        if(indexPath.section==2&&indexPath.row==6){
            cell.Title.text = @"提交工单";
            cell.Image.image = [UIImage imageNamed:@"ico11"];
            
        }
        if(indexPath.section==2&&indexPath.row==7){
            cell.Title.text = @"商务联系";
            cell.Image.image = [UIImage imageNamed:@"ico12"];
            
        }
            return cell;
            
        }
         return cell;
    }
    if(ServerJieKu){
       cell.Account.text = _model.totalmoney;
    }else{
        
    cell.Account.text = _model.money;
    }
    
    return cell;

////    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
//    cell.backgroundColor = [UIColor redColor];
   
}

#pragma mark UICollectionViewFlowLayoutDelegate
//元素大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==1){
        if(iPhone5){
            return CGSizeMake(160, 90);
        }
        else if(iPhone6Pus){
            
            return CGSizeMake(207, 90);
            
        }
        return CGSizeMake(375/2, 90);
    }
    if(indexPath.section==2){
        if(iPhone5){
            return CGSizeMake(160, 75);
        }
        else if(iPhone6Pus){
            
            return CGSizeMake(207, 75);
            
        }
        return CGSizeMake(375/2, 75);
    }

    
    
    if(iPhone5){
        return CGSizeMake(320, 90);
    }
    else if(iPhone6Pus){
        
    return CGSizeMake(414, 90);
 
    }
    
    return CGSizeMake(375, 90);
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    if(section==1)
//    {
//        return 0;
//    }
//    else{
        return 0;
//    }

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section ==0){
    return  CGSizeMake(320, 0);
    }
    return CGSizeMake(320, 12);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    
    //收入明细
    if(indexPath.section==0&&indexPath.row==0){
    UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
    MDReciveDetailViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDReciveDetailViewController"];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];
    }
    else{
        UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDMeCollectionViewController" bundle:nil];
        MDDiscipleDetailViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDDiscipleDetailViewController"];
        
      
        
        if(indexPath.section==1&&indexPath.row==0){
           
            return;
        }
        if(indexPath.section==1&&indexPath.row==1){
            return;


        }
               if(indexPath.section==1&&indexPath.row==2){
            myContr.enterType = MD_Disciple;
           
        } if(indexPath.section==1&&indexPath.row==3){
            myContr.enterType = MD_DiscipleUp;
        }
        
        if(indexPath.section == 2 && indexPath.row == 0)
        {
            //我要提现
            MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
            NSString *outCome = [NSString stringWithFormat:@"http://h.51tangdou.com/weizuan/?m=cash&a=timoney&token=%@",USER_DEFAULT_KEY(@"token")];
            vc.url = outCome;
            [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
            return;
            
        }

        if(indexPath.section==2&&indexPath.row==1){
            myContr.enterType = MD_DepositT;
        }
        
        if(indexPath.section==2&&indexPath.row==2){
//            cell.Title.text = @"个人设置";
            UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDSettingViewController" bundle:nil];
            MDSettingViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDSettingViewController"];
            
           [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];
            return;
            
        }
        if(indexPath.section==2&&indexPath.row==3){
//            cell.Title.text = @"完善资料";
            UIStoryboard *userInfoStoryboard = [UIStoryboard storyboardWithName:@"MDInfomationViewController" bundle:nil];
            MDInfomationViewController *myContr = [userInfoStoryboard instantiateViewControllerWithIdentifier:@"MDInfomationViewController"];
            
            [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];
            return;

            
        }
        if(indexPath.section==2&&indexPath.row==4){
//"转客排行"
            myContr.enterType = MD_Ranking;
        }
        if(indexPath.section==2&&indexPath.row==5){
//收徒教程
           
            MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
            vc.url = @"http://60.173.8.139/weizuan/help/4.html";
            [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
            return;

        }
        if(indexPath.section==2&&indexPath.row==6){
//          提交工单
            MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
            NSString *outCome = [NSString stringWithFormat:@"http://h.51tangdou.com/weizuan/help/workorder.html?token=%@",USER_DEFAULT_KEY(@"token")];
            vc.url =outCome;
            [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
            return;
          
        }
        if(indexPath.section==2&&indexPath.row==7){
            //商务联系
            MDWKWebViewController *vc = [[MDWKWebViewController alloc]init];
            vc.url = @"http://h.51tangdou.com/weizuan/help/service.html";
            [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
            return;
        }

        
        
        
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:myContr animated:YES];


    }
    
    
    
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
