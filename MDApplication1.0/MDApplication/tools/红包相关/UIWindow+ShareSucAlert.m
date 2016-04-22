//
//  UIWindow+ShareSucAlert.m
//  MDApplication
//
//  Created by jieku on 16/4/20.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "UIWindow+ShareSucAlert.h"


#import <objc/runtime.h>
#import "MDRedPacketRequest.h"
#import "MDRedPacketModel.h"
#import "AMTools.h"
#import "myImageView.h"
#import "UConstants.h"
#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SNOW_IMAGENAME         @"5"

#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 15
#define PLUS_HEIGHT            Main_Screen_Height/25
static const void *WindowUvKey = &WindowUvKey;
static const void *RewardInfoKey = &RewardInfoKey;
static const void *MutableArray =  &MutableArray;
static const void *Timer =  &Timer;
static const void *TitleViewSmallKey = &TitleViewSmallKey;
static const void *TitleViewBigKey =  &TitleViewBigKey;
static const void *LabelKey =  &LabelKey;
@implementation UIWindow (ShareSucAlert)

@dynamic windowUv;
@dynamic rewardInfoForRedPacket;
@dynamic imagesArray;
@dynamic timer;
@dynamic titleViewSmall;
@dynamic titleViewBig;
@dynamic label;
- (UIView*)windowUv {
    return objc_getAssociatedObject(self, WindowUvKey);
}

- (void)setWindowUv:(UIWindow *)windowUv {
    objc_setAssociatedObject(self, WindowUvKey, windowUv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)imagesArray {
    return objc_getAssociatedObject(self, MutableArray);
}

- (void)setImagesArray:(NSMutableArray  *)imagesArray {
    objc_setAssociatedObject(self, MutableArray, imagesArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, Timer);
}

- (void)setTimer:(NSTimer  *)timer {
    objc_setAssociatedObject(self, Timer, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (RewardInfo*)rewardInfoForRedPacket {
    return objc_getAssociatedObject(self, RewardInfoKey);
}

- (void)setRewardInfoForRedPacket:(RewardInfo *)rewardInfoForRedPacket {
    objc_setAssociatedObject(self, RewardInfoKey,rewardInfoForRedPacket,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIImageView*)titleViewSmall {
    return objc_getAssociatedObject(self, TitleViewSmallKey);
}

- (void)setTitleViewSmall:(UIImageView *)titleViewSmall {
    objc_setAssociatedObject(self, TitleViewSmallKey, titleViewSmall, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView*)titleViewBig {
    return objc_getAssociatedObject(self, TitleViewBigKey);
}

- (void)setTitleViewBig:(UIImageView *)titleViewBig {
    objc_setAssociatedObject(self, TitleViewBigKey, titleViewBig, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel*)label {
    return objc_getAssociatedObject(self, LabelKey);
}

- (void)setLabel:(UIImageView *)label {
    objc_setAssociatedObject(self, LabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma
//- (void)initRedPacketWindowNeedOpen:(RewardInfo*)rewardInfo{
//    if (rewardInfo.rewardStatus == 3) {
//        NSLog(@"红包已领完");
//        //TODO 自定义提示方式
//        return;
//    }
//    if (rewardInfo.rewardStatus == 1 || rewardInfo.rewardStatus == 2) {
//        return;
//    }
//    CGFloat ratio = CGRectGetWidth(self.frame)/320;
//    self.rewardInfoForRedPacket = rewardInfo;
//    self.windowUv = [[UIView alloc] initWithFrame:self.frame];
//    [self.windowUv setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
//    UIImageView* backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0 , (80 + 85/2) * ratio, 320 * ratio, 631/2 * ratio)];
//    backGround.image        = [UIImage imageNamed:@"img_reward_packet_open"];
//    backGround.tag          = 10;
//    [self.windowUv addSubview:backGround];
//    
//    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(110 * ratio, 150 * ratio, 110 * ratio, 20 * ratio)];
//    label.font          = [UIFont boldSystemFontOfSize:14];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor     = RGBACOLOR( 219 , 29 , 56 , 1);
//    label.text          = rewardInfo.rewardName;
//    label.tag           = 11;
//    
//    //    [self.windowUv addSubview:label];
//    
//    label = [[UILabel alloc]initWithFrame:CGRectMake(90 * ratio, 275 * ratio, 110 * ratio, 20 * ratio)];
//    label.font = [UIFont boldSystemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor     = RGBACOLOR( 219 , 29 , 56 , 1);
//    label.text          = [NSString stringWithFormat:@"%.2f元红包",self.rewardInfoForRedPacket.money];
//    label.tag           = 12;
//    [self.windowUv addSubview:label];
//    
//    label               = [[UILabel alloc]initWithFrame:CGRectMake(80 * ratio, 275 * ratio, 170 * ratio, 70 * ratio)];
//    label.font          = [UIFont systemFontOfSize:17];
//    label.textColor     = RGBACOLOR( 252 , 240 , 107 , 1);
//    label.text          = self.rewardInfoForRedPacket.rewardContent;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.numberOfLines = 3;
//    label.tag           = 14;
//    //    [self.windowUv addSubview:label];
//    
//    UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(260 * ratio, 110 * ratio, 40 * ratio, 40 * ratio)];
//    //    cancel.backgroundColor = [UIColor redColor];
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClicked:)];
//    [cancel addGestureRecognizer:tapGesture];
//    [self.windowUv addSubview:cancel];
//    
//    UIButton* next = [[UIButton alloc] initWithFrame:CGRectMake(75 * ratio, 360 * ratio, 180 * ratio, 30 * ratio)];
//    [next setBackgroundColor:RGBACOLOR( 252 , 240 , 107 , 1)];
//    [next.layer setCornerRadius:next.frame.size.height/8];
//    [next.layer setMasksToBounds:YES];
//    NSString* title = @"已领取过红包";
//    if (self.rewardInfoForRedPacket.rewardStatus == 1) {
//        next.enabled = NO;
//    } else {
//        title = @"立即分享";
//    }
//    [next setTitle:title forState:UIControlStateNormal];
//    
//    
//    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareButtonPress:)];
//    [next setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    next.tag = 13;
//    [next addGestureRecognizer:tapGesture];
//    
//    //    [self.windowUv addSubview:next];
//    [self addSubview:self.windowUv];
//    
//    
//}


- (void)initRedPacketWindow1:(RewardInfo*)rewardInfo {
    if (rewardInfo.rewardStatus == 3) {
        NSLog(@"红包已领完");
        //TODO 自定义提示方式
        return;
    }
    if (rewardInfo.rewardStatus == 1 || rewardInfo.rewardStatus == 2) {
        return;
    }
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
    
    
    CGFloat ratio = CGRectGetWidth(self.frame)/320;
    self.rewardInfoForRedPacket = rewardInfo;
    self.windowUv = [[UIView alloc] initWithFrame:self.frame];
    [self.windowUv setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    UIImageView* backGround = [[UIImageView alloc]initWithFrame:CGRectMake((320-192)/2 * ratio , (80 + 85/2) * ratio, 192 * ratio, 192 * ratio)];
    backGround.image        = [UIImage imageNamed:@"earnmoney"];
    backGround.tag          = 10;
    [self.windowUv addSubview:backGround];
    
    
    
    self.titleViewSmall = [[UIImageView alloc]initWithFrame:CGRectMake((320-75)/2 * ratio , (95 + 85  /2) * ratio, 75 * ratio, 23 * ratio)];
    self.titleViewSmall.image        = [UIImage imageNamed:@"earntitlesmall"];
//    backGround.tag          = 10;
    [self.windowUv addSubview:self.titleViewSmall];
    
    self.titleViewBig = [[UIImageView alloc]initWithFrame:CGRectMake((320-85)/2 * ratio , (93 + 85  /2) * ratio, 90 * ratio, 27 * ratio)];
    self.titleViewBig.image        = [UIImage imageNamed:@"earntitlebig"];
    //    backGround.tag          = 10;
    self.titleViewBig.hidden = YES;
    [self.windowUv addSubview:self.titleViewBig];

    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(82 * ratio, 320 * ratio, 150 * ratio,80 * ratio)];
     self.label.font = [UIFont boldSystemFontOfSize:30];
     self.label.textAlignment = NSTextAlignmentCenter;
     self.label.textColor     = RGBACOLOR( 255 , 255 , 0 , 1);
     self.label.numberOfLines = 0;
    
     self.label.text          = [NSString stringWithFormat:@"分享获得\n%.2f元",self.rewardInfoForRedPacket.money];
//    label.tag           = 12;
//    label.hidden        = YES;
    [self.windowUv addSubview: self.label];
    
//     *arrow =( UIImageView *) [self.view viewWithTag:101];
    [UIView beginAnimations:@"ShowArrow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(DidStop)];
    // Make the animatable changes.
    self.label.alpha = 0.0;
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    
    
    

    [self addSubview:self.windowUv];
    
    
}



static int i = 0;
- (void)makeSnow
{
    self.titleViewSmall.hidden = !self.titleViewSmall.hidden;
    self.titleViewBig.hidden = !self.titleViewBig.hidden;

    
}

- (void)DidStop{
    self.windowUv.hidden = YES;
    self.windowUv        = nil;
        [self.timer invalidate];
}
@end
