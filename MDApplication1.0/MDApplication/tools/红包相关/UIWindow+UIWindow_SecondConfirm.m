//
//  UIWindow+UIWindow_SecondConfirm.m
//  MDApplication
//
//  Created by jieku on 16/6/3.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "UIWindow+UIWindow_SecondConfirm.h"


#import <objc/runtime.h>
#import "MDRedPacketRequest.h"
#import "MDRedPacketModel.h"
#import "AMTools.h"
#import "myImageView.h"
#import "UConstants.h"
#import "TDSecondCheckRequest.h"
#import "TDCheckforpwdcodeRequest.h"
#import "UIImageView+WebCache.h"

#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SNOW_IMAGENAME         @"5"

#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 15
#define PLUS_HEIGHT            Main_Screen_Height/25

static const void *WindowUvKey = &WindowUvKey;
static const void *phoneKey = &phoneKey;
static const void *imgUrlKey = &imgUrlKey;
static const void *codeFieldKey = &codeFieldKey;
static const void *codeImageViewKey = &codeImageViewKey;
static const void *typeKey = &typeKey;

@implementation UIWindow (UIWindow_SecondConfirm)





@dynamic windowUv;
@dynamic codeField;
@dynamic codeImageView;
- (NSString *)type {
    return objc_getAssociatedObject(self, typeKey);
}

- (void)setType:(NSString *)type {
    objc_setAssociatedObject(self, typeKey, type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*)windowUv {
    return objc_getAssociatedObject(self, WindowUvKey);
}

- (void)setWindowUv:(UIWindow *)windowUv {
    objc_setAssociatedObject(self, WindowUvKey, windowUv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)phone {
    return objc_getAssociatedObject(self, phoneKey);
}

- (void)setPhone:(NSString *)phone {
    objc_setAssociatedObject(self, phoneKey, phone, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)imgUrl {
    return objc_getAssociatedObject(self, imgUrlKey);
}

- (void)setImgUrl:(NSString *)imgUrl {
    objc_setAssociatedObject(self, imgUrlKey, imgUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)codeField {
    return objc_getAssociatedObject(self, codeFieldKey);
}
- (void)setCodeField:(UITextField *)codeField{
    objc_setAssociatedObject(self, codeFieldKey, codeField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)codeImageView {
    return objc_getAssociatedObject(self, codeImageViewKey);
}
- (void)setCodeImageView:(UIImageView *)codeImageView{
    objc_setAssociatedObject(self, codeImageViewKey, codeImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)initConfirmWindow:(NSString *) imgUrl Phone:(NSString *)phone withType:(NSString *)type{
    
    CGFloat ratio = CGRectGetWidth(self.frame)/320;
    self.type = type;
    self.phone  = phone;
    self.imgUrl = imgUrl;
    self.windowUv = [[UIView alloc] initWithFrame:self.frame];
    [self.windowUv setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    UIImageView* backGround = [[UIImageView alloc]initWithFrame:CGRectMake((320-265)/2 * ratio , (95) * ratio, 265 * ratio, 215 * ratio)];
//    backGround.image        = [UIImage imageNamed:@"tanchu"];
    backGround.backgroundColor = [UIColor whiteColor];
    backGround.tag          = 10;
    backGround.clipsToBounds = YES;
    backGround.layer.masksToBounds = YES;
    backGround.layer.cornerRadius = 6;
    [self.windowUv addSubview:backGround];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 120 * ratio, 320 * ratio,20 * ratio)];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = UIColorFromRGB(0x82befb);
    label.numberOfLines = 0;
    
    label.text          = @"请输入识别码";
    //    label.tag           = 12;
    //    label.hidden        = YES;
    [self.windowUv addSubview: label];
    
    self.codeField = [[UITextField alloc]initWithFrame:CGRectMake(100*ratio, 157 * ratio, 120 * ratio, 25 * ratio)];
    [self.codeField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.windowUv addSubview: self.codeField];
   
    self.codeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100*ratio, 220 * ratio, 120 * ratio, 45 * ratio)];
   
    
    [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:nil options:SDWebImageRefreshCached];
    [self.windowUv addSubview: self.codeImageView];
    
    UIButton* refresh = [[UIButton alloc] initWithFrame:CGRectMake(0 * ratio, 270 * ratio, 320 * ratio, 30 * ratio)];
    
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButton)];
    
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    
    [refresh setTitleColor:UIColorFromRGB(0x82befb) forState:UIControlStateNormal];
    [refresh setTitle:@"看不清,换一张" forState:UIControlStateNormal];
//    [refresh addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:refresh];

    
    
    
    UIButton* sure = [[UIButton alloc] initWithFrame:CGRectMake(0 * ratio, 340 * ratio, 320 * ratio, 30 * ratio)];
   
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButton)];
    
    

    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure setTitle:@"确认提交" forState:UIControlStateNormal];
    [sure addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:sure];
    
    
    [self addSubview:self.windowUv];
    
    
}
- (void)refresh{
  [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:nil options:SDWebImageRefreshCached];
}

- (void)cancelButton{
    
    WS(ws);
    if([self.type isEqualToString:@"0"]){
        TDSecondCheckRequest *req  =[[TDSecondCheckRequest alloc]initSecondCheckWithphone:self.phone    imgcode:self.codeField.text success:^(AMBaseRequest *request) {
            
            
            if(((NSString *)[request.responseObject objectForKey:@"codeurl"]).length != 0){
                [AMTools showHUDtoWindow:nil title:@"验证码不正确" delay:2];
               [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:[request.responseObject objectForKey:@"codeurl"]] placeholderImage:nil options:SDWebImageRefreshCached];
            }else {
                
                ws.windowUv.hidden = YES;
                ws.windowUv        = nil;
            
                [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
            }

            
        
            
        } failure:^(AMBaseRequest *request) {
            
        }];
        [req start];

    }else{
        TDCheckforpwdcodeRequest *req  =[[TDCheckforpwdcodeRequest alloc]initSecondCheckWithphone:self.phone    imgcode:self.codeField.text success:^(AMBaseRequest *request) {
            if(((NSString *)[request.responseObject objectForKey:@"codeurl"]).length != 0){
                [AMTools showHUDtoWindow:nil title:@"验证码不正确" delay:2];
                [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:[request.responseObject objectForKey:@"codeurl"]] placeholderImage:nil options:SDWebImageRefreshCached];
            }else {
                
                ws.windowUv.hidden = YES;
                ws.windowUv        = nil;
                
                [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
            }
            
        } failure:^(AMBaseRequest *request) {
            
        }];
        [req start];

    }
    
    
    
}
- (void)sureClick{
    
   
    
    
//    self.windowUv.hidden = YES;
//    self.windowUv        = nil;
}



@end
