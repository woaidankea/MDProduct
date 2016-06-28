//
//  MDPupilRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDTicketinfoRequest.h"
#import "MDPublicConfig.h"
@implementation TDTicketinfoRequest

- (id)initWithDate:(NSString *)date
           success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        NSString *currentPage = [NSString stringWithFormat:@"%ld",page];
        [dict setObject:POST_VALUE(date) forKey:@"tictime"];
        [self setActionInfo:dict];
    }
    return self;
    
    
}

- (NSString *)getMethod{
    return @"GET";
}

- (NSString *)getURL{
    return kTicketInfo;

}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        //        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
        self.responseObject = [responseDictionary objectForKey:@"data"];
        
    }
}

@end
