//
//  MDForgotPasswordRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/28.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDForgotPasswordRequest : AMBaseRequest
- (id)initWithTelephone:(NSString *)telephone
                m:(NSString *)m
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback;
@end
