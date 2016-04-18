//
//  MDAddShareRequest.h
//  MDApplication
//
//  Created by jieku on 16/4/14.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface MDAddShareRequest : AMBaseRequest
- (id)initWithContentID:(NSString *)contentid
               Platform:(NSInteger)platform
                success:(onSuccessCallback)successCallback
                failure:(onFailureCallback)failureCallback;
@end
