//
//  UIWindow+ShareSucAlert.h
//  MDApplication
//
//  Created by jieku on 16/4/20.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardInfo.h"
@interface UIWindow (ShareSucAlert)
@property (nonatomic, strong) UIView     *windowUv;
@property (nonatomic, strong)NSMutableArray *imagesArray;
@property (nonatomic, strong) NSTimer  *timer;
@property (nonatomic, strong) RewardInfo *rewardInfoForRedPacket;
@property (nonatomic,strong)UIImageView *titleViewSmall;
@property (nonatomic,strong)UIImageView *titleViewBig;
@property (nonatomic,strong)UILabel  *label;


/**
 *  初始化并直接显示红包金额
 *
 *  @param rewardInfo 红包信息
 */
- (void)initRedPacketWindow1:(RewardInfo*)rewardInfo;

/**
 *  初始化并显示红包 需要打开操作
 *
 *  @param rewardInfo 红包信息
 */
//- (void)initRedPacketWindowNeedOpen:(RewardInfo*)rewardInfo;

@end
