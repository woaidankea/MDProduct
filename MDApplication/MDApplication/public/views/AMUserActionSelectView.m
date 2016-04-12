//
//  AMSelectPictureView.m
//  AMen
//
//  Created by gaoxinfei on 15/8/25.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMUserActionSelectView.h"
#import "AMColorAndFontConfig.h"
#import "UIColor+HexStringToColor.h"



@interface AMUserActionSelectView (){
}

@end

@implementation AMUserActionSelectView

-(void)actionSelectAlertMethod:(id)sender{
    UIButton *btn =(UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSelectAlertMethod:alertType:)]) {
        [self.delegate actionSelectAlertMethod:btn.tag alertType:self.alertType];
    }
}

- (id)initWithAlertMessageArray:(NSArray *)messageArray :(AM_AlertType)alertType{
    NSInteger messageCount =messageArray.count;
    self  = [super initWithFrame:CGRectMake(0, FRAME_HEIGHT-50*AM_HEIGHT_RATIO*messageCount, FRAME_WIDTH, 50*AM_HEIGHT_RATIO*messageCount)];
    if (self) {
        self.alertType=alertType;
        [self createSubView:messageArray];
    }
    return self;
}

-(void)createSubView:(NSArray *)messageArray{
    self.backgroundColor=[UIColor whiteColor];
    for (NSInteger i=0; i < messageArray.count; i++) {
        NSString *btnTitle =[messageArray objectAtIndex:i];
        UIButton *selectBtn =[[UIButton alloc]initWithFrame:CGRectMake(60*AM_WIDTH_RATIO, i*50*AM_HEIGHT_RATIO, FRAME_WIDTH-120*AM_WIDTH_RATIO, 45*AM_HEIGHT_RATIO)];
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(12*AM_WIDTH_RATIO, selectBtn.frame.origin.y+50*AM_HEIGHT_RATIO, FRAME_WIDTH-24*AM_WIDTH_RATIO, 1*AM_HEIGHT_RATIO)];
        line.backgroundColor =[UIColor ColorWithHexString:AM_COLOR_GREEN];
        selectBtn.tag =i;
        [selectBtn setTitle:btnTitle forState:UIControlStateNormal];
        [selectBtn setTitleColor:[UIColor ColorWithHexString:AM_COLOR_GREEN] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(actionSelectAlertMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBtn];
        [self addSubview:line];
    }
}

@end
