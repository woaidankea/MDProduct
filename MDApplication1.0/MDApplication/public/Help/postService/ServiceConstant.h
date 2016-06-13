//
//  ServiceConstant.h
//  Medicalmmt
//
//  Created by gulei on 16/2/23.
//  Copyright © 2016年 gulei. All rights reserved.
//

#ifndef MMTService_HttpConstant_h
#define MMTService_HttpConstant_h

#ifdef kServerPre

//1、接口地址
#define kServerUrl   @"http://60.173.8.147/tdapi/"
//密码重置接口
#define KForgetUrl  @"http://host:port/"

#define kTransferKey @"&jk!@#$%^&td"
//企业设备图片下载接口
#define kEquipImageDownloadUrl @"http://mmt.oztechgroup.com:80/api/equipment/photo"
//下载企业用户或工程师头像
#define kUserAvatarDownloadUrl @"http://mmt.oztechgroup.com:80/api/user/avatar?id="
#endif

#ifdef kServerSit

//1、接口地址
#define kServerUrl  @"http://host:port/"

#define kTransferKey @"ead5de99e3dfe933ef56bd2ff6e08886"

#endif

#define kSignInUrl      @"api/user/sign_in"

#define KForgettwoUrl   @"api/user/reset_pwd"

#define kSignUpUrl      @"api/user/sign_up"

#define kRefreshToken   @"api/user/refresh_token"

#define kEquipmentTypeURL  @"api/general/equipment_types"

#define kEquipmentBrandURL @"api/general/equipment_brands"

#define kEquipmentModelURL @"api/general/equipment_models"

#define kUserOrder      @"api/user/orders"

#define kDepartment     @"api/general/departments"

#define kOrderCreate    @"api/order/create"

#define kJobTitles      @"api/general/jobtitles"

#define kUserProfile    @"api/user/profile"

#define kSetAvatar      @"api/user/set_avatar"

#define kUserSearch     @"api/user/search"

#define kSendCode       @"api/user/send_code"
//查询企业设备列表
#define kEquipmentList  @"api/equipment/of_corp"
//维修单设备故障照片列表
#define kOrderPhotoList @"api/order/photo_urls"
//设备照片列表
#define KEquipmentPhotoList @"api/equipment/photo_urls"


#define kAddEquipment   @"api/equipment/add"

#define kUpdateEquipment @"api/equipment/update"

#define kGetEquipmentDeatail @"api/equipment/details"

#define kDispatchOrder  @"api/order/set_engineer"

#define kOrderUpdate    @"api/order/update"

//广告
#define kAdList         @"api/news/adverts"

#define kRelatedUser    @"api/user/related_users"

#define kSearchChatroom @"api/chatroom/search"

#define kGetProfile @"api/user/profilebyid"

#define kGetUid @"api/user/getuid"

//糖豆2.0
#define kUpdataProfile @"Api/User/profilesaved"
#define kappTab @"Api/Column/appcol"
#define kArticleClass  @"Api/Column/colclass"
#define kMyPageInfo @"Api/Column/pageminfo"
#define kSendTicket @"Api/User/subticket"
#define kStartAd @"Api/Ad/startad"


#endif