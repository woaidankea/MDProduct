//
//  MDHeadImageCell.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDHeadImageCell.h"

@implementation MDHeadImageCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
