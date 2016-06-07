//
//  MDInfomationViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDInfomationViewController.h"
#import "MDHeadImageCell.h"
#import "AMUserActionSelectView.h"
#import "MDInfomationCell.h"
#import "MDEditNameViewController.h"
#import "AppDelegate.h"
#import "ActionSheetPicker.h"
#import "AbstractActionSheetPicker+Interface.h"
#import "UIColor+HexStringToColor.h"
#import "AMColorAndFontConfig.h"
#import "MDMemberInterestRequest.h"
#import "MDMemberInterestModel.h"
#import "UIImageView+WebCache.h"
#import "AMRequestHelper.h"
#import "AFNetworking.h"
#import "MDMotifyUserInfoRequest.h"
#import "MMTService.h"

@interface MDInfomationViewController ()<UIImagePickerControllerDelegate,SelectPictureDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MDInfomationDelegate>
{
     AMUserActionSelectView *selectPictureView;
     MDMemberInterestModel  *memberModel;
     NSArray *income;
     NSArray *degree;
     NSArray *industry;
     NSArray *colors;
     MDMemberInterestModel  *requestModel;
     NSMutableArray *headerImage;
}
@end

@implementation MDInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    headerImage = [NSMutableArray new];
    income = [NSArray arrayWithObjects:@"1000以下", @"3000以下",@"5000以下",@"8000以下",@"10000以下",@"10000以上",@"20000以上",nil];
    degree = [NSArray arrayWithObjects:@"初中", @"高中",@"专科",@"本科",@"硕士",@"博士",nil];
    industry = [NSArray arrayWithObjects:@"运输", @"互联网",@"金融",@"服务",@"制造",@"文化传媒",@"娱乐",@"学生族",nil];
    colors = [NSArray arrayWithObjects:@"男", @"女", nil];
    
    
    
    
    [self setleftBarItemWith:@"back_ico@2x.png"];
    [self resetTableView:_table];
    [self startMemberInterestRequest];
    
    // Do any additional setup after loading the view.
}
- (void)startMemberInterestRequest
{
    //格式化成json数据
    id jsonObject = [AMTools getLocalJsonDataWithFileName:@"getuserInfo"];
    if(jsonObject){
        
        memberModel = [MDMemberInterestModel mj_objectWithKeyValues:[[jsonObject objectForKey:@"data"] objectForKey:@"member"]];
        
        //        [self setViewControllers:contentItems];
    }

//    __weak MDInfomationViewController *weakSelf =self;
//    MDMemberInterestRequest *request = [[MDMemberInterestRequest alloc]initWithSuccessCallback:^(AMBaseRequest *request) {
//        
//        memberModel =[MDMemberInterestModel mj_objectWithKeyValues:request.responseObject];
//        requestModel = [MDMemberInterestModel mj_objectWithKeyValues:request.responseObject];
//        [self.tableView reloadData];
//    } failureCallback:^(AMBaseRequest *request) {
//      [weakSelf handleResponseError:self request:request treatErrorAsUnknown:YES];
//    }];
//    
//    
//    [request start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark -UITableViewDelegate
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    // Remove seperator inset
//    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//    // Prevent the cell from inheriting the Table View's margin settings
//    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    // Explictly set your cell's layout margins
//    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//}
//这样  分割线的长度 随意控制 想怎么改变怎么改变
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    if(section==1)
    {
        return 5;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 58;
    }
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
        
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,0, kScreenWidth - 40, 40)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = UIColorFromRGB(0x868788);
    
    [header addSubview:titleLabel];
    
    if(section == 1){
    titleLabel.text = @"基本信息";
    }else if(section == 2){
      titleLabel.text = @"安全信息";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
    MDHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDHeadImageCell"];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:memberModel.avatar] placeholderImage:[UIImage imageNamed:@"avatorplaceorder"]];
        return cell;
    }else if (indexPath.section == 1) {
        MDInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDInfomationCell"];
        
        switch (indexPath.row) {

            case 0://性别
                cell.leftLabel.text = @"性别";
                if([memberModel.sex isEqualToString:@"1"]){
                cell.rightLabel.text = @"男";
                }else if([memberModel.sex isEqualToString:@"0"]){
                cell.rightLabel.text = @"女";
                }else{
                cell.rightLabel.text = @"";
                }
                
               
                break;
            case 1://年龄
                cell.leftLabel.text = @"年龄";
                if(memberModel.birthday != nil){
                cell.rightLabel.text = [self ageWithDateOfBirth:memberModel.birthday];
                }
                
                break;
            case 2://学历
                cell.leftLabel.text = @"学历";
                cell.rightLabel.text = [degree objectAtIndex: [memberModel.education integerValue]];
                
                break;
            case 3://行业
                cell.leftLabel.text = @"行业";
                cell.rightLabel.text = [industry objectAtIndex:[memberModel.vocation integerValue]];
              
                break;
            case 4://收入
                cell.leftLabel.text = @"收入";
                cell.rightLabel.text = [income  objectAtIndex:[memberModel.income integerValue]];
              
                break;


                default:
                cell.leftLabel.text = @"";
                cell.rightLabel.text = @"";
            break;}
                return cell;
        }else if (indexPath.section == 2) {
            MDInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDInfomationCell"];
            
            switch (indexPath.row) {
                case 0://学历
                    cell.leftLabel.text = @"手机号";
                    cell.rightLabel.text = memberModel.phone;
                   
                    break;
                case 1://行业
                    cell.leftLabel.text = @"行业";
                    cell.rightLabel.text = [industry objectAtIndex:[memberModel.vocation integerValue]];
                
                    break;
                case 2://收入
                    cell.leftLabel.text = @"收入";
                    cell.rightLabel.text = [income  objectAtIndex:[memberModel.income integerValue]];
                
                    break;
                default:
                    cell.leftLabel.text = @"";
                    cell.rightLabel.text = @"";
                break;}
            return cell;
            }else{
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                return cell;
            }
    
}
//计算年龄
- (NSString *)ageWithDateOfBirth:(NSString *)dateString;
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    
    
    
    
    NSDate *date= [dateFormatter dateFromString:dateString];
    
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    
    return [NSString stringWithFormat:@"%d岁",iAge];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    if (indexPath.section==0) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍照",@"照片图库",nil];
        [sheet showInView:self.view];
    }
    if (indexPath.section==1) {
        switch (indexPath.row) {
//            case 0:{
//                UIStoryboard *story = [UIStoryboard storyboardWithName:@"MDInfomationViewController" bundle:nil];
//                MDEditNameViewController *vc = [story instantiateViewControllerWithIdentifier:@"MDEditNameViewController"];
//                vc.placeName = memberModel.nickname;
//                
//                vc.delegate  =self;
//                [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
//
//           
//            }
//                
//                break;
            case 0:{
                
               
                
                ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:nil rows:colors initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                    //*********一组点击确认按钮做处理************
                    NSLog(@"选择的性别%@",selectedValue);
                    if([selectedValue isEqualToString:@"男"]){
                        memberModel.sex = @"1";
                    }
                    if([selectedValue isEqualToString:@"女"]){
                        memberModel.sex = @"0";
                    }
                    
                    [tableView reloadData];

                    
                    
                    
                } cancelBlock:^(ActionSheetStringPicker *picker) {
                    
                } origin:self.view];
                [actionPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionPicker customizeInterface];
                [actionPicker showActionSheetPicker];
                actionPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
              }break;
            case 1:{
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay  fromDate:[NSDate date]];
                [minimumDateComponents setYear:1950];//最小日期
                NSDate *minDate = [calendar dateFromComponents:minimumDateComponents];
                NSDate *maxDate = [NSDate date];//最大日期，今天
                ActionSheetDatePicker *actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"请选择日期" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date]                                                          target:self action:@selector(dateWasSelected:element:) origin:self.view];
                [actionSheetPicker customizeInterface];
                [actionSheetPicker setMinimumDate:minDate];
                [actionSheetPicker setMaximumDate:maxDate];
                [actionSheetPicker showActionSheetPicker];
                
                
                
                [actionSheetPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionSheetPicker customizeInterface];
              
                actionSheetPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
                

            }
                break;
            case 2:{
                
                
                ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:nil rows:degree initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                    //*********一组点击确认按钮做处理************
                    NSLog(@"选择de学历%@",selectedValue);
                    memberModel.education =[NSString stringWithFormat:@"%ld",[degree indexOfObject:selectedValue]];
                    [tableView reloadData];
                } cancelBlock:^(ActionSheetStringPicker *picker) {
                    
                } origin:self.view];
                [actionPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionPicker customizeInterface];
                [actionPicker showActionSheetPicker];
                actionPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
                
                
            }
                
                break;
            case 3:{
                
                
                ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:nil rows:industry initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                    //*********一组点击确认按钮做处理************
                    NSLog(@"选择de职业%@",selectedValue);
                    
                    
                    memberModel.vocation =[NSString stringWithFormat:@"%ld",[industry indexOfObject:selectedValue]];
                    
                    [tableView reloadData];
                } cancelBlock:^(ActionSheetStringPicker *picker) {
                    
                } origin:self.view];
                [actionPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionPicker customizeInterface];
                [actionPicker showActionSheetPicker];
                actionPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
                
                
            }
                break;
            case 4:{
                
                
                ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:nil rows:income initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                    //*********一组点击确认按钮做处理************
                    NSLog(@"选择de收入%@",selectedValue);
                    memberModel.income = [NSString stringWithFormat:@"%ld",[income indexOfObject:selectedValue]];
                    [tableView reloadData];
                    
                    
                } cancelBlock:^(ActionSheetStringPicker *picker) {
                    
                } origin:self.view];
                [actionPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionPicker customizeInterface];
                [actionPicker showActionSheetPicker];
                actionPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
                
                
            }
                break;
                

                
            default:
                break;
        }
    }
    if (indexPath.section==2) {
        switch (indexPath.row) {
            case 0:{
              
                
                ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:nil rows:degree initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                    //*********一组点击确认按钮做处理************
                    NSLog(@"选择de学历%@",selectedValue);
                     memberModel.education =[NSString stringWithFormat:@"%ld",[degree indexOfObject:selectedValue]];
                     [tableView reloadData];
                } cancelBlock:^(ActionSheetStringPicker *picker) {
                    
                } origin:self.view];
                [actionPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionPicker customizeInterface];
                [actionPicker showActionSheetPicker];
                actionPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
                

            }
                
                break;
            case 1:{
               
                
                ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:nil rows:industry initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                    //*********一组点击确认按钮做处理************
                    NSLog(@"选择de职业%@",selectedValue);
                    
                    
                    memberModel.vocation =[NSString stringWithFormat:@"%ld",[industry indexOfObject:selectedValue]];
                    
                     [tableView reloadData];
                } cancelBlock:^(ActionSheetStringPicker *picker) {
                    
                } origin:self.view];
                [actionPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionPicker customizeInterface];
                [actionPicker showActionSheetPicker];
                actionPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];

            
            }
                break;
            case 2:{
               
                
                ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:nil rows:income initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                    //*********一组点击确认按钮做处理************
                    NSLog(@"选择de收入%@",selectedValue);
                    memberModel.income = [NSString stringWithFormat:@"%ld",[income indexOfObject:selectedValue]];
                     [tableView reloadData];
                    
                    
                } cancelBlock:^(ActionSheetStringPicker *picker) {
                    
                } origin:self.view];
                [actionPicker setPickerBackgroundColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
                [actionPicker customizeInterface];
                [actionPicker showActionSheetPicker];
                actionPicker.toolbar.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
                

            }
                break;
                
            default:
                break;
        }
    }
  
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark -selectPictureDelegate
-(void)actionSelectAlertMethod:(NSInteger)btnTag alertType:(AM_AlertType)alertType{
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [selectPictureView removeFromSuperview];
    ///TODO:增加图片或者相机的权限检查以及提示
    if(btnTag==0){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [picker setAllowsEditing:YES];
            [picker setDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            NSLog(@"图片不可用!");
        }
    }else if(btnTag==1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [picker setAllowsEditing:YES];
            [picker setDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            NSLog(@"相机不可用!");
        }
    }
}



#pragma mark -相机相册协议方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)inf{
    UIImage *image=inf[@"UIImagePickerControllerEditedImage"];
    UIImage *newImage=[AMTools compressImageWithImage:image];
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    [headerImage  addObject:data];
//    __weak MDInfomationViewController *weakSelf =self;
//    [self dismissViewControllerAnimated:NO completion:^{
//        [weakSelf submitHeadPicture:newImage];
//        //       [weakSelf.dataTable reloadData];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)submitHeadPicture:(UIImage *)headImage{
    __weak MDInfomationViewController *weakSelf =self;
    NSString *pictureDataString =[AMTools imageToBase64String:[UIImage imageNamed:@"hand"]];
//    NSMutableDictionary *locationInfo =[AMLocationInfo locationInfoData:@"北京" longitude:@"" latitude:@"" address:@"上海"];
//    NSMutableDictionary *sysytemInof =[AMSystemInfo systemInfoData];
//    NSMutableDictionary *appInfo =[AMAppInfo appInfoData];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"user_ico@2x" ofType:@"png"];
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    NSMutableDictionary *head64 =[NSMutableDictionary dictionaryWithObject: pictureDataString forKey:@"avatar"];
    NSMutableDictionary *paramsDictory = [NSMutableDictionary new];
    [paramsDictory setObject:USER_DEFAULT_KEY(@"token") forKey:@"token"];
    [self uploadImageWithUrl];
//    [AMRequestHelper requestAFURL:@"/api/member/uploadMemberAvatar" httpMethod:@"POST" params:paramsDictory data:head64 complection:^(id result) {
//       
//        
//        
//            NSString *message=@"您的头像已经成功上传到后台服务器";
//            [AMTools showHUDtoWindow:nil title:message delay:2];
//       
////            NSString *message=@"您的头像上传后台服务器失败";
////            [AMTools showHUDtoWindow:nil title:message delay:2];
//        
//    } error:^(NSError *error) {
//        
//    }];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
//    [selectPictureView removeFromSuperview];
    ///TODO:增加图片或者相机的权限检查以及提示
    if(buttonIndex==1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [picker setAllowsEditing:YES];
            [picker setDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            NSLog(@"图片不可用!");
        }
    }else if(buttonIndex==0){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [picker setAllowsEditing:YES];
            [picker setDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            NSLog(@"相机不可用!");
        }
    }

}

/// 上传图片
- (AFHTTPRequestOperation *)uploadImageWithUrl
{
   
     NSMutableDictionary *paramsDictory = [NSMutableDictionary new];
    [paramsDictory setObject:USER_DEFAULT_KEY(@"token") forKey:@"token"];
    NSString *url = @"http://api.aimodou.net/api/member/uploadMemberAvatar";
    UIImage *image = [UIImage imageNamed:@"user_ico@2x.png"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFHTTPRequestOperation *op = [manager POST:url parameters:paramsDictory constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
              // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"avatar" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];  
    
    return op;  
}

//选择时间
- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    NSLog(@"选择的时间%@",selectedDate);
    
   
      memberModel.birthday = [self stringFromDate:selectedDate];
     [self.tableView reloadData];
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
  
    
    return destDateString;
    
}

- (BOOL)checkChange
{
    
    NSDictionary *currentModel = memberModel.mj_keyValues;
    NSDictionary *oldModel = requestModel.mj_keyValues;
    for(NSString *str in [currentModel allKeys]){
        if([[currentModel objectForKey:str] isEqualToString:[oldModel objectForKey:str]])
        {
           
        }else{
            return YES;
        }
    }
    
    return NO;
}

- (IBAction)SaveMotify:(id)sender {
    
//    if([self checkChange]){
//        __weak MDInfomationViewController *weakSelf =self;
//        
//        NSMutableDictionary *params = [NSMutableDictionary new];
//        [params setValue:memberModel.birthday forKey:@"birthday"];
//        [params setValue:memberModel.education forKey:@"education"];
//        [params setValue:memberModel.vocation forKey:@"vocation"];
//        [params setValue:memberModel.nickname forKey:@"nickname"];
//        [params setValue:memberModel.income forKey:@"income"];
//        [params setValue:memberModel.sex forKey:@"sex"];
//        
//        
//        
//        MDMotifyUserInfoRequest *request = [[MDMotifyUserInfoRequest alloc]initWithModel:params success:^(AMBaseRequest *request) {
//            
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//            
//            
//        } failure:^(AMBaseRequest *request) {
//             [weakSelf handleResponseError:self request:request treatErrorAsUnknown:YES];
//        }];
//        
//        
//        [request start];
//    
//    }
    [[MMTService shareInstance]postProfileWithsex:memberModel.sex birthday:memberModel.birthday education:memberModel.education vocation:memberModel.vocation income:memberModel.income images:headerImage Success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
    
}



- (void)EditName:(NSString *)name{
    memberModel.nickname = name;
    [self.tableView reloadData];
}
@end
