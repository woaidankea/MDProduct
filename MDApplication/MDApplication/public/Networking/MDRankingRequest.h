//
//  MDRankingRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMoneyDetailRequest.h"

@interface MDRankingRequest : MDMoneyDetailRequest
- (id)initRequestsuccess:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback;
@end
