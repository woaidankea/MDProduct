//
//  AMBaseRequest.h
//  AMen
//
//  Created by 曾宏亮 on 15/10/30.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMBaseResponse.h"
#import "MJExtension.h"

static NSString *action_Id = @"actionId";

//static NSString * const BaseAddress =@"http://verifyapp.amenba.com/amen";

//if Jieku 服务器

#define kTransferKey @"jk!@#$%^&td"
#define POST_VALUE(_VAL)  (_VAL)?(_VAL):@""
static NSString * const BaseAddress =@"http://h.51tangdou.com/weizuan/";
//else

//static NSString * const BaseAddress =@"http://api.aizhuanfa.net";


static NSString * const kAppcol = @"Api/Column/appcol"; //获取App Tab
static NSString * const kCheckforpwdcode = @"Api/User/forpwdcode"; //检查验证码
static NSString * const kArticle = @"Api/Article/getart";    //获取文章信息
static NSString * const kColclass = @"Api/Column/colclass";    //获取栏目分类
static NSString * const kForpwdcode = @"Api/User/forpwdcode";  //忘记密码获取验证码
static NSString * const kLogin = @"Api/User/iosloginl";      //iOS 登录
static NSString * const kMydisciple = @"Api/User/mydisciple";   //我的徒弟
static NSString * const kPageminfo = @"Api/Column/pageminfo";   //我页面配置
static NSString * const kProfile = @"Api/User/getprofile";   //个人资料
static NSString * const kProfilesaved = @"Api/User/profilesaved";   //保存资料
static NSString * const kRegcode = @"Api/User/regcode";      //获取注册验证码
static NSString * const kRegister = @"Api/User/register";   //注册
static NSString * const kResetpwd = @"Api/User/usermpwd";   //修改密码
static NSString * const kRevrank = @"Api/User/revrank";   //收入排行
static NSString * const kSecondChect = @"Api/User/regcode";   //二次验证
static NSString * const kShareConfig = @"Api/Share/shareconfigios";   //分享配置
static NSString * const kShareinfo = @"Api/Share/shareinfo";   //分享信息
static NSString * const kStartAd = @"Api/Ad/startad";   //启动App广告
static NSString * const kUserearning = @"Api/User/userearnings"; //收入明细
static NSString * const kUsersign = @"Api/User/usersign"; //用户签到
static NSString * const kUserforgotpwd = @"Api/User/usrforgotpwd"; //找回密码







@interface AMBaseRequest : NSObject

@property (nonatomic, strong) AMBaseResponse *response;
@property (nonatomic, strong) id responseObject;

typedef void(^onSuccessCallback)(AMBaseRequest* request);
typedef void(^onFailureCallback)(AMBaseRequest* request);

-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed;

-(NSString*)getMethod;

-(NSString*)getURL;

-(void)processResponse:(NSDictionary *)responseDictionary;

-(void)setActionInfo:(NSDictionary *)actionInfo;

-(void)start;

-(onFailureCallback)failCallback;

@end
