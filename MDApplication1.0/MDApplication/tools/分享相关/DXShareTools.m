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

#import "WeiboActivity.h"
#import "WechatSessionActivity.h"
#import "WechatTimelineActivity.h"
#import "CopyLinkActivity.h"
#import "TencentActivity.h"
#import "QZoneActivity.h"
#import "ShareConfig.h"
#import "ShareConfigModel.h"
#import "YXActivity.h"
#import "YXTimeLineActivity.h"



@implementation PicCache

+(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

+(NSData *) getDataFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    return data;
}

+(UIImage *) loadImage:(NSString *)fileName
{
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@", fileName]];
    
    return result;
}

+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension
{
    NSString *filePath = imageName;
    if ([[extension lowercaseString] isEqualToString:@"png"])
    {
        BOOL isOK = [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        NSLog([NSString stringWithFormat:@"%d",isOK]);
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"])
    {
        BOOL isOK = [UIImageJPEGRepresentation(image, 0.7) writeToFile:filePath atomically:YES];
        NSLog([NSString stringWithFormat:@"%d",isOK]);
    }
    else
    {
        NSLog(@"文件后缀不认识");
    }
}

@end


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
-(void)showShareView:(NSArray *)shareAry contentModel:(ShareModel *) model viewController:(UIViewController *)vc{
       CurrentModel = model;
//    @"shareToWeChatTimeline",
//    @"shareToWechatSession",
//    @[
//      @"shareToWeibo",
//      @"shareToTencentQQ",
//      @"shareToQzone"
//      ];

//    [WeiboActivity class],
//    [TencentActivity class],
//    [QZoneActivity class]
    NSMutableArray *selectors = [NSMutableArray new];
    
    NSMutableArray *classes =  [NSMutableArray new];
    for(ShareConfigModel *model in [ShareConfig shareToolsInstance].configArray){
        if([model.show isEqualToString:@"1"]){
            if([model.config isEqualToString:@"2"]){
                if([model.platform isEqualToString:@"1"]){
                    [selectors addObject:@"shareToTencentQQ"];
                    [classes addObject:[TencentActivity class]];
                }
                if([model.platform isEqualToString:@"2"]){
                     [selectors addObject:@"shareToQzone"];
                    [classes addObject:[QZoneActivity class]];

                }
                if([model.platform isEqualToString:@"3"]){
                    [selectors addObject:@"shareToYixin"];
                    [classes addObject:[YXActivity class]];
                }
                if([model.platform isEqualToString:@"4"]){
                    [selectors addObject:@"shareToYixinTimeline"];
                    [classes addObject:[YXTimeLineActivity class]];
                }
                if([model.platform isEqualToString:@"5"]){
                    [selectors addObject:@"shareToWeibo"];
                    [classes addObject:[WeiboActivity class]];

                }

            }
        }
        
        
    
    
    
    
    }
    
    NSLog(@"222222222");
  
    NSMutableArray *activitys = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < selectors.count; i++) {
        id activity = [[classes[i] alloc] init];
        [activity setPerformActivityBlock:^{
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:NSSelectorFromString(selectors[i]) withObject:nil];
        }];
        [activitys addObject:activity];
    }
       NSLog(@"33333333333");
//    //添加Action
//    CopyLinkActivity *copyLinkActivity = [[CopyLinkActivity alloc] init];
//    [copyLinkActivity setPerformActivityBlock:^{
//        [self copyLink:@"http://helloseed.io"];
//    }];
//    [activitys addObject:copyLinkActivity];
    
   // /*
    NSMutableArray *activityItems = [NSMutableArray array];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachesDir = [paths objectAtIndex:0];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    
//    
    if(!_isApprentice&&!_isSign){

        NSString *textToShare = model.title;
        NSURL *urlToShare = [NSURL URLWithString:model.url];
        [activityItems addObject:urlToShare];
        [activityItems addObject:textToShare];
        [activityItems addObject:model.imageArray[0]];
    }else if(_isSign){
        [activityItems addObject:[CurrentModel.imageArray objectAtIndex:0]];

    }
    else {
    
     [activityItems addObject:[CurrentModel.imageArray objectAtIndex:1]];
    }
    
    
    
   NSLog(@"44444444444");
     
     UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
   
    activityVC.excludedActivityTypes =  @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                          UIActivityTypeAssignToContact,UIActivityTypeMessage, UIActivityTypePostToWeibo, UIActivityTypeSaveToCameraRoll,UIActivityTypePostToTwitter,UIActivityTypeMail,
                                          UIActivityTypePostToFlickr,UIActivityTypePostToFacebook,UIActivityTypeAddToReadingList,UIActivityTypePostToVimeo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
     activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
     [self alert:@"成功"];
     };
  //   */
//    NSArray *activityItems = @[];
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
    
    [vc presentViewController:activityVC animated:YES completion:nil];
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





  


//拷贝链接
- (void)copyLink:(NSString *)link {
    [self alert:@"拷贝成功"];
}

//分享到微博
- (void)shareToWeibo {
    [self alert:@"成功分享到微信朋友"];
    NSInteger type = 0;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    type =SSDKPlatformTypeSinaWeibo;
    
    if(!_isApprentice&&!_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:[self imageCompressForWidth:CurrentModel.imageArray[0] targetWidth:40] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
        
    }else if(_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
    }
    else {
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
        
    }
    [shareParams SSDKSetupWeChatParamsByText:nil title:CurrentModel.title url:nil thumbImage:nil image:[CurrentModel.imageArray objectAtIndex:0] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
    
//    SSDKPlatformSubTypeYiXinSession     = 38,
//    /**
//     *  易信朋友圈
//     */
//    SSDKPlatformSubTypeYiXinTimeline    = 39,

    
    
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
    
    
}

//分享到微信朋友
- (void)shareToWeChatTimeline {
    [self alert:@"成功分享到微信朋友"];
    NSInteger type = 0;
     NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    type =SSDKPlatformSubTypeWechatTimeline;
    
    [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                     images:CurrentModel.imageArray //传入要分享的图片
                                        url:[NSURL URLWithString:CurrentModel.url]
                                      title:CurrentModel.title
                                       type:SSDKContentTypeWebPage];
    
    
    if (_isApprentice && CurrentModel.imageArray.count == 2){
    
            [shareParams SSDKSetupWeChatParamsByText:nil title:CurrentModel.title url:nil thumbImage:nil image:[CurrentModel.imageArray objectAtIndex:1] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
     }

    
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

    
}

- (void)shareToQzone{
    NSInteger type = 0;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    type =SSDKPlatformSubTypeQZone;
    if(!_isApprentice&&!_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:[self imageCompressForWidth:CurrentModel.imageArray[0] targetWidth:40] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
        
    }else if(_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
    }
    else {
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
        
    }
    
    
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
    

}

- (void)shareToTencentQQ{
    NSInteger type = 0;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    type =SSDKPlatformSubTypeQQFriend;
   
    
    if(!_isApprentice&&!_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:[self imageCompressForWidth:CurrentModel.imageArray[0] targetWidth:40] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];


    }else if(_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];

    }
    else {
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];

      
    }
    

    
    
    
    
    
    
    
    
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
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
                       
                             RewardInfo *info = [[RewardInfo alloc] init];
                             info.money = [[request.responseObject objectForKey:@"sendusermoney"] floatValue];
                    
                             //
                             [[UIApplication sharedApplication].keyWindow initRedPacketWindow1:info];
                
                         }
                
                         
                     } failure:^(AMBaseRequest *request) {
                       
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
    

}
//分享到微信朋友圈
- (void)shareToWechatSession {
    [self alert:@"成功分享到微信朋友"];
    NSInteger type = 0;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    type =SSDKPlatformSubTypeWechatSession;
    
    [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                     images:CurrentModel.imageArray //传入要分享的图片
                                        url:[NSURL URLWithString:CurrentModel.url]
                                      title:CurrentModel.title
                                       type:SSDKContentTypeWebPage];
    [shareParams SSDKSetupWeChatParamsByText:nil title:CurrentModel.title url:nil thumbImage:nil image:[CurrentModel.imageArray objectAtIndex:0] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
    
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
    
    
}

//分享到易信
- (void)shareToYixin{
    NSInteger type = 0;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    type =SSDKPlatformTypeYiXin;
    
    
    if(!_isApprentice&&!_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:[self imageCompressForWidth:CurrentModel.imageArray[0] targetWidth:40] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
        
    }else if(_isSign){
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
    }
    else {
        [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                         images:CurrentModel.imageArray[0] //传入要分享的图片
                                            url:[NSURL URLWithString:CurrentModel.url]
                                          title:CurrentModel.title
                                           type:SSDKContentTypeAuto];
        
        
    }
    
    
    [shareParams SSDKSetupShareParamsByText:CurrentModel.desc
                                     images:@"http://60.173.8.147/td/Public/images/articleimg/2016-04-22/57198eac98908.jpg" //传入要分享的图片
                                        url:[NSURL URLWithString:CurrentModel.url]
                                      title:CurrentModel.title
                                       type:SSDKContentTypeAuto];

    
    
    
    
    
    
    
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
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
                             
                             RewardInfo *info = [[RewardInfo alloc] init];
                             info.money = [[request.responseObject objectForKey:@"sendusermoney"] floatValue];
                             
                             //
                             [[UIApplication sharedApplication].keyWindow initRedPacketWindow1:info];
                             
                         }
                         
                         
                     } failure:^(AMBaseRequest *request) {
                         
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
                     if(type == SSDKPlatformSubTypeYiXinSession || type == SSDKPlatformSubTypeYiXinTimeline){
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您没有安装易信客户端"
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
    
    
}

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//弹出框
- (void)alert:(NSString *)text {
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:text preferredStyle:(UIAlertControllerStyleAlert)];
//    [self presentViewController:alertVC animated:YES completion:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alertVC dismissViewControllerAnimated:YES completion:nil];
//    });
    NSLog(@"%@",text);
    
}


@end

