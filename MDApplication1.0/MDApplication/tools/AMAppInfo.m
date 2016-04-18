//
//  AMAppInfo.m
//  AMen
//
//  Created by gaoxinfei on 15/8/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMAppInfo.h"
#import "MDPublicConfig.h"

@implementation AMAppInfo

+(NSMutableDictionary *)appInfoData{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    [dict setObject:currentLanguage forKey:@"language"];
    NSString *version =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
     [dict setObject:version forKey:@"vsersion"];
//    NSString *bundleId =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *bundleId =@"com.amen";
    [dict setObject:bundleId forKey:@"bundleId"];
    return dict;
}
@end
