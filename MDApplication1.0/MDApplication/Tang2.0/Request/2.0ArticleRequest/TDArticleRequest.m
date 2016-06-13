//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDArticleRequest.h"

@implementation TDArticleRequest

- (id)initColWithType:(NSString *)type
                 page:(NSInteger )page
              success:(onSuccessCallback)successCallback
              failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
   
        NSString *currentPage = [NSString stringWithFormat:@"%ld",page];
        [dict setObject:POST_VALUE(currentPage) forKey:@"page"];
        [dict setObject:POST_VALUE(type) forKey:@"type"];
   
       
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

        return kArticle;
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
