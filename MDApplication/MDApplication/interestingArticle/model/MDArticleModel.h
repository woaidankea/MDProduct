//
//  MDArticleModel.h
//  MDApplication
//
//  Created by jieku on 16/3/22.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface MDArticleModel : NSObject
@property (nonatomic,strong)NSString *assignUrl;    //detail 网页地址
@property (nonatomic,strong)NSString *cover;        //标题图片地址
@property (nonatomic,strong)NSString *title;         //标题
@property (nonatomic,strong)NSString *readCount;     //阅读
@property (nonatomic,strong)NSString *threshold;
@property (nonatomic,strong)NSString *isTop;
@property (nonatomic,strong)NSString *quickShare;
@property (nonatomic,strong)NSString *createTime;     //创建时间
@property (nonatomic,strong)NSString *memberId;
@property (nonatomic,strong)NSString *showPrice;
@property (nonatomic,strong)NSString *failTime;
@property (nonatomic,strong)NSString *nextId;
@property (nonatomic,strong)NSString *shareCount;
@property (nonatomic,strong)NSString *ret;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *isHot;
@property (nonatomic,strong)NSString *tag;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *sourceUrl;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *inCome;
@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSArray *shareConfig;
@property (nonatomic,strong)NSString *authcode;
@end
