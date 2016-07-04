//
//  ShareConfig.h
//  MDApplication
//
//  Created by jieku on 16/7/1.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareConfig : NSObject
@property (nonatomic,strong)NSArray *configArray;

+(ShareConfig *)shareToolsInstance;

@end
