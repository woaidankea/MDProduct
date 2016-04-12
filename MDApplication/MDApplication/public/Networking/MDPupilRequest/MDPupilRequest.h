//
//  MDPupilRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMoneyDetailRequest.h"

@interface MDPupilRequest : MDMoneyDetailRequest
- (id)initWithPage:(NSInteger)page
           success:(onSuccessCallback)successCallback
           failure:(onFailureCallback)failureCallback;
@end
