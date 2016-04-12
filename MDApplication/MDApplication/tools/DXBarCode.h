//
//  DXBarCode.h
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DXBarCode : NSObject

+ (DXBarCode *)shareInstance;

- (UIImage *)createBarCodeImageFrom:(NSString *) string withSize:(CGFloat)size;
@end
