//
//  MDModifyPassword.h
//  MDApplication
//
//  Created by jieku on 16/3/31.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDModifyPassword : AMBaseRequest
- (id)initWithOldPassword:(NSString *)oldpassword
             Newpassword:(NSString *)newpassword
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback;
@end
