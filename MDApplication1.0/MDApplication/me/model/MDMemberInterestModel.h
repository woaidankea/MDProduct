//
//  MDMemberInterestModel.h
//  MDApplication
//
//  Created by jieku on 16/3/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface MDMemberInterestModel : NSObject
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *birthday;
@property (nonatomic,copy)NSString *vocation;    //行业
@property (nonatomic,copy)NSString *interest;
@property (nonatomic,copy)NSString *education;
@property (nonatomic,copy)NSString *income;    //收入
@property (nonatomic,copy)NSString *avatar;     //头像 昵称
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *phone;    //手机号   2.0+


@end
