//
//  MDMotifyUserInfoRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/30.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMotifyUserInfoRequest.h"
#import "MDPublicConfig.h"
#import "UtilsMacro.h"
@implementation MDMotifyUserInfoRequest
- (id)initWithModel:(NSDictionary *)params success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback{
    
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
        
        [dict setValue: USER_DEFAULT_KEY(@"token") forKey:@"token"];
        [dict setValue: @"my" forKey:@"m"];
        [dict setValue: @"saveziliao" forKey:@"a"];
        }
        [dict setValuesForKeysWithDictionary:params];
        
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
    return @"/api/member/modifyMemberInfo";
}
@end
