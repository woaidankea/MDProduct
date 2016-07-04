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
#import "UIColor+HexStringToColor.h"
#import "LoginCodeRequest.h"
#import "OtherLoginRequest.h"
#import "UtilsMacro.h"
#import "MDUserInfoModel.h"
#import "AppDelegate.h"
#import "TDDeviceLoginCheckRequest.h"
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
static const void *countTimerKey = &countTimerKey;
static const void *getSecurityBtnKey = &getSecurityBtnKey;
static const void *passwordKey = &passwordKey;
@implementation UIWindow (UIWindow_SecondConfirm)





@dynamic windowUv;
@dynamic codeField;
@dynamic codeImageView;
@dynamic countTimer;
@dynamic getSecurityBtn;
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

- (NSTimer *)countTimer {
    return objc_getAssociatedObject(self, countTimerKey);
}
- (void)setCountTimer:(NSTimer *)countTimer{
    objc_setAssociatedObject(self, countTimerKey, countTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)getSecurityBtn {
    return objc_getAssociatedObject(self, getSecurityBtnKey);
}
- (void)setGetSecurityBtn:(UIButton *)getSecurityBtn{
    objc_setAssociatedObject(self, getSecurityBtnKey, getSecurityBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)password {
    return objc_getAssociatedObject(self, passwordKey);
}

- (void)setPassword:(NSString *)password {
    objc_setAssociatedObject(self, passwordKey, password, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

int  _countTimerNumber = 0;
int disabledTime = 0;
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
   
    self.codeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100*ratio, 190 * ratio, 120 * ratio, 25 * ratio)];
   
    
    [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:nil options:SDWebImageRefreshCached];
    [self.windowUv addSubview: self.codeImageView];
    
    UIButton* refresh = [[UIButton alloc] initWithFrame:CGRectMake(0 * ratio, 230 * ratio, 320 * ratio, 30 * ratio)];
    
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButton)];
    
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    
    [refresh setTitleColor:UIColorFromRGB(0x82befb) forState:UIControlStateNormal];
    [refresh setTitle:@"看不清,换一张" forState:UIControlStateNormal];
//    [refresh addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:refresh];

    
    
    
    UIButton* sure = [[UIButton alloc] initWithFrame:CGRectMake(100 * ratio, 270 * ratio, 120 * ratio, 30 * ratio)];
   
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButton)];
    
    

    [sure setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [sure setTitle:@"确认提交" forState:UIControlStateNormal];
    [sure addGestureRecognizer:tapGesture];
    sure.layer.borderWidth = 1;
    sure.backgroundColor = UIColorFromRGB(0x47A8ED);
    sure.layer.borderColor = UIColorFromRGB(0x82befb).CGColor;
    [self.windowUv addSubview:sure];
    
    
    [self addSubview:self.windowUv];
    
    
}


- (void)initConfirmWindow:(NSString *) username password:(NSString *)password withType:(NSString *)type{
    
    CGFloat ratio = CGRectGetWidth(self.frame)/320;
    self.type = type;
    self.phone  = username;
    self.password  = password;
//    self.imgUrl = imgUrl;
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
    
    label.text          = @"请输入验证码";
    //    label.tag           = 12;
    //    label.hidden        = YES;
    [self.windowUv addSubview: label];
    
    self.codeField = [[UITextField alloc]initWithFrame:CGRectMake(100*ratio, 157 * ratio, 120 * ratio, 25 * ratio)];
    [self.codeField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.windowUv addSubview: self.codeField];
    
//    self.codeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100*ratio, 220 * ratio, 120 * ratio, 45 * ratio)];
//    
//    
//    [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:nil options:SDWebImageRefreshCached];
//    [self.windowUv addSubview: self.codeImageView];
    
    self.getSecurityBtn = [[UIButton alloc] initWithFrame:CGRectMake(100 * ratio, 270 * ratio, 120 * ratio, 30 * ratio)];
    
    //    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButton)];
    
    [self.getSecurityBtn addTarget:self action:@selector(getSecurityCode:) forControlEvents:UIControlEventTouchUpInside];
//        [self.getSecurityBtn setBackgroundImage:[UIImage imageNamed:@"getting"] forState:UIControlStateNormal];
    [self.getSecurityBtn setTitleColor:UIColorFromRGB(0x82befb) forState:UIControlStateNormal];
    [self.getSecurityBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    //    [refresh addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:self.getSecurityBtn];
    
    
    
    
    UIButton* sure = [[UIButton alloc] initWithFrame:CGRectMake(0 * ratio, 340 * ratio, 320 * ratio, 30 * ratio)];
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButton)];
    
    
    
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure setTitle:@"确认提交" forState:UIControlStateNormal];
    [sure addGestureRecognizer:tapGesture];
    [self.windowUv addSubview:sure];
    
    
    [self addSubview:self.windowUv];
    
    
}


//计时器
- (void)timerFireMethod{
    if (_countTimerNumber>0) {
        [self.getSecurityBtn setUserInteractionEnabled:NO];
        //        [_getSecurityBtn setTitleColor:[UIColor ColorWithHexString:MD_Gray_Color] forState:UIControlStateNormal];
        //        _getSecurityBtn.backgroundColor = [UIColor ColorWithHexString:MD_Gray_Color];
        [self.getSecurityBtn setBackgroundImage:[UIImage imageNamed:@"getting"] forState:UIControlStateNormal];
        [self.getSecurityBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld)",(long)_countTimerNumber] forState:UIControlStateNormal];
    }else if (_countTimerNumber<0) {
        [self.countTimer invalidate];
        [self.getSecurityBtn setUserInteractionEnabled:YES];
        self.getSecurityBtn.enabled=YES;
        //        [_getSecurityBtn setTitleColor:[UIColor ColorWithHexString:AM_COLOR_GREEN] forState:UIControlStateNormal];
//        self.getSecurityBtn.backgroundColor = [UIColor ColorWithHexString:MD_ButtonPink_Color];
        [self.getSecurityBtn setBackgroundImage:[UIImage imageNamed:@"yanzhengma"] forState:UIControlStateNormal];
        [self.getSecurityBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    _countTimerNumber --;
    
    
    
}






- (void)getSecurityCode:(id)sender {
    AM_CheckPhone checkPhone =[AMTools checkPhoneNumber:self.phone];
    if (checkPhone==AM_Phone_IsRight) {
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        
        
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
            WS(weakSelf);
        
        LoginCodeRequest *request = [[LoginCodeRequest alloc]initRegCodeWithPhone:self.phone success:^(AMBaseRequest *request) {
            
            if(((NSString *)[request.responseObject objectForKey:@"codeurl"]).length != 0){
                [[UIApplication sharedApplication].keyWindow initConfirmWindow:[request.responseObject objectForKey:@"codeurl"] Phone:weakSelf.self.phone withType:@"0"];
                
                
                
            }else {
               
                AMLog(@"验证码==============%@",request.responseObject);
                
                //            receiveCode = [NSString stringWithFormat:@"%@",[request.responseObject objectForKey:@"phonecode"]];
                NSDate *curentTime =[NSDate date];
                disabledTime =curentTime.timeIntervalSince1970+60;
                
                
//                [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
                //获取验证码倒计时
                _countTimerNumber = 60;
                self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
                
                [AMTools showHUDtoWindow:nil title:@"验证码已发送请注意查收" delay:2];
            }
            
            
        } failure:^(AMBaseRequest *request) {
          
   
            
            
        }];
        
        
        
        [request start];            //获取验证码
        
        
    }else{
        NSString *phoneMessage =[AMTools getCheckPhoneMessage:checkPhone];
        [AMTools showAlertViewWithTitle:phoneMessage
                      cancelButtonTitle:@"确定"];
    }
    
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

    }else if([self.type isEqualToString:@"2"]){
        
        if (self.codeField.text.length == 0) {
            [AMTools showAlertViewWithTitle:@"验证码不能为空" cancelButtonTitle:@"确定"];
            return;
        }
     TDDeviceLoginCheckRequest *req  =[[TDDeviceLoginCheckRequest alloc]initSecondCheckWithphone:self.phone    imgcode:self.codeField.text success:^(AMBaseRequest *request) {
        
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

     
        
        
          } else{
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

- (void)saveLastLoginUsername
{
    NSString *username = self.phone;
    
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
        
        [ud synchronize];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self sureClick];
}
- (void)sureClick{
    
   
    
    
    self.windowUv.hidden = YES;
    self.windowUv        = nil;

}



@end
