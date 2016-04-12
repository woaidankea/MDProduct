//
//  NSString+AMPublicTools.m
//  AMen
//
//  Created by xy on 15/9/12.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "NSString+AMPublicTools.h"

@implementation NSString (AMPublicTools)

- (BOOL)isContainWithString:(NSString *)string {
    if ([self containsString:string] | [self.uppercaseString containsString:string.uppercaseString] | [self.lowercaseString containsString:string.lowercaseString]) {
        return YES;
    }
    
    return NO;
}

// 提供全拼
+ (NSString *)chineseSwitchPinyin:(NSString *)pinYin {
    
    NSString *returnPinYin = @"#";
    
    if ([pinYin length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:pinYin];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            returnPinYin = ms;
        }
    }
    return returnPinYin;
}

@end
