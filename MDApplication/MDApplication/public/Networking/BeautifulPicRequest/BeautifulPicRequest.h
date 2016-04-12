//
//  BeautifulPicRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface BeautifulPicRequest : AMBaseRequest
- (id)initWithCurrentPage:(NSInteger)currentPage
                totalPage:(NSInteger)totalPage
                 pageType:(NSString *)pageType
                  success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback;
@end
