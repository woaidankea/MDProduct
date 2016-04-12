//
//  AMLocationInfo.m
//  AMen
//
//  Created by gaoxinfei on 15/8/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMLocationInfo.h"
#import "AMTools.h"

@implementation AMLocationInfo

+(NSMutableDictionary*)locationInfoData:(NSString*)city longitude:(NSString*)longitude latitude:(NSString*)latitude address:(NSString*)address
{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if (![AMTools isEmptyOrNull:city]) {
       [dict setObject:city forKey:@"city"];
    }else{
        [dict setObject:@"" forKey:@"city"];
    }
    if (![AMTools isEmptyOrNull:longitude]) {
        [dict setObject:longitude forKey:@"longitude"];
    }else{
        [dict setObject:@"" forKey:@"longitude"];
    }
    
    if (![AMTools isEmptyOrNull:latitude]) {
         [dict setObject:latitude forKey:@"latitude"];
    }else{
        [dict setObject:@"" forKey:@"latitude"];
    }
    
    if (![AMTools isEmptyOrNull:address]) {
        [dict setObject:address forKey:@"address"];
    }else{
        [dict setObject:@"" forKey:@"address"];
    }
    [dict setObject:@"+86" forKey:@"countryCode"];
    
    
    
    return dict;
}


+ (NSMutableDictionary *)LBlocationInfoData:(NSString*)city longitude:(double)longitude latitude:(double)latitude address:(NSString*)address
{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if (![AMTools isEmptyOrNull:city]) {
        [dict setObject:city forKey:@"city"];
    }else{
        [dict setObject:@"" forKey:@"city"];
    }
    //    if (![AMTools isEmptyOrNull:[NSNumber numberWithDouble:longitude]]) {
    [dict setObject:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];
    //    }else{
    //        [dict setObject:@"" forKey:@"longitude"];
    //    }
    
    //    if (![AMTools isEmptyOrNull:[NSNumber numberWithDouble:latitude]]) {
    [dict setObject:[NSNumber numberWithDouble:latitude] forKey:@"latitude"];
    //    }else{
    //        [dict setObject:@"" forKey:@"latitude"];
    //    }
    
    if (![AMTools isEmptyOrNull:address]) {
        [dict setObject:address forKey:@"address"];
    }else{
        [dict setObject:@"" forKey:@"address"];
    }
    [dict setObject:@"+86" forKey:@"countryCode"];
    
    return dict;
}

+ (NSMutableDictionary *)locationInfo
{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if (![AMTools isEmptyOrNull:[NSUSERDEFAULIT objectForKey:LOCATION_city]]) {
        [dict setObject:[NSUSERDEFAULIT objectForKey:LOCATION_city] forKey:@"city"];
    }else{
        [dict setObject:@"" forKey:@"city"];
    }

    if ([NSUSERDEFAULIT objectForKey:@"longitude"]) {
        [dict setObject:[NSUSERDEFAULIT objectForKey:@"longitude"] forKey:@"longitude"];
        [dict setObject:[NSUSERDEFAULIT objectForKey:@"latitude"] forKey:@"latitude"];
    }
    
    if (![AMTools isEmptyOrNull:[NSUSERDEFAULIT objectForKey:@"address"]]) {
        [dict setObject:[NSUSERDEFAULIT objectForKey:@"address"] forKey:@"address"];
    }else{
        [dict setObject:@"" forKey:@"address"];
    }
    [dict setObject:@"+86" forKey:@"countryCode"];
    
    return dict;
}

@end
