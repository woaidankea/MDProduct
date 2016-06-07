//
//  MDDeviceInfo.m
//  MDApplication
//
//  Created by jieku on 16/6/2.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDDeviceInfo.h"
#import "UtilsMacro.h"
@implementation MDDeviceInfo
+(NSString *)systemInfoData{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    NSString * strModel  = [UIDevice currentDevice].model;
 

    
    USER_DEFAULT_KEY(@"idfa");
    NSString *systemInfo = [NSString stringWithFormat:@"%@,%@,%f",strModel,@"",[[UIDevice currentDevice].systemVersion floatValue]];
    
    return systemInfo;
}

@end
