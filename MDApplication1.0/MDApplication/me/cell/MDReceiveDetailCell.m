//
//  MDReceiveDetailCell.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDReceiveDetailCell.h"

@implementation MDReceiveDetailCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setModel:(MDMoneyDetailModel *)model{
    _Title.text = model.title;
    _Money.text = model.amount;
    _Date.text = model.date;
    
}

@end
