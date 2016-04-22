//
//  MDBeautifulPicModel.h
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "MDPublicConfig.h"
@interface MDBeautifulPicModel : NSObject
@property (nonatomic,strong)NSString *memberId;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *imageSmall;
@property (nonatomic,strong)NSString *imageBig;
@property (nonatomic,strong)NSString *scanCount;
@property (nonatomic,strong)NSString *startX;
@property (nonatomic,strong)NSString *startY;
@property (nonatomic,strong)NSString *size;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *inCome;    // income 捷酷服务器:inCome
@property (nonatomic,strong)NSString *threshold;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *codeUrl;
@property (nonatomic,strong)NSString *isTop;
@property (nonatomic,strong)NSString *locationType;
@property (nonatomic,strong)NSString *showPrice;
@property (nonatomic,strong)NSString *authcode;
@property (nonatomic,strong)NSString *authMember;
@end
