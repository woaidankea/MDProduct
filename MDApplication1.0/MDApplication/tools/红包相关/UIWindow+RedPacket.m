//
//  UIViewController+RedPacket.m
//  RedPacketDemo
//
//  Created by lll on 16/3/1.
//  Copyright © 2016年 llliu. All rights reserved.
//

#import "UIWindow+RedPacket.h"
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
@implementation UIWindow (RedPacket)

@dynamic windowUv;
@dynamic rewardInfoForRedPacket;
@dynamic imagesArray;
@dynamic timer;
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

#pragma 
- (void)initRedPacketWindowNeedOpen:(RewardInfo*)rewardInfo{
    if (rewardInfo.rewardStatus == 3) {
        NSLog(@"红包已领完");
        //TODO 自定义提示方式
        return;
    }
    if (rewardInfo.rewardStatus == 1 || rewardInfo.rewardStatus == 2) {
        return;
    }
    CGFloat ratio = CGRectGetWidth(self.frame)/320;
    self.rewardInfoForRedPacket = rewardInfo;
    self.windowUv = [[UIView alloc] initWithFrame:self.frame];
    [self.windowUv setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    UIImageView* backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0 , (80 + 85/2) * ratio, 320 * ratio, 631/2 * ratio)];
    backGround.image        = [UIImage imageNamed:@"img_reward_packet_open"];
    backGround.tag          = 10;
    [self.windowUv addSubview:backGround];
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(110 * ratio, 150 * ratio, 110 * ratio, 20 * ratio)];
    label.font          = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = RGBACOLOR( 219 , 29 , 56 , 1);
    label.text          = rewardInfo.rewardName;
    label.tag           = 11;

//    [self.windowUv addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(90 * ratio, 275 * ratio, 110 * ratio, 20 * ratio)];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = RGBACOLOR( 219 , 29 , 56 , 1);
    label.text          = [NSString stringWithFormat:@"%.2f元红包",self.rewardInfoForRedPacket.money];
    label.tag           = 12;
    [self.windowUv addSubview:label];
    
    label               = [[UILabel alloc]initWithFrame:CGRectMake(80 * ratio, 275 * ratio, 170 * ratio, 70 * ratio)];
    label.font          = [UIFont systemFontOfSize:17];
    label.textColor     = RGBACOLOR( 252 , 240 , 107 , 1);
    label.text          = self.rewardInfoForRedPacket.rewardContent;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 3;
    label.tag           = 14;
//    [self.windowUv addSubview:label];
    
    UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(260 * ratio, 110 * ratio, 40 * ratio, 40 * ratio)];
//    cancel.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClicked:)];
    [cancel addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:cancel];
    
    UIButton* next = [[UIButton alloc] initWithFrame:CGRectMake(75 * ratio, 360 * ratio, 180 * ratio, 30 * ratio)];
    [next setBackgroundColor:RGBACOLOR( 252 , 240 , 107 , 1)];
    [next.layer setCornerRadius:next.frame.size.height/8];
    [next.layer setMasksToBounds:YES];
    NSString* title = @"已领取过红包";
    if (self.rewardInfoForRedPacket.rewardStatus == 1) {
        next.enabled = NO;
    } else {
        title = @"立即分享";
    }
    [next setTitle:title forState:UIControlStateNormal];

    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareButtonPress:)];
    [next setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    next.tag = 13;
    [next addGestureRecognizer:tapGesture];
    
//    [self.windowUv addSubview:next];
    [self addSubview:self.windowUv];
    
    
}


- (void)initRedPacketWindow:(RewardInfo*)rewardInfo {
    if (rewardInfo.rewardStatus == 3) {
        NSLog(@"红包已领完");
        //TODO 自定义提示方式
        return;
    }
    if (rewardInfo.rewardStatus == 1 || rewardInfo.rewardStatus == 2) {
        return;
    }
    CGFloat ratio = CGRectGetWidth(self.frame)/320;
    self.rewardInfoForRedPacket = rewardInfo;
    self.windowUv = [[UIView alloc] initWithFrame:self.frame];
    [self.windowUv setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    UIImageView* backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0 , (80 + 85/2) * ratio, 320 * ratio, 631/2 * ratio)];
    backGround.image        = [UIImage imageNamed:@"img_reward_packet_closed"];
    backGround.tag          = 10;
    [self.windowUv addSubview:backGround];
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(110 * ratio, 150 * ratio, 110 * ratio, 20 * ratio)];
    label.font          = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = RGBACOLOR( 219 , 29 , 56 , 1);
    label.text          = @"恭喜获得";
    label.tag           = 11;
    label.hidden        = YES;
//    [self.windowUv addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(102 * ratio, 290 * ratio, 110 * ratio, 20 * ratio)];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = RGBACOLOR( 219 , 29 , 56 , 1);
    label.text          = [NSString stringWithFormat:@"%.2f元红包",self.rewardInfoForRedPacket.money];
    label.tag           = 12;
    label.hidden        = YES;
    [self.windowUv addSubview:label];
    
    label               = [[UILabel alloc]initWithFrame:CGRectMake(80 * ratio, 275 * ratio, 170 * ratio, 70 * ratio)];
    label.font          = [UIFont systemFontOfSize:17];
    label.textColor     = RGBACOLOR( 252 , 240 , 107 , 1);
    label.text          = self.rewardInfoForRedPacket.rewardName;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 3;
    label.tag           = 14;
//    [self.windowUv addSubview:label];
    
    UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(260 * ratio, 110 * ratio, 40 * ratio, 40 * ratio)];
//    cancel.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClicked:)];
    [cancel addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:cancel];
    
    UIButton* next = [[UIButton alloc] initWithFrame:CGRectMake(75 * ratio, 300 * ratio, 180 * ratio, 100 * ratio)];
    [next setBackgroundColor:[UIColor clearColor]];
//    [next.layer setCornerRadius:next.frame.size.height/8];
    [next.layer setMasksToBounds:YES];
//    [next setTitle:@"打开红包" forState:UIControlStateNormal];
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtonClicked:)];
    [next setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    next.tag = 13;
    [next addGestureRecognizer:tapGesture];
    
    
    
    [self.windowUv addSubview:next];
    [self addSubview:self.windowUv];
    
    // Do any additional setup after loading the view, typically from a nib.
   self.imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 500; ++ i) {
        myImageView *imageView = [[myImageView alloc] initWithImage:IMAGENAMED(SNOW_IMAGENAME)];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -45, x, x+10);
        imageView.alpha = IMAGE_ALPHA;
        imageView.indexPath=i;
//        [_array addObject:imageView.layer];
        [ self.imagesArray addObject:imageView];
        [self addSubview:imageView];
        [ self.imagesArray addObject:imageView];
    }
  

}



static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([self.imagesArray count] > 0) {
        UIImageView *imageView = [self.imagesArray objectAtIndex:0];
        imageView.tag = i;
        [self.imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
    
}

- (void)snowFall:(UIImageView *)aImageView
{
    
    //CGAffineTransform transform=         CGAffineTransformMakeRotation(M_PI/2);
    [UIView beginAnimations:[NSString stringWithFormat:@"%li",(long)aImageView.tag] context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, Main_Screen_Height, aImageView.frame.size.width, aImageView.frame.size.height);
    
    //aImageView.transform=transform;
    
    //NSLog(@"%@",aImageView);
    [UIView commitAnimations];
}



- (void)nextButtonClicked:(id)sender {
//    MDRedPacketModel *model  =  request.responseObject;
    

    
    MDRedPacketRequest *request = [[MDRedPacketRequest alloc]initWithSuccessCallback:^(AMBaseRequest *request) {
//        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
        MDRedPacketModel *model  =  request.responseObject;
        UIImageView* background = [self.windowUv viewWithTag:10];
        background.image        = [UIImage imageNamed:@"img_reward_packet_open"];
        UILabel* lable          = [self.windowUv viewWithTag:11];
        lable.hidden            = NO;
        lable                   = [self.windowUv viewWithTag:12];
        lable.text =[NSString stringWithFormat:@"%.2f元红包",[model.money floatValue]];
        lable.hidden            = NO;
        UIButton* button        = [self.windowUv viewWithTag:13];
        NSString* title = @"已领取过红包";
        if (self.rewardInfoForRedPacket.rewardStatus == 1) {
            button.enabled = NO;
        } else {
            title = @"立即分享";
        }
        button.titleLabel.text = title;
        [button setTitle:title forState:UIControlStateNormal];
        button.hidden =  YES;
        
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareButtonPress:)];
        [button addGestureRecognizer:tapGesture];
        
        lable        = [self.windowUv viewWithTag:14];
        lable.hidden = NO;
        lable.text   = self.rewardInfoForRedPacket.rewardContent;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MeReloadData" object:nil];
        
    } failureCallback:^(AMBaseRequest *request) {
        NSString *confirmTitle=@"确定";
              
        if (request.response.errorMessage) {
            [AMTools showAlertViewWithTitle:request.response.errorMessage cancelButtonTitle:confirmTitle];
           
        }
        
               
        
    }];
      
    
    [request start];
    
    
    
    
 
}

- (void)shareButtonPress:(id)sender {
    UIButton* button = sender;
    button.enabled   = NO;
    //TODO 自定义分享方式
}

- (void)cancelButtonClicked:(id)sender {
    self.windowUv.hidden = YES;
    self.windowUv        = nil;
//    [self.timer invalidate];
}
@end
