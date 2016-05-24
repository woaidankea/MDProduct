//
//  ContentModel.h
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface ContentModel : NSObject
@property (nonatomic,strong)NSString * content_id;
@property (nonatomic,strong)NSString * type;
@property (nonatomic,strong)NSString * sort;
@property (nonatomic,strong)NSString * status;
@end
