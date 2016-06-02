//
//  TDAppcolRequest.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TDProfilesaveRequest.h"

@implementation TDProfilesaveRequest

- (id)initProfileSaveWithavatar:(NSData *)imageData
                       nickname:(NSString *)nickname
                            sex:(NSString *)sex
                       birthday:(NSString *)birthday
                      education:(NSString *)education
                       industry:(NSString *)industry
                       vocation:(NSString *)vocation
                         income:(NSString *)income
                        success:(onSuccessCallback)successCallback
                        failure:(onFailureCallback)failureCallback
{
    self=[super initWithSuccessCallback:successCallback failureCallback:failureCallback];
    if(self){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
   
            
       
        [self setActionInfo:dict];
    }
    return self;
}
- (NSString *)getURL{

        return kProfilesaved;
}

- (NSString*)getMethod{
    return @"POST";
}
- (void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([self.response isSucceed]){
        
        self.responseObject = [responseDictionary objectForKey:@"data"];
    }
}

@end
