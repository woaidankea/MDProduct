//
//  MDGetMemberInfoRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDGetMemberInfoRequest : AMBaseRequest
- (id)initWithToken:(NSString *)token
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback;

@end
