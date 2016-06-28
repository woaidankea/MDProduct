//
//  TangConfig.m
//  MDApplication
//
//  Created by jieku on 16/6/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TangConfig.h"

@implementation TangConfig
+(TangConfig *)shareInstance;
{
    static TangConfig *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareInstance =[[self alloc] init];
    });
    return shareInstance;
}


@end
