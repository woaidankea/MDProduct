//
//  MDUserInfoModel.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDUserInfoModel.h"

@implementation MDUserInfoModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"memberId" : @"id"};
}


@end
