//
//  ShareConfig.m
//  MDApplication
//
//  Created by jieku on 16/7/1.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "ShareConfig.h"
#import "TDShareconfigRequest.h"
#import "ShareConfigModel.h"
@implementation ShareConfig
static ShareConfig *_shareTools = nil;
+(ShareConfig *)shareToolsInstance
{
    if (_shareTools == nil)
    {
        _shareTools = [[ShareConfig alloc] init];
        
    }
    return _shareTools;
}
- (id)init{
    self = [super init];
    WS(weakSelf);
    TDShareconfigRequest *request = [[TDShareconfigRequest alloc]initShareconfigsuccess:^(AMBaseRequest *request) {
        weakSelf.configArray = [ShareConfigModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"shareConfig"]];
    } failure:^(AMBaseRequest *request) {
        
    }];
    
    [request start];
    
    
    
    
    
    return  self;
}
@end
