//
//  MDTXRequest.h
//  MDApplication
//
//  Created by jieku on 16/4/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDTXRequest : AMBaseRequest
- (id)initWithPage:(NSInteger)page
           success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback;
@end
