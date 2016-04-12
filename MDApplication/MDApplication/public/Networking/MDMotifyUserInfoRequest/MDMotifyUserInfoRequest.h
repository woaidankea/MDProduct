//
//  MDMotifyUserInfoRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/30.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"
#import "MDMemberInterestModel.h"
@interface MDMotifyUserInfoRequest : AMBaseRequest
- (id)initWithModel:(NSDictionary *)params
           success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback;
@end
