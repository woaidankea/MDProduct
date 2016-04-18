//
//  AMMergeHttpParams.m
//  AMen
//
//  Created by gaoxinfei on 15/8/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMMergeHttpParams.h"

@implementation AMMergeHttpParams

+(NSMutableDictionary *)httpMerageParams :(NSMutableDictionary*)locationInfo systemInfo:(NSMutableDictionary *)systemInfo appInfo:(NSMutableDictionary *)appInfo actionInfo :(NSMutableDictionary *)actionInfo{
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    if (locationInfo) {
       [params setObject:locationInfo forKey:@"locationInfo"];
    }else{
        NSLog(@"location参数为nil");
    }
    if (systemInfo) {
        [params setObject:systemInfo forKey:@"systemInfo"];
    }else{
        NSLog(@"system参数为nil");
    }
    if (appInfo) {
       [params setObject:appInfo forKey:@"appInfo"];
    }else{
        NSLog(@"app参数为nil");
    }
    if (actionInfo) {
        [params setObject:actionInfo forKey:@"actionInfo"];
    }else{
        NSLog(@"action参数为nil");
    }
    return params;
}

@end
