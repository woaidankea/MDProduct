//
//  MyContentModel.m
//  MDApplication
//
//  Created by jieku on 16/5/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MyContentModel.h"

@implementation MyContentModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"content_id" : @"id"};
}

@end
