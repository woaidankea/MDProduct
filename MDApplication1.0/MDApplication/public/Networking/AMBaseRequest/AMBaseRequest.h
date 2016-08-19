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

#define kTransferKey @"&jk!@#$%^&td"
#define POST_VALUE(_VAL)  (_VAL)?(_VAL):@""
//static NSString * const BaseAddress =@"http://h.51tangdou.com/weizuan/";


//static NSString *const BaseAddress = @"http://60.173.8.147/tdapi/";
static NSString *const BaseAddress = @"http://tdapi.51tangdou.com/";

//else

//static NSString * const BaseAddress =@"http://api.aizhuanfa.net";

static NSString * const kqqBrowser = @"Goshare / share?";
static NSString * const kAppcol = @"Column/appcol"; //获取App Tab
static NSString * const kCheckforpwdcode = @"User/checkforpwdcode"; //检查验证码
static NSString * const kCheckdevicecode = @"User/devlogincode"; //二次登陆检查验证码
static NSString * const kArticle = @"Article/getart";    //获取文章信息
static NSString * const kColclass = @"Column/colclass";    //获取栏目分类
static NSString * const kForpwdcode = @"User/forpwdcode";  //忘记密码获取验证码
static NSString * const kLogin = @"User/ioslogin";      //iOS 登录
static NSString * const kCheckLogin = @"User/tioslogin";      //iOS 验证登录
static NSString * const kMydisciple = @"User/mydisciple";   //我的徒弟
static NSString * const kPageminfo = @"Column/pageminfo";   //我页面配置
static NSString * const kProfile = @"User/getprofile";   //个人资料
static NSString * const kProfilesaved = @"User/profilesaved";   //保存资料
static NSString * const kRegcode = @"User/regcode";      //获取注册验证码
static NSString * const kLogincode = @"User/logincode";      //获取登录验证码
static NSString * const kRegister = @"User/iosreg";   //注册
static NSString * const kResetpwd = @"User/usermpwd";   //修改密码
static NSString * const kRevrank = @"User/revrank";   //收入排行
static NSString * const kSecondChect = @"User/regcode";   //二次验证
static NSString * const kShareConfig = @"Share/shareconfigios";   //分享配置
static NSString * const kShareinfo = @"Share/shareinfo";   //分享信息
static NSString * const kStartAd = @"Ad/startad";   //启动App广告
static NSString * const kUserearning = @"User/userearnings"; //收入明细
static NSString * const kUsersign = @"User/usersign"; //用户签到
static NSString * const kUserforgotpwd = @"User/usrforgotpwd"; //找回密码
static NSString * const kConfirCode = @"User/confirmcode";
static NSString * const kTicketInfo = @"User/ticketinfo";   //工单信息
static NSString * const kSendTicket = @"User/subticket";   //发送工单
static NSString * const kIndexbal = @"User/indexbal";   //获取信息
static NSString * const kRegbonus = @"User/regbonus";   //注册奖励
static NSString * const kUsrdatum = @"User/usrdatum";   //完善资料奖励
static NSString * const kTokenSet = @"App/jgpush";    //绑定token
static NSString * const kUsrWithdraw = @"user/usrwithdraw"; //提现记录





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
-(void)setHeaderInfo:(NSDictionary *)headerInfo;


-(void)start;

-(onFailureCallback)failCallback;

@end
