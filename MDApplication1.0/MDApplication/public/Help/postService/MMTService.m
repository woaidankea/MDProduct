//
//  MMTService.m
//  Medicalmmt
//
//  Created by gulei on 16/2/23.
//  Copyright © 2016年 gulei. All rights reserved.
//

#import "MMTService.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFNetworking.h"
#import "ServiceConstant.h"
#import "NSString+MD5.h"
#import "UtilsMacro.h"
#define POST_VALUE(_VAL)  (_VAL)?(_VAL):@""

@implementation MMTService

#pragma mark - Life.Cycle

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (id)shareInstance
{
    static MMTService *man = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        man = [[MMTService alloc]init];
    });
    
    return man;
}

- (void)reset
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

-(NSString *)generateSignatureParams:(NSDictionary *)paramDic
{
    NSArray *keysArray = [paramDic allKeys];
    NSMutableArray *paramArray = [[NSMutableArray alloc]init];
    
    for (NSString *key in keysArray) {
        [paramArray addObject:[NSString stringWithFormat:@"%@=%@",key,paramDic[key]]];
    }
    NSArray *resultArray = [paramArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    
    NSMutableString *param = [[NSMutableString alloc]init];
    
    for (int i = 0 ; i<resultArray.count; i++) {
        
        [param appendString:resultArray[i]];
        if (i<resultArray.count-1) {
            
            [param appendString:@"&"];
        }
    }
    
    [param appendString:kTransferKey];
    NSString *signature   = [param MD5Hash];
    
    return signature;
}

- (NSString *)getCurrentTimeString{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",a];//转为字符型
    NSString *tenTime = [timeString substringWithRange:NSMakeRange(0,10)];
    return tenTime;
}


-(void)postProfileWithsex:(NSString *)sex
                 birthday:(NSString *)birthday
                education:(NSString *)education
                 vocation:(NSString *)vocation
                   income:(NSString *)income
                   images:(NSArray *)images
                  Success:(Success)success
                  failure:(Failure)failure
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setValue:POST_VALUE(sex) forKey:@"sex"];
    [postDataDic setValue:POST_VALUE(birthday) forKey:@"birthday"];
    [postDataDic setValue:POST_VALUE(education) forKey:@"education"];
    [postDataDic setValue:POST_VALUE(vocation) forKey:@"vocation"];
    [postDataDic setValue:POST_VALUE(income) forKey:@"income"];
    [postDataDic setValue:[self getCurrentTimeString] forKey:@"time"];
    NSString *signatureParam = [self generateSignatureParams:postDataDic];
    [postDataDic setValue:signatureParam forKey:@"sign"];
    
    [postDataDic setValue: POST_VALUE(USER_DEFAULT_KEY(@"token")) forKey:@"token"];
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",kServerUrl,kUpdataProfile];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:postUrl parameters:postDataDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(int i = 0 ; i < images.count ; i++){
            [formData appendPartWithFileData:[images objectAtIndex:i] name:@"avatar" fileName:[NSString stringWithFormat:@"%d.jpeg",i] mimeType:@"image/jpeg"];
        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *resultDict;
        if (responseObject) {
            resultDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
            if (resultDict) {
                success(resultDict);
            }
        }
        NSLog(@"%@",resultDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
    

    
    
}

-(NSDictionary *)syncgetAppCol{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setValue:[self getCurrentTimeString] forKey:@"time"];
    NSString *signatureParam = [self generateSignatureParams:postDataDic];
    
    NSString *getUrl = [NSString stringWithFormat:@"%@%@?sign=%@&token=%@&time=%@",kServerUrl,kappTab,signatureParam,POST_VALUE(USER_DEFAULT_KEY(@"token")),[postDataDic objectForKey:@"time"]];
    
    
    NSURL *url = [NSURL URLWithString:getUrl];
    
    
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    
    
    
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *resultDict;
    resultDict = [NSJSONSerialization JSONObjectWithData:received
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    return resultDict;
    
    
    
}
- (NSDictionary *)syncgetArticleClassWith:(NSString *)mouduleId{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setValue:POST_VALUE(mouduleId) forKey:@"moduleid"];
    [postDataDic setValue:[self getCurrentTimeString] forKey:@"time"];
    NSString *signatureParam = [self generateSignatureParams:postDataDic];
    
    NSString *getUrl = [NSString stringWithFormat:@"%@%@?sign=%@&token=%@&time=%@&moduleid=%@",kServerUrl,kArticleClass,signatureParam,POST_VALUE(USER_DEFAULT_KEY(@"token")),[postDataDic objectForKey:@"time"],[postDataDic objectForKey:@"moduleid"]];
    
    
    NSURL *url = [NSURL URLWithString:getUrl];
    
    
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    
    
    
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *resultDict;
    resultDict = [NSJSONSerialization JSONObjectWithData:received
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    return resultDict;
    

}

- (NSDictionary *)syncgetMyPageinfoWith:(NSString *)mouduleId{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setValue:POST_VALUE(mouduleId) forKey:@"moduleid"];
    [postDataDic setValue:[self getCurrentTimeString] forKey:@"time"];
    NSString *signatureParam = [self generateSignatureParams:postDataDic];
    
    NSString *getUrl = [NSString stringWithFormat:@"%@%@?sign=%@&token=%@&time=%@&moduleid=%@",kServerUrl,kMyPageInfo,signatureParam,POST_VALUE(USER_DEFAULT_KEY(@"token")),[postDataDic objectForKey:@"time"],[postDataDic objectForKey:@"moduleid"]];
    
    
    NSURL *url = [NSURL URLWithString:getUrl];
    
    
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    
    
    
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *resultDict;
    resultDict = [NSJSONSerialization JSONObjectWithData:received
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    return resultDict;
}

-(void)postTicketWithcontent:(NSString *)content
                      images:(NSArray *)images
                     Success:(Success)success
                     failure:(Failure)failure{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setValue:POST_VALUE(content) forKey:@"content"];

    [postDataDic setValue:[self getCurrentTimeString] forKey:@"time"];
    NSString *signatureParam = [self generateSignatureParams:postDataDic];
    [postDataDic setValue:signatureParam forKey:@"sign"];
    
    [postDataDic setValue: POST_VALUE(USER_DEFAULT_KEY(@"token")) forKey:@"token"];
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",kServerUrl,kSendTicket];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:postUrl parameters:postDataDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(int i = 0 ; i < images.count ; i++){
            [formData appendPartWithFileData:[images objectAtIndex:i] name:@"ticimg" fileName:[NSString stringWithFormat:@"%d.jpeg",i] mimeType:@"image/jpeg"];
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *resultDict;
        if (responseObject) {
            resultDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
            if (resultDict) {
                success(resultDict);
            }
        }
        NSLog(@"%@",resultDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
    
    
    
}


- (NSDictionary *)syncgetStartAd{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
 
    [postDataDic setValue:[self getCurrentTimeString] forKey:@"time"];
    NSString *signatureParam = [self generateSignatureParams:postDataDic];
    
    NSString *getUrl = [NSString stringWithFormat:@"%@%@?sign=%@&token=%@&time=%@&moduleid=%@",kServerUrl,kStartAd,signatureParam,POST_VALUE(USER_DEFAULT_KEY(@"token")),[postDataDic objectForKey:@"time"],[postDataDic objectForKey:@"moduleid"]];
    
    
    NSURL *url = [NSURL URLWithString:getUrl];
    
    
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    
    
    
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *resultDict;
    resultDict = [NSJSONSerialization JSONObjectWithData:received
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    return resultDict;
    
    
}

@end
