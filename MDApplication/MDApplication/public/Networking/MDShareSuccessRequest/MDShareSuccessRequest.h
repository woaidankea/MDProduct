//
//  MDShareSuccessRequest.h
//  MDApplication
//
//  Created by jieku on 16/4/11.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDShareSuccessRequest : AMBaseRequest
- (id)initWithAuthcode:(NSString *)authcode
              Platform:(NSString *)platform
                  success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback;
@end
