//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDRevrankRequest.h"

@implementation TDRevrankRequest

- (id)initTDRevrankWithtype:(NSString *)type
                       date:(NSString *)date
                    success:(onSuccessCallback)successCallback
                    failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:POST_VALUE(type) forKey:@"type"];
        [dict setValue:POST_VALUE(date) forKey:@"date"];
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

    return kRevrank;
}

- (NSString*)getMethod{
    return @"GET";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
    }
}

@end
