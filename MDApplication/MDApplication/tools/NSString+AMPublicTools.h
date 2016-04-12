//
//  NSString+AMPublicTools.h
//  AMen
//
//  Created by xy on 15/9/12.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AMPublicTools)

// 提供一个对比字符串 方法
- (BOOL)isContainWithString:(NSString *)string;

// 提供全拼
+ (NSString *)chineseSwitchPinyin:(NSString *)pinYin;

@end
