//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "RegbonusRequest.h"

@implementation RegbonusRequest

- (id)initBonussuccess:(onSuccessCallback)successCallback
             failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
   
            
       
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

        return kRegbonus;
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
