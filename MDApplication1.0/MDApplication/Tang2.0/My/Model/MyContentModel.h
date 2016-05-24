//
//  MyContentModel.h
//  MDApplication
//
//  Created by jieku on 16/5/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface MyContentModel : NSObject
@property (nonatomic,strong)NSString * content_id;
@property (nonatomic,strong)NSString * moduletype;
@property (nonatomic,strong)NSString *modulename;
@property (nonatomic,strong)NSString * sort;
@property (nonatomic,strong)NSString * status;
@property (nonatomic,strong)NSString * url;
@property (nonatomic,strong)NSString * imageurl;
@end
