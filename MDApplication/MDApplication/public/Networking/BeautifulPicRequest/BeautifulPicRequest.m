//
//  BeautifulPicRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BeautifulPicRequest.h"
#import "MDBeautifulPicModel.h"
#import "MDPublicConfig.h"
@implementation BeautifulPicRequest
- (id)initWithCurrentPage:(NSInteger)currentPage
                totalPage:(NSInteger)totalPage
                 pageType:(NSString *)pageType
                  success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"tu" forKey:@"m"];
        [dict setObject:@"tuinfo" forKey:@"a"];
        [dict setObject:[NSNumber numberWithInteger:currentPage] forKey:@"page"];
        if(ServerJieKu){
        }else{
                [dict setObject:@"9.2" forKey:@"OSVersion"];
                [dict setObject:@"94985C47-12B5-4A95-A2C9-29BED8557ADF" forKey:@"deviceCode"];
                [dict setObject:@"eedb_sUPi9sOqQieAnIxDcHgLeRRcXD89dIIGGjSSAqbIe3vVCgHYzbVCcdlZWNqYdpz-CVxcH80DWU" forKey:@"token"];
                [dict setObject:[NSNumber numberWithInt:currentPage] forKey:@"page"];
                [dict setObject:[NSNumber numberWithInt:totalPage] forKey:@"dtu"];
        }
                [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getMethod{
    return @"GET";
}
- (NSString *)getURL{
    if(ServerJieKu){
        return @"";
    }
    return @"/api/imageMoney/getImageMoneyList";
}



- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
////                [AMLoginModel setupObjectClassInArray:^NSDictionary *{
////                    return @{@"friendList":@"AMUserInfoModel"};
////                }];
////                AMLoginModel *response=[AMLoginModel objectWithKeyValues:responseDictionary];
//                self.response.data=response.data;
        
        
                
    }
}
@end
