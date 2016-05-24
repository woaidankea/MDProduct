//
//  ChatRoomCell.m
//  Medicalmmt
//
//  Created by jieku on 16/4/28.
//  Copyright © 2016年 gulei. All rights reserved.
//

#import "ChatRoomCell.h"
#import "Masonry.h"
@implementation ChatRoomCell

- (id)initWithFrame:(CGRect)frame{

    self =  [super initWithFrame: frame];
    if(self){
//        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
        [self setUpConstriant];
    }
    return self;
}



- (void)setUpConstriant{

    WS(weakSelf);
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(25);
        make.centerX.equalTo(weakSelf.contentView.mas_centerX);
        make.width.height.equalTo(@31);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImage.mas_bottom).offset(0);
//        make.right.equalTo(weakSelf.contentView.mas_right).offset(0);
//        make.left.equalTo(weakSelf.contentView.mas_left).offset(0);
        make.centerX.equalTo(weakSelf.contentView.mas_centerX);
        make.height.equalTo(@40);
//        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(0);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(0);
           make.height.equalTo(@40);
           make.centerX.equalTo(weakSelf.contentView.mas_centerX);
      
    }];

}
- (UIImageView *)iconImage{
    if(!_iconImage){
        _iconImage =[[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"zijin"];
        
        [self.contentView addSubview:_iconImage];
    }
    return _iconImage;
}
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.backgroundColor = UIColorFromRGB(0x67c2fc);
        [self.contentView addSubview:_titleLabel];
    
    }
    return _titleLabel;
}


- (UILabel *)countLabel{
    if(!_countLabel){
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:12.0f];
        _countLabel.textColor = [UIColor whiteColor];
        //        _titleLabel.backgroundColor = UIColorFromRGB(0x67c2fc);
        [self.contentView addSubview:_countLabel];
        
    }
    return _countLabel;
}

@end
