//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDSubticketRequest.h"

@implementation TDSubticketRequest

- (id)initSubticketWithticimg:(NSData *)img
                      content:(NSString *)content
                      success:(onSuccessCallback)successCallback
                      failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"img" forKey:@"img"];
        [dict setObject:POST_VALUE(content) forKey:@"content"];
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

    return kStartAd;
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
