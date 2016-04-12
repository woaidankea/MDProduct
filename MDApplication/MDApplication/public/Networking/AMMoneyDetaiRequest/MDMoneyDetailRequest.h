//
//  MDMoneyDetailRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDMoneyDetailRequest : AMBaseRequest
- (id)initWithPage:(NSInteger)page
            success:(onSuccessCallback)successCallback
            failure:(onFailureCallback)failureCallback;
@end
