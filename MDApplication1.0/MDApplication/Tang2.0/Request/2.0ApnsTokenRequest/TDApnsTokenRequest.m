//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDApnsTokenRequest.h"

@implementation TDApnsTokenRequest

- (id)initSecondCheckWithuid:(NSString *)uid
                       token:(NSString *)token
                     success:(onSuccessCallback)successCallback
                     failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:POST_VALUE(uid) forKey:@"memberid"];
        [dict setValue:POST_VALUE(token) forKey:@"strcode"];
        [dict setValue:POST_VALUE(@"1") forKey:@"device"];
        [self setActionInfo:dict];
    }
    return self;
}- (NSString *)getURL{

    return kTokenSet;
}

- (NSString*)getMethod{
    return @"POST";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
    }
}

@end
