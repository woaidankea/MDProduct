//
//  MDAddShareRequest.m
//  MDApplication
//
//  Created by jieku on 16/4/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDAddShareRequest.h"

@implementation MDAddShareRequest
- (id)initWithContentID:(NSString *)contentid Platform:(NSInteger)platform success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback
{
    self = [super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
       
        [dict setObject:contentid forKey:@"key"];
        [dict setObject:[NSNumber numberWithInteger:platform] forKey:@"plat"];
        [dict setObject:@"ios" forKey:@"device"];
        [dict setObject:@"profit" forKey:@"m"];
        [dict setObject:@"sharesuc" forKey:@"a"];
        
        
        
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
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
        
    }
}

@end
