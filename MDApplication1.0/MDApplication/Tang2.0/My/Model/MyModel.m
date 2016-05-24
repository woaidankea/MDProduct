//
//  MyModel.m
//  MDApplication
//
//  Created by jieku on 16/5/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MyModel.h"
#import "MyContentModel.h"
@implementation MyModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"list" : @"MyContentModel"
             };
}

@end
