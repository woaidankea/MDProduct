//
//  TabMenuModel.h
//  MDApplication
//
//  Created by jieku on 16/5/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface TabMenuModel : NSObject
@property (nonatomic,strong)NSString *moduleid;
@property (nonatomic,strong)NSString *modulename;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *iconSelected;
@property (nonatomic,strong)NSString *iconUnSelected;
@property (nonatomic,strong)NSString *show;
@property (nonatomic,strong)NSString *index;

@end
