//
//  MDLoginRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDLoginRequest : AMBaseRequest
- (id)initWithTelephone:(NSString *)telephone
               password:(NSString *)password
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback;

@end
