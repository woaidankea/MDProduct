//
//  MDRegistRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/31.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDRegistRequest.h"
#import "MDPublicConfig.h"
@implementation MDRegistRequest
- (id)initWithParams:(NSDictionary *)params success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
            [dict setObject:[params objectForKey:@"telephone"] forKey:@"phone"];
            [dict setObject:[params objectForKey:@"verifyCode"] forKey:@"phonecode"];
            [dict setObject:[params objectForKey:@"password"] forKey:@"pass"];
            [dict setObject:[params objectForKey:@"teacher"] forKey:@"inviter"];
            [dict setObject:@"reg" forKey:@"m"];
            [dict setObject:@"savereg" forKey:@"a"];
            
        }else{
        [dict setObject:[params objectForKey:@"telephone"] forKey:@"telephone"];
        [dict setObject:[params objectForKey:@"verifyCode"] forKey:@"verifyCode"];
        [dict setObject:[params objectForKey:@"password"] forKey:@"password"];
        [dict setObject:[params objectForKey:@"teacher"] forKey:@"teacher"];
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
    return @"/api/member/registerMember";
}


- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [[responseDictionary objectForKey:@"data"]objectForKey:@"member"];
        
        
        
    }
}

@end
