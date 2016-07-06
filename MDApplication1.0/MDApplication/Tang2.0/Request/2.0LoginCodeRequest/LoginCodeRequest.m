//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "LoginCodeRequest.h"

@implementation LoginCodeRequest

- (id)initRegCodeWithPhone:(NSString *)phone
                      success:(onSuccessCallback)successCallback
                      failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:POST_VALUE(phone) forKey:@"phone"];
        
            
       
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

    return kLogincode;
}

- (NSString*)getMethod{
    return @"GET";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if(self.response.statusCode == 1009|| [self.response isSucceed]){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
    }
}

@end