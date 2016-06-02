//
//  TDAppcolRequest.h
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface TDCheckforpwdcodeRequest : AMBaseRequest
- (id)initCheckforpwdCodeWithPhone:(NSString *)phone
                          success:(onSuccessCallback)successCallback
                          failure:(onFailureCallback)failureCallback;


@end
