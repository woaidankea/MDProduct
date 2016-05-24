//
//  AMTools.h
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDPublicConfig.h"
#import "RDVTabBarController.h"
#import "MBProgressHUD.h"

@interface AMTools : NSObject 

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (AM_CheckPhone)checkPhoneNumber:(NSString *)phoneNumber;
+ (AM_CheckPassword)checkPassword:(NSString *)password;
+ (NSString *)getCheckPhoneMessage:(AM_CheckPhone)checkPhone;
+ (NSString *)getCheckPasswordMessage:(AM_CheckPassword)checkPassword;
+ (BOOL)isEmptyOrNull:(NSString *)string;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSString *)getSystemDate;
+ (NSString *)getSystemDateyyyy;
+ (NSDate *)stringToDate:(NSString *)strdate;
+ (NSString *)dateToString:(NSDate *)date;
+ (NSString *)dateAfterDay:(int)day;
+ (BOOL)isNetWorkStatus;
+ (BOOL) regularUserInputText : (NSString *) str RegularString:(NSString *)regular;
+ (BOOL)saveImage:(UIImage *)currentImage withName:(NSString *)fullPath;
+ (float)viewHeight:(UIView *)viewmain;
+ (UIColor*)stringRPGForUIColor:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (NSString *)getFilePath :(NSString *)fileName;
+ (UILabel *)creatLableWithFrame:(CGRect)frame andText:(NSString *)text andColor:(UIColor *)color andFont:(CGFloat)font;
+ (UIImageView *)createLineWithFrame:(CGRect)frame andColor:(UIColor *)color;
+ (UIImage *)base64ToImage:(NSString *)base64String;
+ (NSString *)imageToBase64String:(UIImage *)imageSrc;
+ (BOOL)imageIsAlpha:(UIImage *)image;
+ (NSMutableArray*)dictionryChangeToInsertString:(NSDictionary *)dic;
+(NSString *)dicChangeToStringForSelectWhere:(NSDictionary *)dic;
+(NSString *)dicChangeToStringForDeleteWhere:(NSDictionary *)dic;
+ (NSString*)encodeURL:(NSString *)string;
+(NSString *)dicChangeToStringForUpdateWithOtherField:(NSDictionary *)dic;
+(NSString *)dicChangeToStringForUpdate:(NSDictionary *)dic;
+(NSString *)longlongNumberTime:(NSTimeInterval)timeNumber;

+(UIImage *)compressImageWithImage:(UIImage *)image;


//数字存在，且为正数
+ (BOOL)isAPositiveNumber:(NSInteger)number;

#pragma mark - AlertView -
+ (void)showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancel;

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancel;

+ (void)showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancel otherButtonTitle:(NSString *)other;

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancel otherButtonTitle:(NSString *)other;

+ (void)showAlertViewWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancel;

+ (void)showAlertViewWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancel otherButtonTitle:(NSString *)other;


+ (void)showHUDtoView:(UIView *)view title:(NSString *)title delay:(NSInteger)delay;

+ (void)showHUDtoWindow:(UIWindow *)window title:(NSString *)title delay:(NSInteger)delay;





+ (id)getLocalJsonDataWithFileName:(NSString *)fileName;


@end
