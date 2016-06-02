//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDRegisterRequest.h"

@implementation TDRegisterRequest

- (id)initRegisterWithPhone:(NSString *)phone
                   password:(NSString *)password
                       code:(NSString *)code
                    inviter:(NSString *)inviter
                     device:(NSString *)device
                    success:(onSuccessCallback)successCallback
                    failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:POST_VALUE(phone) forKey:@"phone"];
        [dict setValue:POST_VALUE(password) forKey:@"password"];
        [dict setValue:POST_VALUE(code) forKey:@"code"];
        [dict setValue:POST_VALUE(inviter) forKey:@"inviter"];
        [dict setValue:POST_VALUE(device) forKey:@"device"];
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

    return kRegister;
}

- (NSString*)getMethod{
    return @"GET";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
    }
}

@end
