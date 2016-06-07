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
   
    NSString *signatureParam = [self generateSignatureParams:postDataDic];
    [postDataDic setValue:signatureParam forKey:@"sign"];
    
    [postDataDic setValue:POST_VALUE(USER_DEFAULT_KEY(@"token")) forKey:@"token"];
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",kServerUrl,kUpdataProfile];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:postUrl parameters:postDataDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(int i = 0 ; i < images.count ; i++){
            [formData appendPartWithFileData:[images objectAtIndex:i] name:[NSString stringWithFormat:@"photo_%d",i] fileName:[NSString stringWithFormat:@"%d.jpeg",i] mimeType:@"image/jpeg"];
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
    
    
//    [manager POST:postUrl parameters:postDataDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        
//        
//        
//        for(int i = 0 ; i < images.count ; i++){
//            [formData appendPartWithFileData:[images objectAtIndex:i] name:[NSString stringWithFormat:@"photo_%d",i] fileName:[NSString stringWithFormat:@"%d.jpeg",i] mimeType:@"image/jpeg"];
//        }
//        
//        
//        
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *resultDict;
//        if (responseObject) {
//            resultDict = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                         options:NSJSONReadingMutableContainers
//                                                           error:nil];
//            if (resultDict) {
//                success(resultDict);
//            }
//        }
//        NSLog(@"%@",resultDict);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//    }];
    
    
}



@end
