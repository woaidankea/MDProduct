//
//  MDBeautifulPicViewControlleCell.m
//  MDApplication
//
//  Created by jieku on 16/3/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDBeautifulPicViewControlleCell.h"

@implementation MDBeautifulPicViewControlleCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
 
}
*/

- (void)awakeFromNib {
    // Initialization code
    
        _bgView.layer.shadowOffset = CGSizeMake(1, 1);
        _bgView.layer.shadowColor = [UIColor grayColor].CGColor;
        _bgView.layer.shadowOpacity = 0.80;
}


- (void)setModel:(MDBeautifulPicModel *)model{
    [_AdPic sd_setImageWithURL:[NSURL URLWithString:model.imageSmall] placeholderImage:[UIImage imageNamed:@"place_order_big"]];
    
    _ScanNo.text =[NSString stringWithFormat:@"扫码数:%@",model.scanCount];
    if(ServerJieKu){
        _MoneyLabel.text = [NSString stringWithFormat:@"￥%@",model.inCome];
    }else{
//     _MoneyLabel.text = model.income;
    }
   
   
}


@end
