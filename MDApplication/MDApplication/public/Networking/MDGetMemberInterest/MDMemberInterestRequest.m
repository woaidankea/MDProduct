//
//  MDMemberInterestRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMemberInterestRequest.h"
#import "MDPublicConfig.h"
#import "UtilsMacro.h"
@implementation MDMemberInterestRequest

-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed{
    self=[super initWithSuccessCallback:success failureCallback:failed];
    if(self){
       
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (ServerJieKu) {
             [dict setValue: USER_DEFAULT_KEY(@"token") forKey:@"token"];
             [dict setValue: @"my" forKey:@"m"];
             [dict setValue: @"getziliao" forKey:@"a"];
        }
        [self setActionInfo:dict];
        
    }
    return self;
}
- (NSString *)getMethod{
    if (ServerJieKu) {
        return @"GET";
    }
    
    return @"POST";
}

- (NSString *)getURL{
    if (ServerJieKu) {
        return @"";
    }
    return @"/api/member/getMemberInterest";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        //        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
        self.responseObject = [[responseDictionary objectForKey:@"data"] objectForKey:@"member"];
        
    }
}
@end
