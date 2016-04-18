//
//  MDMeSecondCell.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDMeSecondCell.h"

@implementation MDMeSecondCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderWidth = 0.25;
    self.layer.borderColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1].CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
