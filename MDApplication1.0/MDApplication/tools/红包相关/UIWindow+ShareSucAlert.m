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
#import "DXShareTools.h"
#import "AppDelegate.h"
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
    UIImageView* backGround = [[UIImageView alloc]initWithFrame:CGRectMake((320-549/2)/2 * ratio , (200) * ratio, 275 * ratio, 174 * ratio)];
    backGround.image        = [UIImage imageNamed:@"tanchu"];
    backGround.tag          = 10;
    [self.windowUv addSubview:backGround];
  
    
     self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 235 * ratio, 320 * ratio,25 * ratio)];
     self.label.font = [UIFont systemFontOfSize:30];
     self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor     = UIColorFromRGB(0xfaad2f);
     self.label.numberOfLines = 0;
    
     self.label.text          = @"恭喜您";
//    label.tag           = 12;
//    label.hidden        = YES;
    [self.windowUv addSubview: self.label];
    
    
    
    UILabel *sublabel = [[UILabel alloc]initWithFrame:CGRectMake(50 * ratio, 270 * ratio, 220 * ratio, 40 * ratio)];
    sublabel.font = [UIFont systemFontOfSize:18];
    sublabel.textAlignment = NSTextAlignmentCenter;
    sublabel.textColor     = RGBACOLOR( 219 , 29 , 56 , 1);
    sublabel.numberOfLines = 0;
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.rewardInfoForRedPacket.rewardContent]];
    NSString *number = [NSString stringWithFormat:@"%.2f",self.rewardInfoForRedPacket.money];
    //富文本样式
//    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
//                              value:UIColorFromRGB(0xb2b2b2)
//                              range:NSMakeRange(0, 6)];
//    
//    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
//                              value:UIColorFromRGB(0xfaad2f)
//                              range:NSMakeRange(6, number.length)];
//    
//    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
//                              value:UIColorFromRGB(0xb2b2b2)
//                              range:NSMakeRange(aAttributedString.length-1, 1)];
//    
//    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
//                              value:[UIFont systemFontOfSize:19]
//                              range:NSMakeRange(0, 6)];
//    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
//                              value:[UIFont systemFontOfSize:18]
//                              range:NSMakeRange(6, number.length)];
//    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
//                              value:[UIFont systemFontOfSize:19]
//                              range:NSMakeRange(aAttributedString.length-1, 1)];
    
    sublabel.attributedText = aAttributedString;
    
    
    //    label.text          = [NSString stringWithFormat:@"签到抽奖 恭喜你 抽中%.2f元",self.rewardInfoForRedPacket.money];
    //    label.tag           = 12;
    [self.windowUv addSubview:sublabel];
    
    
//     sublabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * ratio,(270 + 20)* ratio, 320 * ratio, 17 * ratio)];
//    sublabel.font = [UIFont systemFontOfSize:19];
//    sublabel.textAlignment = NSTextAlignmentCenter;
//    sublabel.textColor     = UIColorFromRGB(0xb2b2b2);
//    sublabel.text = @"奖金已存入账户";
    
//     [self.windowUv addSubview:sublabel];

    

    
    
//     *arrow =( UIImageView *) [self.view viewWithTag:101];
//    [UIView beginAnimations:@"ShowArrow" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:2.0];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(DidStop)];
//    // Make the animatable changes.
//    self.label.alpha = 0.0;
//    // Commit the changes and perform the animation.
//    [UIView commitAnimations];
//    
    
    UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(0 * ratio, 340 * ratio, 320 * ratio, 30 * ratio)];
    //    cancel.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClicked)];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel setTitle:@"立即分享" forState:UIControlStateNormal];
    [cancel addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:cancel];


    [self addSubview:self.windowUv];
    
    
}



static int i = 0;
- (void)makeSnow
{
    self.titleViewSmall.hidden = !self.titleViewSmall.hidden;
    self.titleViewBig.hidden = !self.titleViewBig.hidden;

    
}
- (void)cancelButtonClicked{
    self.windowUv.hidden = YES;
    self.windowUv        = nil;
    ShareModel *sharemodel = [[ShareModel alloc]init];
    
    sharemodel.title = @"这个应用好玩,推荐大家下载。好多人都在玩!";
    
    
    sharemodel.desc = @"利用闲余时间,随便点点就可以轻松拿零花";
    
    sharemodel.imageArray = @[[UIImage imageNamed:@"Icon"]];
    
    NSArray *shareAry = @[@{@"image":@"share_qq",@"title":@"QQ"},
                          @{@"image":@"share_wx_timeline",@"title":@"朋友圈"},
                          @{@"image":@"share_wx",@"title":@"微信"},
                          @{@"image":@"share_weibo",@"title":@"新浪微博"},
                          @{@"image":@"share_qzone",@"title":@"QQ空间"}];
    
    
    [DXShareTools shareToolsInstance].isArticle = NO;
    [DXShareTools shareToolsInstance].isApprentice = NO;
    [DXShareTools shareToolsInstance].isSign = YES;
    
    
    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel  viewController:((AppDelegate *)[UIApplication sharedApplication].delegate).rootController];
}
- (void)DidStop{
    self.windowUv.hidden = YES;
    self.windowUv        = nil;
        [self.timer invalidate];
}
@end
