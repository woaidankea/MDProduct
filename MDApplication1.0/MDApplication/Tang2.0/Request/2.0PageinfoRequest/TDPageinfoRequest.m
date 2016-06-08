//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDPageinfoRequest.h"

@implementation TDPageinfoRequest

- (id)initWithMouduleId:(NSString *)mouduleId
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:mouduleId forKey:@"moduleid"];
            
       
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

        return kPageminfo;
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
