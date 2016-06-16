//
//  KSGuideManager.h
//  KSGuide
//
//  Created by bing.hao on 16/3/10.
//  Copyright © 2016年 Tsingda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KSGuideManager : NSObject
@property (nonatomic,assign)BOOL Ad;
+ (instancetype)shared;

- (void)showGuideViewWithImages:(NSArray *)images withtype:(BOOL)isAd;

@end
