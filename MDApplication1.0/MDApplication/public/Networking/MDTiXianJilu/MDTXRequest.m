//
//  MDTXRequest.m
//  MDApplication
//
//  Created by jieku on 16/4/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDTXRequest.h"

@implementation MDTXRequest
- (id)initWithPage:(NSInteger)page
           success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
           //提现记录
            [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
            [dict setObject:@"cash" forKey:@"m"];
            [dict setObject:@"cashlist" forKey:@"a"];
            [self setActionInfo:dict];
    }
    return self;
    
    
}

- (NSString *)getMethod{
    return @"GET";
}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        //        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
        self.responseObject = [responseDictionary objectForKey:@"data"];
        
    }
}

@end
