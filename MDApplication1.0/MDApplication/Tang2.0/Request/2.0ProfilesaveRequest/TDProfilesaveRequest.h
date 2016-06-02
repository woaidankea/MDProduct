//
//  TDAppcolRequest.h
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "AMBaseRequest.h"

@interface TDProfilesaveRequest : AMBaseRequest

//avatar	是	string	头像（字节流）
//nickname	是	string	昵称
//sex	是	string	性别
//birthday	是	string	出生年月
//education	是	string	学历
//industry	是	string	行业
//vocation	是	string	职业
//income	是	string	用户收入
- (id)initProfileSaveWithavatar:(NSData *)imageData
                       nickname:(NSString *)nickname
                            sex:(NSString *)sex
                       birthday:(NSString *)birthday
                      education:(NSString *)education
                       industry:(NSString *)industry
                       vocation:(NSString *)vocation
                         income:(NSString *)income
                        success:(onSuccessCallback)successCallback
                  failure:(onFailureCallback)failureCallback;


@end
