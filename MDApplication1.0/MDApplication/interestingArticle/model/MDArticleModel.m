//
//  MDArticleModel.m
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDArticleModel.h"

@implementation MDArticleModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"desc" : @"description"};
}




+ (NSDictionary *)objectClassInArray{
    return @{
             @"shareConfig" : @"MDShareModel"
        };
}

@end
