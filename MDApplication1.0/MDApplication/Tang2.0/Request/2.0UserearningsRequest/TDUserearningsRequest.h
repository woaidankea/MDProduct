//
//  MDPupilRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//
#import "AMBaseRequest.h"

@interface TDUserearningsRequest : AMBaseRequest
- (id)initWithPage:(NSInteger)page
              type:(NSString *)type
           success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback;
@end
