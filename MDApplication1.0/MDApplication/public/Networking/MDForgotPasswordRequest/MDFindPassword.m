//
//  MDFindPassword.m
//  MDApplication
//
//  Created by jieku on 16/3/28.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDFindPassword.h"
#import "MDPublicConfig.h"
@implementation MDFindPassword
- (id)initWithTelephone:(NSString *)telephone
             VerifyCode:(NSString *)verifycode
               PassWord:(NSString *)password
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
            [dict setObject:@"user" forKey:@"m"];
            [dict setObject:@"findpass" forKey:@"a"];
            [dict setObject:telephone forKey:@"phone"];
            [dict setObject:verifycode forKey:@"phonecode"];
            [dict setObject:password forKey:@"newpass"];
        }else{
        [dict setObject:telephone forKey:@"telephone"];
        [dict setObject:verifycode forKey:@"verifyCode"];
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

    return @"/api/member/findPassword";
}


- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        
        
    }
}

@end
