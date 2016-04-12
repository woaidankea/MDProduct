//
//  UIColor+HexStringToColor.h
//  DEVSNS

//  Created by liu peter on 15-3-2.
//  Copyright (c) 2015年 sun lin. All rights reserved.
//  将16进制字符串转化为UIColor

#import <UIKit/UIKit.h>

@interface UIColor (HexStringToColor)

+ (UIColor *)ColorWithHexString:(NSString *)stringToConvert;

@end
