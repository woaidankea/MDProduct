//
//  MDRedPacketRequest.m
//  MDApplication
//
//  Created by jieku on 16/4/11.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDRedPacketRequest.h"
#import "MDPublicConfig.h"
#import "MDRedPacketModel.h"
@implementation MDRedPacketRequest
-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed{
    self=[super initWithSuccessCallback:success failureCallback:failed];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(ServerJieKu){
            
            [dict setObject:@"sign" forKey:@"m"];
            [dict setObject:@"sign" forKey:@"a"];
          }
        
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
        
        NSDictionary *dic = [responseDictionary objectForKey:@"data"];
        self.responseObject = [MDRedPacketModel mj_objectWithKeyValues:dic];
        
    }
}

@end
