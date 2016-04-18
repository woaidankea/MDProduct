//
//  MDArticleCell.m
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDArticleCell.h"
#import "UIColor+HexStringToColor.h"
@implementation MDArticleCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(MDArticleModel *)model{
        [_cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"place_order"]];
        
         _title.text = model.title;
         _income.text = model.inCome;
    
        if([model.showPrice isEqualToString:@"1"]){
            
            _income.text = [NSString stringWithFormat:@"￥%@",model.inCome];
            _income.textColor = [UIColor ColorWithHexString:@"E82C28"];
            
        }else{
            
          _income.text = model.createTime;
          _income.textColor = [UIColor ColorWithHexString:@"9A9A9A"];
            
        }
         _readCount.text = [NSString stringWithFormat:@"阅读数：%@",model.readCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)shareButtonClick:(id)sender {
    
    
    if ([_delegate respondsToSelector:@selector(choseButton:)]) {
            [_delegate choseButton:sender];
        }
    
    
}
@end
