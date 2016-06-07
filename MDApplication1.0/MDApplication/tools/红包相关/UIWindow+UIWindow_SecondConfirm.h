//
//  UIWindow+UIWindow_SecondConfirm.h
//  MDApplication
//
//  Created by jieku on 16/6/3.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (UIWindow_SecondConfirm)
@property (nonatomic, strong) UIView     *windowUv;
@property (nonatomic,strong)NSString *imgUrl;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)UITextField *codeField;
@property (nonatomic,strong)UIImageView *codeImageView;
- (void)initConfirmWindow:(NSString *) imgUrl Phone:(NSString *)phone;

@end
