//
//  MDShareSuccessRequest.m
//  MDApplication
//
//  Created by jieku on 16/4/11.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDShareSuccessRequest.h"

@implementation MDShareSuccessRequest
- (id)initWithAuthcode:(NSString *)authcode
              Platform:(NSString *)platform
               success:(onSuccessCallback)successCallback
               failure:(onFailureCallback)failureCallback{
    self = [super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
            
            [dict setObject:@"user" forKey:@"m"];
            [dict setObject:@"editpass" forKey:@"a"];
      
        
        
        [self setActionInfo:dict];
    }
    return self;

    
}

- (NSString *)getMethod {
    return @"GET";
}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        
        
    }
}


@end
