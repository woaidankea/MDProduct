//
//  TDAppcolRequest.h
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface TDArticleRequest : AMBaseRequest
- (id)initColWithType:(NSString *)type
                 page:(NSInteger )page
              success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback;


@end
