//
//  AMSystemInfo.m
//  AMen
//
//  Created by gaoxinfei on 15/8/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMSystemInfo.h"
#import "MDPublicConfig.h"
#import <UIKit/UIDevice.h>


@implementation AMSystemInfo

+(NSMutableDictionary *)systemInfoData{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    NSString * strModel  = [UIDevice currentDevice].model;
    NSString *osver =@"ios";
    
    //NSString *idfa =@"100";
    
    ///TODO:为了调试获取群记录，将来需要重新获取
    NSString *idfa=@"101";
    
    //TODO:获取设备唯一标识
    
    [dict setObject:osver forKey:@"osver"];
    [dict setObject:idfa forKey:@"idfa"];
    [dict setObject:strModel forKey:@"device"];
    
    NSString *imei=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [dict setObject:imei forKey:@"imei"];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    [dict setObject:currentLanguage forKey:@"language"];
    
    return dict;
}
@end
