//
//  AMMergeHttpParams.h
//  AMen
//
//  Created by gaoxinfei on 15/8/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMMergeHttpParams : NSObject

+(NSMutableDictionary *)httpMerageParams :(NSMutableDictionary*)locationInfo systemInfo:(NSMutableDictionary *)systemInfo appInfo:(NSMutableDictionary *)appInfo actionInfo :(NSMutableDictionary *)actionInfo;

@end
