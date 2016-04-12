//
//  MDCheckVertifyRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/28.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDCheckVertifyRequest : AMBaseRequest
- (id)initWithTelephone:(NSString *)telephone
             VerifyCode:(NSString *)verifycode
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback;
@end
