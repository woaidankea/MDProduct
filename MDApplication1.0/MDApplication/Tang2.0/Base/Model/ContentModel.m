//
//  ContentModel.m
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"content_id" : @"id"};
}

@end
