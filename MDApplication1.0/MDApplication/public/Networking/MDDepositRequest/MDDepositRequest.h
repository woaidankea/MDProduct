//
//  MDDepositRequest.h
//  MDApplication
//
//  Created by jieku on 16/4/11.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDDepositRequest : AMBaseRequest
- (id)initWithCurrentPage:(NSInteger)currentPage
                  success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback;
@end
