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

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
#import "KeyBoardManager.h"
#import "MobClick.h"
//for mac
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//for idfa
#import <AdSupport/AdSupport.h>
@interface AppDelegate () <UISplitViewControllerDelegate>


{
       UINavigationController *mainContrl;
}

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //初始化友盟
    [self setUM];
    //初始化shareSDK
    [self setShareSDK];
    [self EnterMainViewController:AM_NORMAL_ENTER];

    [self.window makeKeyAndVisible];
    
    return YES;
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
                            @(SSDKPlatformTypeQQ)]
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
             default:
             break;
         }
     }];


}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --切换页面


-(UINavigationController *)rootController{
    return mainContrl;
}

-(void)EnterMainViewController :(AMEnterMainViewControllerType)enterType{
    MainViewController *mainVc=[[MainViewController alloc]init];
    mainVc.enterType =enterType;
    mainContrl=[[UINavigationController alloc]initWithRootViewController:mainVc];
    [self.window setRootViewController:mainContrl];

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
//    [NSUSERDEFAULIT setBool:NO forKey:AM_IS_LAND];
//    [NSUSERDEFAULIT synchronize];
//    [NSUSERDEFAULIT setObject:[NSNumber numberWithInteger:0] forKey:AM_USER_ACCOUNTID];
//    [NSUSERDEFAULIT setObject:@"" forKey:AM_USER_IM_TOKEN];
//    
//    [[IMChatMessageManager shareInstance] amLogout];
//    
//    [[AMDataManager shareInstance] closeSqlite];
//    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
//    
//
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
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

- (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}

@end
