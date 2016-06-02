//
//  MDPupilRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//
#import "AMBaseRequest.h"
//phone	是	string	用户手机号码
//phonecode	是	string	手机验证码
//newpass	否	string	用户新密码
@interface TDUsrforgotpwdRequest : AMBaseRequest
- (id)initWithphone:(NSString *)phone
          phonecode:(NSString *)phonecode
            newpass:(NSString *)newpass
            success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback;
@end
