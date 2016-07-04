//
//  TangRankingCell.m
//  MDApplication
//
//  Created by jieku on 16/5/24.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "TangRankingCell.h"

@implementation TangRankingCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
        [self setUpConstriant];
    }
    return self;
}
- (void)setUpConstriant{
    
    WS(weakSelf);
    
    [self.sortImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(20);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(12);
        
    }];
    
    [self.avatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.sortImage.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.height.mas_equalTo(45);
        
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.avatorView.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
        
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-20);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
        
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
         make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        
        
        make.height.mas_equalTo(1);
        
        
    }];

    
    
    
    
}
- (UILabel *)accountLabel{
    if(!_accountLabel){
        _accountLabel = [[UILabel alloc]init];
        _accountLabel.font = [UIFont systemFontOfSize:15.0];
        _accountLabel.text = @"";
        _accountLabel.textColor = UIColorFromRGB(0x111215);
        [self.contentView addSubview:_accountLabel];
        
    }
    return _accountLabel;
    
}

- (UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:15.0];
        _contentLabel.text = @"";
        _contentLabel.textColor = UIColorFromRGB(0xd3494e);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_contentLabel];
        
    }
    return _contentLabel;
    
}


- (UIImageView *)avatorView{
    if(!_avatorView){
        _avatorView = [[UIImageView alloc]init];
        _avatorView.image = [UIImage imageNamed:@"avatorplaceorder"];
        _avatorView.layer.cornerRadius = 22.5;
        [self.contentView addSubview:_avatorView];
    }
    return _avatorView;
}

- (UIImageView *)sortImage{
    if(!_sortImage){
        _sortImage = [[UIImageView alloc]init];
        _sortImage.image = [UIImage imageNamed:@"1"];
        
        [self.contentView addSubview:_sortImage];
    }
    return _sortImage;
}


- (UIView *)bottomLine{
    if(!_bottomLine){
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [self.contentView addSubview:_bottomLine];
        
    }

    return _bottomLine;

}
@end
