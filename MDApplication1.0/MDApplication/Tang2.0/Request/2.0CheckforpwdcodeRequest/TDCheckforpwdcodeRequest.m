//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDCheckforpwdcodeRequest.h"

@implementation TDCheckforpwdcodeRequest

- (id)initSecondCheckWithphone:(NSString *)phone
                       imgcode:(NSString *)imgcode
                       success:(onSuccessCallback)successCallback
                       failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:POST_VALUE(phone) forKey:@"phone"];
        [dict setValue:POST_VALUE(imgcode) forKey:@"imgcode"];
        [self setActionInfo:dict];
    }
    return self;
}- (NSString *)getURL{

    return kCheckforpwdcode;
}

- (NSString*)getMethod{
    return @"GET";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed] ||
       self.response.statusCode == 1009||
       self.response.statusCode == 1010){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
    }
}

@end
