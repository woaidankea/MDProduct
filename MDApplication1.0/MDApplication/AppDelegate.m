//
//  AppDelegate.m
//  MDApplication
//
//  Created by jieku on 16/3/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MDPublicConfig.h"
#import "ScreenGuideViewController.h"
#import "MDLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "MMTService.h"
#import "AdModel.h"
#import "KSGuideManager.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
#import "YXApi.h"
#import "KeyBoardManager.h"
#import "MobClick.h"
//for mac
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//for idfa
#import <AdSupport/AdSupport.h>


#import "JPUSHService.h"
#import "TangConfig.h"
#import "AdLaunchView.h"
#import "ViewControllerFactory.h"
#import "ShareConfig.h"
#import "FCFileManager.h"
@interface AppDelegate () <UISplitViewControllerDelegate>


{
       UINavigationController *mainContrl;
        MainViewController *mainview;
}

@property(nonatomic, strong) AdLaunchView *adLaunchView;
@property(nonatomic,strong)AdModel *model;
@end


@implementation AppDelegate
- (void)ad{
    NSDictionary *adresult =[[MMTService shareInstance]syncgetStartAd];
    if(adresult){
    NSArray *array = [AdModel mj_objectArrayWithKeyValuesArray:[[adresult objectForKey:@"data"] objectForKey:@"list"]];
        
        if(array.count>0){
            _model = [array objectAtIndex:0];
        }
        self.adLaunchView = [[AdLaunchView alloc] initWithFrame: [UIScreen mainScreen].bounds type: AdLaunchProgressType andUrl:_model.adurl];
//         self.adLaunchView.imageURL = _model.adurl;
        self.adLaunchView._delegate = self;
       
        [self.window addSubview: self.adLaunchView];
//    [[KSGuideManager shared] showGuideViewWithImages:array withtype:YES];
    
    }else{
         [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
    }
    


}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //初始化友盟
    
 
    
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"04da0907bb2d4c9b42d24ed4"
                          channel:@"publish"
                 apsForProduction:FALSE
            advertisingIdentifier:advertisingId];

    
    [self setUM];
    //初始化shareSDK
    [self setShareSDK];

    
    
//    [self EnterMainViewController:AM_NORMAL_ENTER];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    [self getColConfig];
    [self getShareConfig];

    [self.window makeKeyAndVisible];
     [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
    [self ad];
    
    
    return YES;
}

- (void)getShareConfig{
    [ShareConfig shareToolsInstance];
}
- (void)getColConfig{

//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *result = [[MMTService shareInstance]syncgetAppCol];
        [TangConfig shareInstance].colDic = result;
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&parseError];
        [self saveCache: jsonData];

        
    });
    
}


- (void)setUM{
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
    [MobClick startWithAppkey:@"570602b9e0f55a1a5e000429" reportPolicy:BATCH   channelId:@""];
    //友盟渠道统计
    NSString * appKey = @"570602b9e0f55a1a5e000429";
    NSString * deviceName = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * mac = [self macString];
    NSString * idfa = [self idfaString];
    NSString * idfv = [self idfvString];
    NSString * urlString = [NSString stringWithFormat:@"http://log.umtrack.com/ping/%@/?devicename=%@&mac=%@&idfa=%@&idfv=%@", appKey, deviceName, mac, idfa, idfv];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:urlString]] delegate:nil];
}

- (void)setShareSDK{
    
    [ShareSDK registerApp:@"10dc9fb7d6228"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeYiXin)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
             break;
             case SSDKPlatformTypeQQ:
             [ShareSDKConnector connectQQ:[QQApiInterface class]
                        tencentOAuthClass:[TencentOAuth class]];
             break;
             case SSDKPlatformTypeSinaWeibo:
             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
             break;
             case SSDKPlatformTypeYiXin:
                 [ShareSDKConnector connectYiXin:[YXApi class]];
                 break;
             default:
             break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
             //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
             [appInfo SSDKSetupSinaWeiboByAppKey:@"2556554397"
                                       appSecret:@"a21d84f1e137b721d68f4ba1b5532a52"
                                     redirectUri:@"http://www.jieku.com"
                                        authType:SSDKAuthTypeBoth];
             break;
             case SSDKPlatformTypeWechat:
             [appInfo SSDKSetupWeChatByAppId:@"wxebfb4fdedd1bccb2"
                                   appSecret:@"62e0b2e4954bbd403c54a1368228a4c4"];
             break;
             case SSDKPlatformTypeQQ:
             [appInfo SSDKSetupQQByAppId:@"1105281064"
                                  appKey:@"vGIFeWxaqTzbhe8w"
                                authType:SSDKAuthTypeBoth];
             break;
             case SSDKPlatformTypeYiXin:
             [appInfo SSDKSetupYiXinByAppId:@"yx31bc441496b444afbe86e3c4bbb7a1c5" appSecret:@"976a8bdf6920773" redirectUri:@"https://open.yixin.im/resource/oauth2_callback.html" authType:SSDKAuthTypeBoth];
                 break;
             default:
             break;
         }
     }];


}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  
        NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
  
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


#pragma mark --切换页面


-(UINavigationController *)rootController{
    return mainContrl;
}

-(void)EnterMainViewController :(AMEnterMainViewControllerType)enterType{
    
    if(!mainview){
    MainViewController *mainVc=[[MainViewController alloc]init];
    mainVc.enterType =enterType;
    mainContrl=[[UINavigationController alloc]initWithRootViewController:mainVc];
    mainview = mainVc;
    [self.window setRootViewController:mainContrl];
    }else{
        mainContrl=[[UINavigationController alloc]initWithRootViewController:mainview];
        
        [self.window setRootViewController:mainContrl];

    }

}


-(void)EnterScreenGuideViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ScreenGuideViewController" bundle:nil];
    ScreenGuideViewController *openVC = [storyboard instantiateViewControllerWithIdentifier:@"ScreenGuideViewController"];
    
    
    [self.window addSubview:openVC.view];
//    [self.window setRootViewController:openVC];

}


#pragma mark - 用户退出 -
-(void)exitAppToLandViewController{

    
    [[NSNotificationCenter defaultCenter] postNotificationName:AMUserLogoutNotification object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    

    [USER_DEFAULT removeObjectForKey:@"token"];
    [USER_DEFAULT removeObjectForKey:@"memberId"];
    [NSUSERDEFAULIT synchronize];
    [self showLoginViewoController];
}

#pragma mark - 跳转至登录界面 -
- (void)showLoginViewoController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MDLoginViewController" bundle:nil];
    MDLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"MDLoginViewController"];
   
    mainContrl =  [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.window setRootViewController:mainContrl];
}


//友盟渠道统计


- (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

- (NSString *)idfaString {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    
                    [USERDEFAULTS setObject:[asIM.advertisingIdentifier UUIDString] forKey:@"idfa"];
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    [USERDEFAULTS setObject:[asIM.advertisingIdentifier UUIDString] forKey:@"idfa"];
                    return [asIM.advertisingIdentifier UUIDString];
                    
                    
                }
            }
        }
    }
}

- (void) adLaunch:(AdLaunchView *)launchView {
    
    if([_model.isclick isEqualToString:@"1"]){
        BaseViewController *vc = [ViewControllerFactory TabMenuFactoryCreateViewControllerWithType:kWebViewController];
        
        [vc setleftBarItemWith:nil];
        vc.url = _model.clickurl;
      
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
    }
}


- (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}


#pragma mark - 缓存数据 -
#define MaintainFile @"maintain"
#define fileName @"maintain.txt"
- (void)saveCache:(NSData *)dict
{
    [FCFileManager removeItemAtPath:[NSString stringWithFormat:@"/%@/%@",MaintainFile,_model]];
    NSError *error = nil;
    [FCFileManager createFileAtPath:[NSString stringWithFormat:@"/%@/%@",MaintainFile,_model] withContent:dict error:&error];
}

- (NSDictionary *)readCache
{
    NSData *fileData = [FCFileManager readFileAtPathAsData:[NSString stringWithFormat:@"/%@/%@",MaintainFile,_model]];
    NSError *err;
    NSDictionary *dict ;
    
    
    
    if(fileData){
        dict = [NSJSONSerialization JSONObjectWithData:fileData
                
                                               options:NSJSONReadingMutableContainers
                
                                                 error:&err];
        
    }
    return dict;
}

- (void)removeCache
{
    [FCFileManager removeItemAtPath:[NSString stringWithFormat:@"/%@/%@",MaintainFile,_model]];
}


@end
