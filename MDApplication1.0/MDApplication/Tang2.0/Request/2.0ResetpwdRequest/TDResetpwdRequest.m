//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDResetpwdRequest.h"

@implementation TDResetpwdRequest

- (id)initRegisterWitholdpass:(NSString *)oldpwd
                      newpass:(NSString *)newpass
                      success:(onSuccessCallback)successCallback
                      failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:POST_VALUE(oldpwd) forKey:@"oldpass"];
        [dict setValue:POST_VALUE(newpass) forKey:@"newpass"];
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

    return kResetpwd;
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
