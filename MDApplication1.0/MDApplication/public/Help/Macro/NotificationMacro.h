//
//  NotificationMacro.h
//  NQYoungCloud
//
//  Created by libo on 14-6-13.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#ifndef NQYoungCloud_NotificationMacro_h
#define NQYoungCloud_NotificationMacro_h

//点击读经界面的讨论数字按钮 跳转至此节的查经讨论详情
static NSString *showDiscussDetailsWithModel = @"showDiscussDetailsWithModel";

//点击最新好友更新数量 跳转到最新好友评论列表页
static NSString *showNewDiscuss = @"showNewDiscuss";

//读经界面跳转到某一章
static NSString *showBibleAtChapter = @"showBibleAtChapter";

//通知隐藏其他点赞按钮
static NSString *hideCommentNotification = @"hideCommentNotification";


//分享经文
static NSString *shareBible = @"shareBible";
//static NSString *autoSendBile = @"autoSendBile"; //分享后自动发送经文

//点击分享经文 跳转至读经界面
static NSString *showReadingPageAtBible  = @"showReadingPageAtBible";

//点击好友评论，跳转至好友信息界面
static NSString *AMShowFriendUserInfo = @"AMShowFriendUserInfo";

//评论或点赞后刷新查经讨论
static NSString *AMRefreshDiscuss = @"AMRefreshDiscuss";

//切换前后台刷新茶经讨论小红点
static NSString *AMRefreshNEWDiscussNotification = @"AMRefreshNEWDiscussNotification";

//用户退出
static NSString *AMUserLogoutNotification = @"AMUserLogoutNotification";



#endif



