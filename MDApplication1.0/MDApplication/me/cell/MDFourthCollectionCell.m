//
//  MDFourthCollectionCell.m
//  MDApplication
//
//  Created by jieku on 16/3/28.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDFourthCollectionCell.h"

@implementation MDFourthCollectionCell

- (void)awakeFromNib {
    self.backgroundColor  = [UIColor whiteColor];
    self.layer.borderWidth = 0.25;
    self.layer.borderColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1].CGColor;
}

@end
