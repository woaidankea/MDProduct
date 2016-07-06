//
//  MDLoginRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "OtherLoginRequest.h"
#import "AMSystemInfo.h"
#import "MDPublicConfig.h"
#import "MDDeviceInfo.h"
@implementation OtherLoginRequest
- (id)initWithTelephone:(NSString *)telephone password:(NSString *)password  code:(NSString *)code success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:POST_VALUE(telephone) forKey:@"username"];
            [dict setObject:POST_VALUE(password) forKey:@"password"];
            [dict setObject:POST_VALUE(code) forKey:@"code"];
        [self setActionInfo:dict];
        
        NSMutableDictionary *headerDict = [[NSMutableDictionary alloc]init];
        [headerDict setObject:[MDDeviceInfo systemInfoData] forKey:@"hwinfos"];
        [self setHeaderInfo:headerDict];
        
    }
    return self;
}

- (NSString *)getMethod{

        return @"POST";
}
- (NSString *)getURL{
       return kCheckLogin;
}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [[responseDictionary objectForKey:@"data"]objectForKey:@"member"];
        ////                [AMLoginModel setupObjectClassInArray:^NSDictionary *{
    
    }
}

@end