//
//  MDMoneyDetailRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMoneyDetailRequest.h"

@implementation MDMoneyDetailRequest
- (id)initWithPage:(NSInteger)page success:(onSuccessCallback)successCallback failure:(onFailureCallback)failureCallback{
    
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
        [dict setObject:@"income" forKey:@"m"];
        [dict setObject:@"income" forKey:@"a"];
        [self setActionInfo:dict];
    }
    return self;
    
}
- (NSString *)getMethod{
    return @"GET";
}
- (NSString *)getURL{
    return @"";
//    return @"/api/journal/getMemberIncome";
}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
//        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
        self.responseObject = [responseDictionary objectForKey:@"data"];
        
    }
}


@end
