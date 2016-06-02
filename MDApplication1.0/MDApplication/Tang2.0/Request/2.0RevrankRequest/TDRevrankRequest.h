//
//  TDAppcolRequest.h
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"
//password	是	string	注册密码
//code	是	string	手机验证码
//inviter	否	string	注册邀请人
//硬件信息	是	string	IOS(手机型号、Adfa【广告ID】、系统版本号) Android（手机型号、操作系统、运营商）
@interface TDRevrankRequest : AMBaseRequest
- (id)initTDRevrankWithtype:(NSString *)type
                      date:(NSString *)date
                          success:(onSuccessCallback)successCallback
                          failure:(onFailureCallback)failureCallback;


@end
