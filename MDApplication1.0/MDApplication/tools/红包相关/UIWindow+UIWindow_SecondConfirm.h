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
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)UITextField *codeField;
@property (nonatomic,strong)UIImageView *codeImageView;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)UIButton *getSecurityBtn;

//验证码倒计时
@property (nonatomic, strong) NSTimer *countTimer;

- (void)initConfirmWindow:(NSString *) imgUrl Phone:(NSString *)phone withType:(NSString *)type;

- (void)initConfirmWindow:(NSString *) username password:(NSString *)password withType:(NSString *)type;
@end
