//
//  MDModifyPassword.m
//  MDApplication
//
//  Created by jieku on 16/3/31.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDModifyPassword.h"
#import "MDPublicConfig.h"
#import "UtilsMacro.h"
@implementation MDModifyPassword
- (id)initWithOldPassword:(NSString *)oldpassword Newpassword:(NSString *)newpassword success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
        
            [dict setObject:@"user" forKey:@"m"];
            [dict setObject:@"editpass" forKey:@"a"];
            [dict setObject:oldpassword forKey:@"oldpass"];
            [dict setObject:newpassword forKey:@"newpass"];
            [dict setObject:USER_DEFAULT_KEY(@"token") forKey:@"token"];
        }
        
        [dict setObject:oldpassword forKey:@"oldPassword"];
        [dict setObject:newpassword forKey:@"newPassword"];
    
        
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
    return @"/api/member/modifyPassword";
}


- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        
        
    }
}

@end
