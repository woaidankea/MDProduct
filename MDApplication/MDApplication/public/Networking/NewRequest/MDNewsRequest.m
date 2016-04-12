//
//  MDNewsRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDNewsRequest.h"

@implementation MDNewsRequest

- (id)initWithCurrentPage:(NSInteger)currentPage
                totalPage:(NSInteger)totalPage
                 pageType:(MD_Request_Type)pageType
                  success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
            [dict setObject:@"article" forKey:@"m"];
             [dict setObject:@"wzinfo" forKey:@"a"];
            //接口暂时不能传type 和page  传了就没有数据
             [dict setObject:[NSNumber numberWithInt:pageType]forKey:@"type"];
             [dict setObject:[NSNumber numberWithInteger:currentPage] forKey:@"page"];
            
        }else{
        [dict setObject:@"9.2" forKey:@"OSVersion"];
        [dict setObject:@"94985C47-12B5-4A95-A2C9-29BED8557ADF" forKey:@"deviceCode"];
        [dict setObject:@"b732iA2_paVImdcUkJ5vhpqdnwwHxqhyCjxcW1sWtNGROL8NW5fxBl0XOy8XyFDxeE9CoDrQKmjXjwY" forKey:@"token"];
        [dict setObject:[NSNumber numberWithInt:currentPage] forKey:@"page"];
        [dict setObject:@"100" forKey:@"dtu"];
            [dict setObject:[NSNumber numberWithInt:pageType] forKey:@"type"];}
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{
//    http://api.aizhuanfa.net/api/content/getContentList?OSVersion=9.2&deviceCode=94985C47-12B5-4A95-A2C9-29BED8557ADF&dtu=100&page=1&token=b732iA2_paVImdcUkJ5vhpqdnwwHxqhyCjxcW1sWtNGROL8NW5fxBl0XOy8XyFDxeE9CoDrQKmjXjwY&type=0&version=10205
    http://60.173.8.130/weizuan/?m=article&a=wzinfo
    if (ServerJieKu) {
        return @"";
    }
    return @"/api/content/getContentList";
}
- (NSString*)getMethod{
    return @"GET";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
        //        [AMLoginModel setupObjectClassInArray:^NSDictionary *{
        //            return @{@"friendList":@"AMUserInfoModel"};
        //        }];
        //        AMLoginModel *response=[AMLoginModel objectWithKeyValues:responseDictionary];
        //        self.response.data=response;
    }
}
@end
