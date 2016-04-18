//
//  MDDiscipleCell.m
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDDiscipleCell.h"

@implementation MDDiscipleCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderWidth = 0.25;
    self.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1].CGColor;

}

- (void)setPupilModel:(MDPupilModel *)pupilModel{
    _First.text = pupilModel.ranking;
    _Second.text = pupilModel.telephone;
    _Third.text = [NSString stringWithFormat:@"￥%.2f",[pupilModel.money floatValue]];
}


- (void)setRankModel:(MDRankModel *)rankModel{
    _Second.text = rankModel.phone;
    _Third.text = [NSString stringWithFormat:@"￥%.2f",[rankModel.totalmoney floatValue]];
}

- (void)setTxModel:(MDTXModel *)txModel{
    _First.text = txModel.date;
    _Second.text = txModel.money;
    _Third.text =txModel.status;
}

@end
