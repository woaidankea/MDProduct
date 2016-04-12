//
//  MDLoginRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDLoginRequest.h"
#import "AMSystemInfo.h"
#import "MDPublicConfig.h"
@implementation MDLoginRequest
- (id)initWithTelephone:(NSString *)telephone password:(NSString *)password success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
            [dict setObject:@"user" forKey:@"m"];
            [dict setObject:@"checklogin" forKey:@"a"];
            

            [dict setObject:telephone forKey:@"name"];
            [dict setObject:password forKey:@"pass"];

        
        }else{
        [dict setObject:telephone forKey:@"telephone"];
        [dict setObject:password forKey:@"password"];
        }
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getMethod{
    if(ServerJieKu){
        return @"GET";
    }

    return @"POST";
}
- (NSString *)getURL{
    if(ServerJieKu){
        return @"";
    }
    return @"/api/member/login";
}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [[responseDictionary objectForKey:@"data"]objectForKey:@"member"];
        ////                [AMLoginModel setupObjectClassInArray:^NSDictionary *{
        ////                    return @{@"friendList":@"AMUserInfoModel"};
        ////                }];
        ////                AMLoginModel *response=[AMLoginModel objectWithKeyValues:responseDictionary];
        //                self.response.data=response.data;
        
        
        
    }
}

@end
