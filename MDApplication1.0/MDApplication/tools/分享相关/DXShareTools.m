//
//  DXShareTools.m
//  MDApplication
//
//  Created by jieku on 16/3/29.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "DXShareTools.h"
#import <ShareSDK/ShareSDK.h>
#import "HXEasyCustomShareView.h"
#define CGMMainScreenWidth            ([[UIScreen mainScreen] bounds].size.width)
#define CGMMainScreenHeight           ([[UIScreen mainScreen] bounds].size.height)
#import "UIColor+HexStringToColor.h"
#import "AMColorAndFontConfig.h"
#import "RewardInfo.h"
#import "UIWindow+RedPacket.h"
#import "AppDelegate.h"
#import "MDAddShareRequest.h"
#import "UIWindow+ShareSucAlert.h"
@interface DXShareTools()
@property (nonatomic,strong)HXEasyCustomShareView *shareView;
@end
@implementation ShareModel


@end



@implementation DXShareTools
@synthesize shareView;

static DXShareTools *_shareTools = nil;
+(DXShareTools *)shareToolsInstance
{
    if (_shareTools == nil)
    {
        _shareTools = [[DXShareTools alloc] init];
        
    }
    return _shareTools;
}
- (id)init{
    self = [super init];
    shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    return  self;
}
#pragma -- showAction

-(void)showShareView:(NSArray *)shareAry contentModel:(ShareModel *) model view:(UIView *)view{
    CurrentModel = model;
    
    
    
     shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    //    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    //    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor ColorWithHexString:MD_TitleRed_Color]forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,CGMMainScreenWidth-20,1)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    [shareView.cancleButton addSubview:lineLabel1];
    [view addSubview:shareView];
    
    
}



-(void)showShareView:(UIViewController *)uiViewController isFollow:(BOOL)follow
{
    
    
    NSArray *shareAry = @[@{@"image":@"share_wx",
                            @"title":@"微信"},
                          @{@"image":@"share_wx_timeline",
                            @"title":@"朋友圈"},
                          @{@"image":@"share_qq",
                            @"title":@"QQ"},
                          @{@"image":@"share_weibo",
                            @"title":@"新浪微博"},
                          @{@"image":@"share_qzone",
                            @"title":@"QQ空间"}];
    
    //    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 54)];
    //    headerView.backgroundColor = [UIColor clearColor];
    //
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.textColor = [UIColor blackColor];
    //    label.backgroundColor = [UIColor clearColor];
    //    label.font = [UIFont systemFontOfSize:15];
    //    label.text = @"分享到";
    //    [headerView addSubview:label];
    //
    //    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-0.5, headerView.frame.size.width, 0.5)];
    //    lineLabel.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    //    [headerView addSubview:lineLabel];
    //

    //
    
}

- (void)easyCustomShareViewButtonAction:(HXEasyCustomShareView *)shareView title:(NSString *)title {
    
    //创建分享参数
//    NSMutableArray *arrar = [NSMutableArray new];
//    UIImage *image = [UIImage imageNamed:@"ceshitupian.jpg"];
//    [arrar addObject:image];
    NSInteger type = 0;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    if(!_isPic){
    [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                     images:CurrentModel.imageArray //传入要分享的图片
                                        url:[NSURL URLWithString:CurrentModel.url]
                                      title:CurrentModel.title
                                       type:SSDKContentTypeWebPage];
        if([title isEqualToString:@"微信"]){
            type =SSDKPlatformSubTypeWechatSession;
        }
        if([title isEqualToString:@"朋友圈"]){
            type = SSDKPlatformSubTypeWechatTimeline;
        }
        if([title isEqualToString:@"QQ"]){
            type = SSDKPlatformSubTypeQQFriend;
        }
        if([title isEqualToString:@"新浪微博"]){
            type =SSDKPlatformTypeSinaWeibo;
        }
        if([title isEqualToString:@"QQ空间"]){
            type = SSDKPlatformSubTypeQZone;
        }
    }else {
    //进行分享
    
   
    if([title isEqualToString:@"微信"]){
        type =SSDKPlatformSubTypeWechatSession;
        [shareParams SSDKSetupWeChatParamsByText:nil title:CurrentModel.title url:nil thumbImage:nil image:[CurrentModel.imageArray objectAtIndex:0] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    }
    if([title isEqualToString:@"朋友圈"]){
        type = SSDKPlatformSubTypeWechatTimeline;
        [shareParams SSDKSetupWeChatParamsByText:nil title:CurrentModel.title url:nil thumbImage:nil image:[CurrentModel.imageArray objectAtIndex:0] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    }
    
    if([title isEqualToString:@"QQ"]){
        type = SSDKPlatformSubTypeQQFriend;
        [shareParams SSDKSetupQQParamsByText:nil title:CurrentModel.title url:nil thumbImage:nil image:[CurrentModel.imageArray objectAtIndex:0] type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeQQFriend];
        
        
        
    }
    
    if([title isEqualToString:@"新浪微博"]){
        type =SSDKPlatformTypeSinaWeibo;
        [shareParams SSDKSetupSinaWeiboShareParamsByText:@"" title:CurrentModel.title image:[CurrentModel.imageArray objectAtIndex:0]  url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeImage];
    }
    
    if([title isEqualToString:@"QQ空间"]){
        type = SSDKPlatformSubTypeQZone;
//        type = SSDKPlatformSubTypeQQFriend;
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
    }
    
    }
    
    if (_isApprentice && CurrentModel.imageArray.count == 2 && [title isEqualToString:@"朋友圈"]){
        if([title isEqualToString:@"朋友圈"]){
            type = SSDKPlatformSubTypeWechatTimeline;
            [shareParams SSDKSetupWeChatParamsByText:nil title:CurrentModel.title url:nil thumbImage:nil image:[CurrentModel.imageArray objectAtIndex:1] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
        }

    
    }
    
//     [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    
    [shareParams SSDKEnableUseClientShare];
    
    
    
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                     message:nil
//                                                                    delegate:self
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
                 
                 //   1.qq  kongjian  pengyouquan  wx  weibo
                 NSInteger platform = 0 ;
                 if(type == SSDKPlatformSubTypeQQFriend){
                     platform = 1;
                 
                 }
                 if(type == SSDKPlatformTypeSinaWeibo){
                     platform = 5;
                 }
                 if(type == SSDKPlatformSubTypeWechatSession){
                     platform = 4;
                 }
                 if(type == SSDKPlatformSubTypeWechatTimeline){
                     platform = 3;
                 }
                 if(type == SSDKPlatformSubTypeQZone){
                     platform = 2;
                 }
                
                 if (CurrentModel.key != nil){
                 MDAddShareRequest *request=[[MDAddShareRequest alloc]initWithContentID:CurrentModel.key Platform: platform success:^(AMBaseRequest *request) {
                     
                     BOOL isvalid  =  [[request.responseObject objectForKey:@"isvalid"] boolValue];
                     
                     
                     NSLog(@"response = %@",request.responseObject);
                     if(isvalid){
                         
                         //            [self initRedPacketWindowNeedOpen:info];
                         
                         RewardInfo *info = [[RewardInfo alloc] init];
                         info.money = [[request.responseObject objectForKey:@"sendusermoney"] floatValue];
                         //                info.rewardName = @"分享成功获得";
                         //                info.rewardContent = @"恭喜你得到奖励";
                         //                info.rewardStatus = 0;
                         //
                         [[UIApplication sharedApplication].keyWindow initRedPacketWindow1:info];
//                         RewardInfo *info = [[RewardInfo alloc] init];
//                         info.money = [[request.responseObject objectForKey:@"sendusermoney"] floatValue];
//                         info.rewardName = @"分享成功获得";
//                         info.rewardContent = @"恭喜你得到奖励";
//                         info.rewardStatus = 0;
//                         //
//                         [[UIApplication sharedApplication].keyWindow initRedPacketWindowNeedOpen:info];
                     }
                     

                     
                     
                     
                     
//                     [_weakSelf setBusyIndicatorVisible:NO];
//                     [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
                     
                 } failure:^(AMBaseRequest *request) {
////                     [_weakSelf setBusyIndicatorVisible:NO];
//                     if(request.response.statusCode==300){
//                     }
//                     else{
//                         [_weakSelf handleResponseError:self request:request treatErrorAsUnknown:YES];
//                     }
                 }];
                 
                 [request start];
                 }
                 


                 break;
             }
             case SSDKResponseStateFail:
             {
                 if([error.domain isEqualToString:@"ShareSDKErrorDomain"]){
                     
                     
                     if(type == SSDKPlatformSubTypeQQFriend ||type == SSDKPlatformSubTypeQZone){
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您没有安装QQ客户端"
                                                                         message:nil
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];

                         
                     }
                     if(type == SSDKPlatformTypeSinaWeibo){
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您没有安装新浪客户端"
                                                                         message:nil
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];
                     }
                     if(type == SSDKPlatformSubTypeWechatSession || type == SSDKPlatformSubTypeWechatTimeline){
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您没有安装微信客户端"
                                                                         message:nil
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];
                     }
                    
                     
                
                 }
                 break;
             }
               
             case SSDKResponseStateCancel: {
//                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消分享"
//                                                                 message:nil
//                                                                delegate:self
//                                                       cancelButtonTitle:@"OK"
//                                                       otherButtonTitles:nil, nil];
//                 [alert show];
                 break;

             }
                 
             default:
                 break;
         }
         
         // 回调处理....
     }];
    
    
     [shareView tappedCancel];
    NSLog(@"当前点击:%@",title);
}
#pragma -- share lib action
- (void)shareWithMode:(int)action fromSender:(UIView*)sender shareContent:(NSString*)someText
{
    
    //    ShareType actionType;
    //    switch (action) {
    //        case ShareTypeSinaWeibo:
    //        {
    //            actionType = ShareTypeSinaWeibo;
    //        }
    //            break;
    //        case ShareTypeTencentWeibo:
    //        {
    //            actionType = ShareTypeTencentWeibo;
    //        }
    //            break;
    //        case ShareTypeQQSpace:
    //        {
    //            actionType = ShareTypeQQSpace;
    //        }
    //            break;
    //        case ShareTypeQQ:
    //        {
    //            actionType = ShareTypeQQ;
    //        }
    //            break;
    //        case ShareTypeEvernote:
    //        {
    //            actionType = ShareTypeEvernote;
    //        }
    //            break;
    //        case ShareTypeWeixiSession:
    //        {
    //            actionType = ShareTypeWeixiSession;
    //        }
    //            break;
    //        case ShareTypeWeixiTimeline:
    //        {
    //            actionType = ShareTypeWeixiTimeline;
    //        }
    //            break;
    //        case ShareTypeSMS:
    //        {
    //            actionType = ShareTypeSMS;
    //        }
    //            break;
    //        case ShareTypeMail:
    //        {
    //            actionType = ShareTypeMail;
    //        }
    //            break;
    //        case ShareTypeCopy:
    //        {
    //            actionType = ShareTypeCopy;
    //        }
    //            break;
    //        case ShareTypeAirPrint:
    //        {
    //            actionType = ShareTypeAirPrint;
    //        }
    //            break;
    //        default:
    //            actionType = ShareTypeCopy;
    //            break;
    //    }
    
}


@end
