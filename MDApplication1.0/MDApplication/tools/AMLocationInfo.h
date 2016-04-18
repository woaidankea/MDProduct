//
//  AMLocationInfo.h
//  AMen
//
//  Created by gaoxinfei on 15/8/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMLocationInfo : NSObject

+(NSMutableDictionary*)locationInfoData:(NSString*)city longitude:(NSString*)longitude latitude:(NSString*)latitude address:(NSString*)address;

+ (NSMutableDictionary *)LBlocationInfoData:(NSString*)city longitude:(double)longitude latitude:(double)latitude address:(NSString*)address;

+ (NSMutableDictionary *)locationInfo;

@end
