//
//  MDPupilRequest.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDPupilRequest.h"
#import "MDPublicConfig.h"
@implementation MDPupilRequest

- (id)initWithPage:(NSInteger)page
           success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
            [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
            [dict setObject:@"tudi" forKey:@"m"];
            [dict setObject:@"mytudi" forKey:@"a"];
            
        }else{
           
        }
        
        [self setActionInfo:dict];
    }
    return self;
    
    
}

- (NSString *)getMethod{
    return @"GET";
}

- (NSString *)getURL{
    return @"";
//   return  @"/api/member/getPupilList";
}

- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        //        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
        self.responseObject = [responseDictionary objectForKey:@"data"];
        
    }
}

@end
