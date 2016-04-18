//
//  AppMacro.h
//  NQYoungCloud
//
//  Created by libo on 14-6-13.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#ifndef NQYoungCloud_AppMacro_h
#define NQYoungCloud_AppMacro_h



#define LB_AppDelegate(appDelegate)     AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;


/**
 沙盒路径
 */
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]



/**
 DEBUG LOG
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d   \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


/**
 DEBUG RELEASE
 安全释放对象
 */
#define RELEASE_SAFELY(__POINTER) { if(__POINTER){[__POINTER release]; __POINTER = nil;}}


/**
 屏幕尺寸
 */
#define SCREEN                      [[UIScreen mainScreen] bounds];
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define CONTENT_HEIGHT              (SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT)

#define APP_SCREEN                  [[UIScreen mainScreen] applicationFrame];
#define APP_SCREEN_HEIGHT           [[UIScreen mainScreen] applicationFrame].size.height
#define APP_SCREEN_WIDTH            [[UIScreen mainScreen] applicationFrame].size.width


#define MinX(v)                     CGRectGetMinX((v).frame)
#define MinY(v)                     CGRectGetMinY((v).frame)

#define MidX(v)                     CGRectGetMidX((v).frame)
#define MidY(v)                     CGRectGetMidY((v).frame)

#define MaxX(v)                     CGRectGetMaxX((v).frame)
#define MaxY(v)                     CGRectGetMaxY((v).frame)

#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)



// 系统控件默认高度
#define STATUSBAR_HEIGHT            (20.f)

#define NAVIGATIONBAR_HEIGHT        (44.f)
#define TABBAR_HEIGHT               (49.f)

#define KEYBOARD_ENGLISH_HEIGHT     (216.f)
#define KEYBOARD_CHINESE_HEIGHT     (252.f)


//断言
#if !defined(_NSAssertBody)
#define NSAssert(condition, desc, ...)	\
do {				\
__PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
if (!(condition)) {		\
[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd \
object:self file:[NSString stringWithUTF8String:__FILE__] \
lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
}				\
__PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
} while(0)
#endif

#if !defined(_NSCAssertBody)
#define NSCAssert(condition, desc, ...) \
do {				\
__PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
if (!(condition)) {		\
[[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__] \
lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
}				\
__PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
} while(0)
#endif

#endif
