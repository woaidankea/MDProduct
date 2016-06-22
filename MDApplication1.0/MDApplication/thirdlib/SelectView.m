//
//  SelectView.m
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "SelectView.h"
#import "AMColorAndFontConfig.h"
#import "UIColor+HexStringToColor.h"

@interface SelectView()

@property (nonatomic,weak)UIView *contentView;

@end
static CGFloat const ButtonWidth = 62;
static CGFloat const ButtonHeight = 27;
static CGFloat const contentWidth = 270;
//static CGFloat const LeftBorder = 27;

@implementation SelectView

- (instancetype)init
{
    if (self = [super init]) {
        [self initial];
   
    }
    return self;
}
- (void)awakeFromNib
{
    [self initial];
    
}
// 懒加载整个内容view
- (UIView *)contentView
{
    if (_contentView == nil) {
        
        UIView *contentView = [[UIView alloc] init];
     
        _contentView = contentView;
        [self addSubview:contentView];
        
    }
    
    return _contentView;
}


- (void)initial
{
    // 初始化标题高度
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 100, 40);
    label.text = @"选择栏目";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor =[UIColor blackColor];
    [self addSubview:label];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.hidden=YES;
    
    
    
    
    
    
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    CGRect rect = frame;
//    rect.origin.x = 0;
//    rect.origin.y = 0;
//    
//    self.contentView.frame = rect;
//}
@end
