//
//  TangConfig.h
//  MDApplication
//
//  Created by jieku on 16/6/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TangConfig : NSObject
+(TangConfig *)shareInstance;
@property (nonatomic,strong)NSDictionary *colDic;
@end
