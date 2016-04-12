//
//  MDForgotPasswordRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/28.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDForgotPasswordRequest.h"
#import "MDPublicConfig.h"
@implementation MDForgotPasswordRequest
- (id)initWithTelephone:(NSString *)telephone
                      m:(NSString *)m
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
            [dict setObject:telephone forKey:@"phone"];
            [dict setObject:m forKey:@"m"];
            [dict setObject:@"sendcode" forKey:@"a"];
        }else{
        [dict setObject:telephone forKey:@"telephone"];
        [dict setObject:@"1" forKey:@"type"];
        [dict setObject:@"1" forKey:@"platform"];
        }
        [self setActionInfo:dict];
    }
    return self;

}
- (NSString *)getMethod{
    
    return @"GET";
    
}
- (NSString *)getURL{
    
    if(ServerJieKu){
        return @"";
    }
    
    return @"/api/member/getVerifyCode";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
          self.responseObject = [responseDictionary objectForKey:@"data"];
        
    }
}

@end
