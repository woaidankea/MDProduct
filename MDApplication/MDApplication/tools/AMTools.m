//
//  AMTools.m
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMTools.h"
#import "Reachability.h"
#import <Foundation/NSObject.h>
#import "sys/sysctl.h"

@implementation AMTools

static const NSUInteger MAX_SIZE=1024*300ul;

#pragma mark 电话号验证
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181
     22         */
    NSString * CT = @"^1((33|53|81|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        
        || ([regextestphs evaluateWithObject:mobileNum] == YES))
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(AM_CheckPhone)checkPhoneNumber:(NSString *)phoneNumber{
    NSInteger phoneLength =phoneNumber.length;
    if (phoneLength > 0)
    {
        if (phoneLength > 11 ||phoneLength < 11)
        {
            return AM_Phone_IsLength;
        }else
        {
            if ([AMTools isMobileNumber:phoneNumber])
            {
                return AM_Phone_IsRight;
            }else
            {
                return AM_Phone_IsFormat;
            }
        }
    }else
    {
        return AM_Phone_IsEmpty;
    }
    return AM_Phone_IsRight;
}

+(AM_CheckPassword)checkPassword:(NSString *)password{
    NSInteger passwordNum =password.length;
    if (passwordNum >30)
    {
        return AM_Password_Greater30;
    }else
    {
        if ((passwordNum >6 ||passwordNum ==6) && passwordNum <30)
        {
            NSString * Isnumber = @"^[0-9]*$";
            NSString * IsWord =@"^[A-Za-z]+$";
            NSPredicate *regextestWord = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IsWord];
            NSPredicate *regextestNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Isnumber];
            if (([regextestWord evaluateWithObject:password] == YES)||([regextestNum evaluateWithObject:password] == YES))
            {
                return AM_Password_Format;
            }else{
                return AM_Password_IsRight;
            }
        }else{
            return AM_Password_Smaller6;
        }
    }
    return AM_Password_IsRight;
}

+ (NSString *)getCheckPhoneMessage:(AM_CheckPhone)checkPhone{
    switch (checkPhone) {
        case AM_Phone_IsEmpty:
            return @"手机号不能为空";
            break;
        case AM_Phone_IsLength:
            return @"手机号位数不对";
            break;
        case AM_Phone_IsRight:
            return @"";
        case AM_Phone_IsFormat:
            return @"手机号格式不对";
        default:
            break;
    }
    return @"";
}
+ (NSString *)getCheckPasswordMessage:(AM_CheckPassword)checkPassword{
    switch (checkPassword) {
        case AM_Password_IsRight:
            return @"";
            break;
        case AM_Password_Smaller6:
            return @"密码不能少于6位";
            break;
        case AM_Password_Greater30:
            return @"密码不能超过30位";
            break;
        case AM_Password_IsEmpty:
            return @"密码不能为空";
            break;
        case AM_Password_Format:
            return @"密码设置的太简单了";
            break;
            
        default:
            break;
    }
    return @"";
}
#pragma mark NSString 为空(nil)的验证
+ (BOOL)isEmptyOrNull:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isAPositiveNumber:(NSInteger)number{
    if (!number) {
        return NO;
    }
    if (number<0) {
        return NO;
    }
    
    return YES;
}

#pragma mark  Email验证
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
/**
 获取当前系统日期
 @returns 月日
 */
+(NSString *)getSystemDate{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM月dd日"];
    return [dateformatter stringFromDate:senddate];
}
+(NSString *)getSystemDateyyyy{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    return [dateformatter stringFromDate:senddate];
}
/**
 @param strdate 日期字符
 @returns 转换后的日期
 */
+(NSDate *)stringToDate:(NSString *)strdate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    return retdate;
}
/**
 NSDate 转 NSString
 @param date 要转的日期
 @returns 转后的日期字符
 */
+(NSString *)dateToString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
//返回day天后的日期(若day为负数,则为|day|天前的日期)
+ (NSString *)dateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *strDate = [dateFormatter stringFromDate:dateAfterDay];
    
    return strDate;
}

+(BOOL)isNetWorkStatus{
    NetworkStatus networkStatus = [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
    if (networkStatus == NotReachable) {
        return NO;
    }
    return YES;
}
//正则表达式验证
+ (BOOL) regularUserInputText : (NSString *) str RegularString:(NSString *)regular
{
    
    //    NSString *patternStr = @"^[\u0391-\uFFE5A-Za-z0-9_]{2,20}$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:regular
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    return NO;
}

+(BOOL)saveImage:(UIImage *)currentImage withName:(NSString *)fullPath{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    [imageData writeToFile:fullPath atomically:NO];
    // 将图片写入文件
    NSFileManager * fileManage=[NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:fullPath]) {
        return YES;
    }
    return NO;
}

+(float)viewHeight:(UIView *)viewmain
{
    int scrollViewHeight=0;
    for (UIView* view in viewmain.subviews){
        scrollViewHeight += view.frame.size.height;
    }
    return scrollViewHeight;
}
//根据color字符串转换UIColor
+(UIColor*)stringRPGForUIColor:(NSString *)color
{
    NSArray *array=[color componentsSeparatedByString:@","];
    float colorR=[(NSString *)[array objectAtIndex:0] floatValue]/255;
    float colorG=[(NSString *)[array objectAtIndex:1] floatValue]/255;
    float colorB=[(NSString *)[array objectAtIndex:2] floatValue]/255;
    UIColor *retColor=[UIColor colorWithRed:colorR green:colorG blue:colorB alpha:100];
    return retColor;
}
//16进制color转UIColor
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(NSString *)getFilePath :(NSString *)fileName{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *temp =[NSString stringWithFormat:@"/%@",fileName];
    NSString *filePath =[documentsDirectory stringByAppendingString:temp];
    return filePath;
}

+(UILabel *)creatLableWithFrame:(CGRect)frame andText:(NSString *)text andColor:(UIColor *)color andFont:(CGFloat)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.text = text;
    return label;
}

+(UIImageView *)createLineWithFrame:(CGRect)frame andColor:(UIColor *)color{
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:frame];
    lineView.backgroundColor =color;
    return lineView;
}

+ (BOOL)imageIsAlpha:(UIImage *)image{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

+ (UIImage *)base64ToImage:(NSString *)base64String{
    if (base64String==nil) {
        return nil;
    }
    NSData *decodedImageData = [[NSData alloc] initWithBase64Encoding:base64String];
    if (decodedImageData==nil) {
        return nil;
    }
    UIImage *decodedImage    = [UIImage imageWithData:decodedImageData];
    if (decodedImage ==NULL) {
        return nil;
    }
    return decodedImage;
}
+ (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    if (newString) {
        return newString;
    }
    return @"";
}

+ (NSString *)imageToBase64String:(UIImage *)imageSrc{
    NSData *data=UIImageJPEGRepresentation(imageSrc, 0.1);
    NSString *pictureDataString=[data base64EncodedStringWithOptions: 0];
    
    return pictureDataString;
}
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value
+(NSMutableArray*)dictionryChangeToString:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strKeys=[[NSMutableString alloc]init];
    NSMutableString *strValues=[[NSMutableString alloc]init];
    NSMutableArray *field=[NSMutableArray arrayWithCapacity:2];
    for (NSString * str in keys) {
        [strKeys appendFormat:@"%@,",str];
    }
    for (NSString * str in values) {
        [strValues appendFormat:@"%@,",str];
    }
    int keysLong=(int)[strKeys length];
    int valuesLong=(int)[strValues length];
    [strKeys deleteCharactersInRange:NSMakeRange(keysLong-1, 1)];
    [strValues deleteCharactersInRange:NSMakeRange(valuesLong-1, 1)];
    [field addObject:strKeys];
    [field addObject:strValues];
    return field;
}
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value
+(NSMutableArray*)dictionryChangeToInsertString:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strKeys=[[NSMutableString alloc]init];
    NSMutableString *strValues=[[NSMutableString alloc]init];
    NSMutableArray *field=[NSMutableArray arrayWithCapacity:2];
    //    for (NSString * str in keys) {
    //        [strKeys appendFormat:@"%@,",str];
    //    }
    //
    //    for (NSString * str in values) {
    //
    //        [strValues appendFormat:@"\"%@\",",str];
    //
    //
    //    }
    
    NSString *tempString=@"";
    for (NSInteger i=0; i< keys.count; i++) {
        tempString =[keys objectAtIndex:i];
        if (i < keys.count -1) {
            [strKeys appendFormat:@"%@,",tempString];
        }else{
            [strKeys appendFormat:@"%@",tempString];
        }
    }
    
    for (NSInteger i=0; i< values.count; i++) {
        tempString =[values objectAtIndex:i];
        if (i < values.count -1) {
            [strValues appendFormat:@"\"%@\",",tempString];
        }else{
            [strValues appendFormat:@"\"%@\"",tempString];
        }
    }
    
    [field addObject:strKeys];
    [field addObject:strValues];
    return field;
}

//数据库删除 数组转字符串   key = value AND key = value
+ (NSString *)dicChangeToStringForDeleteWhere:(NSDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    
    for (int i = 0 ; i<[keys count]; i++) {
        [strSql appendFormat:@" %@ = \"%@\" AND",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-3, 3)];
    
    return strSql;
}
//数据库查询 数组转字符串   key = value , key = value
+(NSString *)dicChangeToStringForUpdateWithOtherField:(NSDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    for (int i = 0 ; i<[keys count]; i++) {
        [strSql appendFormat:@" %@ = \"%@\" ,",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
    return strSql;
}
//数据库查询 数组转字符串   key = value , key = value where id = XX
+(NSString *)dicChangeToStringForUpdate:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    for (int i = 0 ; i<[keys count]; i++) {
        if ([[keys objectAtIndex:i]isEqual:@"id"]) {
            continue;
        }
        if ([[keys objectAtIndex:i]isEqual:@"keyValue"]) {
            continue;
        }
        if ([[keys objectAtIndex:i]isEqual:@"keyName"]) {
            continue;
        }
        [strSql appendFormat:@" %@ = \"%@\" ,",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    
    NSString *keyName =[dic objectForKey:@"keyName"];
    NSInteger keyValue =[[dic objectForKey:keyName]integerValue];
    
    
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
    [strSql appendFormat:@" WHERE %@ = %ld",keyName,keyValue];
    return strSql;
}


+(NSString *)strDateForNow
{
    NSDate* date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
}

+(NSString *)strDeleteDoubleTagWithStr:(NSString *)str
{
    //    if (str>=0) {
    //        return str;
    //    }
    for (int i = 0; i<[str length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        //        NSLog(@"string is %@",s);
        if ([s isEqualToString:@"\""]) {
            NSRange range = NSMakeRange(i, 1);
            //将字符串中的“m”转化为“w”
            str = [str stringByReplacingCharactersInRange:range withString:@"'"];
            
        }
    }
    return str;
}
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value
+(NSMutableArray*)dictionryChangeToInsertStringAndChangeDoublePointToOnePoint:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strKeys=[[NSMutableString alloc]init];
    NSMutableString *strValues=[[NSMutableString alloc]init];
    NSMutableArray *field=[NSMutableArray arrayWithCapacity:2];
    for (NSString * str in keys) {
        [strKeys appendFormat:@"%@,",str];
    }
    for (NSString * str in values) {
        //        NSLog(@"dictionryChangeToInsertString %@",str);
        
        [strValues appendFormat:@"\"%@\",",[AMTools strDeleteDoubleTagWithStr:[NSString stringWithFormat:@"%@",str]]];
        
    }
    int keysLong=(int)[strKeys length];
    int valuesLong=(int)[strValues length];
    [strKeys deleteCharactersInRange:NSMakeRange(keysLong-1, 1)];
    [strValues deleteCharactersInRange:NSMakeRange(valuesLong-1, 1)];
    [field addObject:strKeys];
    [field addObject:strValues];
    return field;
}
//数据库查询 数组转字符串   key = value  AND key = value
+(NSString *)dicChangeToStringForSelectWhere:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    
    for (int i = 0 ; i<[keys count]; i++) {
        [strSql appendFormat:@" %@ = \"%@\" AND",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    //    NSLog(@"=====>%@",strSql);
    //warning 增加判断
    if (strSql.length>6) {
        [strSql deleteCharactersInRange:NSMakeRange([strSql length]-3, 3)];
    }
    return strSql;
}

+(NSString *)longlongNumberTime:(NSTimeInterval)timeNumber{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeNumber/1000.0f];
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    if([calendar isDateInToday:date]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@" HH:mm"];
        NSString *timeStr = [dateFormatter stringFromDate:date];
        return timeStr;
    }else if([calendar isDateInYesterday:date]){
        return @"昨天";
    }else if([calendar isDateInWeekend:date]){
        NSDateComponents *dateComponents=[calendar components:NSWeekdayCalendarUnit fromDate:date];
        NSInteger weekday=dateComponents.weekday;
        if(weekday==1){
            return @"星期日";
        }else if(weekday==2){
            return @"星期一";
        }else if(weekday==3){
            return @"星期二";
        }else if(weekday==4){
            return @"星期三";
        }else if(weekday==5){
            return @"星期四";
        }else if(weekday==6){
            return @"星期五";
        }else {
            return @"星期六";
        }
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate:date];
        return timeStr;
    }
}


#pragma mark - AlertView -

+ (void)showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancel{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:nil];
    [alertView show];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancel{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:nil];
    [alertView show];
}

+ (void)showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancel otherButtonTitle:(NSString *)other{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:other,nil];
    [alertView show];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancel otherButtonTitle:(NSString *)other{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:other,nil];
    [alertView show];
}

+ (void)showAlertViewWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancel{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:nil];
    [alertView show];
}

+ (void)showAlertViewWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancel otherButtonTitle:(NSString *)other{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:other,nil];
    [alertView show];
}

#pragma mark -- 图片处理

+ (UIImage *)compressImageWithImage:(UIImage*)image{
    
    UIImage* newImage= [AMTools image:image fitInSize:CGSizeMake(768, 768)];
    AMLog(@"newImage size.w: %f, h: %f",newImage.size.width,newImage.size.height);
    NSData* data= UIImageJPEGRepresentation(newImage, 1.0);
    AMLog(@"image size:%lul", (unsigned long)data.length);
    if(data.length>MAX_SIZE){
        data=UIImageJPEGRepresentation(newImage, 0.5);
        newImage=[UIImage imageWithData:data];
    }
    return newImage;
};

// 返回调整的缩略图
+ (UIImage *)image: (UIImage *)image fitInSize: (CGSize)viewsize
{
    // calculate the fitted size
    CGSize size = [AMTools fitSize:image.size inSize:viewsize];
    
    UIGraphicsBeginImageContext(size);
    
    //    float dwidth = (size.width) / 2.0f;
    //    float dheight = (size.height) / 2.0f;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

// 计算适合的大小。并保留其原始图片大小
+ (CGSize) fitSize: (CGSize)thisSize inSize: (CGSize) aSize
{
    CGFloat scale;
    CGSize newsize = thisSize;
    
    if (newsize.height && (newsize.height > aSize.height))
    {
        scale = aSize.height / newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    
    if (newsize.width && (newsize.width >= aSize.width))
    {
        scale = aSize.width / newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    
    return newsize;
}


+ (void)showHUDtoView:(UIView *)view title:(NSString *)title delay:(NSInteger)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
}

+ (void)showHUDtoWindow:(UIWindow *)window title:(NSString *)title delay:(NSInteger)delay
{
    if (!title || title.length == 0) {
        return;
    }
    if (!window) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        window = keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
}


@end
