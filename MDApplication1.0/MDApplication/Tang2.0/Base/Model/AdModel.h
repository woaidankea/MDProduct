//
//  AdModel.h
//  MDApplication
//
//  Created by jieku on 16/6/12.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdModel : NSObject
//adname = "\U5e7f\U544a\U56fe2";
//adurl = "http://60.173.8.147/tdapi/Public/Uploads/ad/123456.jpg";
//clickurl = "http://www.baidu.com";
//isclick = 1;
@property (nonatomic,strong)NSString *adname;
@property (nonatomic,strong)NSString *adurl;
@property (nonatomic,strong)NSString *clickurl;
@property (nonatomic,strong)NSString *isclick;
@end
