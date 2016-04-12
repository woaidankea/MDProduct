//
//  MDNewsRequest.h
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"
#import "MDPublicConfig.h"
@interface MDNewsRequest : AMBaseRequest
- (id)initWithCurrentPage:(NSInteger)currentPage
                totalPage:(NSInteger)totalPage
                 pageType:(MD_Request_Type)pageType
                  success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback;
@end
