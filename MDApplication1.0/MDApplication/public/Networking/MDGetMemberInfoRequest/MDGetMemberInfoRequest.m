//
//  MDGetMemberInfoRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDGetMemberInfoRequest.h"
#import "MDUserInfoModel.h"
#import "MDPublicConfig.h"
@implementation MDGetMemberInfoRequest


- (id)initWithToken:(NSString *)token success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (ServerJieKu) {
                [dict setObject:@"my" forKey:@"m"];
                [dict setObject:@"getmain" forKey:@"a"];
        }
        [dict setObject:token forKey:@"token"];
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
    
    return @"/api/member/getMemberInfo";
}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        NSDictionary *dic = [[responseDictionary objectForKey:@"data"] objectForKey:@"member"];
        self.responseObject = [MDUserInfoModel mj_objectWithKeyValues:dic];
    
    }
}


@end
