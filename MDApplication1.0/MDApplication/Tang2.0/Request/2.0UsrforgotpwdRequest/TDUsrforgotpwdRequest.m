//
//  MDPupilRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDUsrforgotpwdRequest.h"
#import "MDPublicConfig.h"
@implementation TDUsrforgotpwdRequest

- (id)initWithphone:(NSString *)phone
          phonecode:(NSString *)phonecode
            newpass:(NSString *)newpass
            success:(onSuccessCallback)successCallback
            failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:POST_VALUE(phone) forKey:@"phone"];
        [dict setObject:POST_VALUE(phonecode) forKey:@"phonecode"];
        [dict setObject:POST_VALUE(newpass) forKey:@"newpass"];
        [self setActionInfo:dict];
    }
    return self;
    
    
}

- (NSString *)getMethod{
    return @"GET";
}

- (NSString *)getURL{
    return kUserforgotpwd;

}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        //        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
        self.responseObject = [responseDictionary objectForKey:@"data"];
        
    }
}

@end
