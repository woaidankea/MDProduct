//
//  MDFindPassword.h
//  MDApplication
//
//  Created by jieku on 16/3/28.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDFindPassword : AMBaseRequest
- (id)initWithTelephone:(NSString *)telephone
             VerifyCode:(NSString *)verifycode
               PassWord:(NSString *)password
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback;
@end
