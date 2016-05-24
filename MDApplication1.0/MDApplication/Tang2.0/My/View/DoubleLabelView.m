//
//  DoubleLabelView.m
//  MDApplication
//
//  Created by jieku on 16/5/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "DoubleLabelView.h"

@implementation DoubleLabelView


- (id)init{
    self = [super init];
    if(self){
          [self setUpConstriant];
       
    }
    return self;
}

- (void)setUpConstriant{
    
    WS(weakSelf);
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        //        make.right.equalTo(weakSelf.contentView.mas_right).offset(0);
        //        make.left.equalTo(weakSelf.contentView.mas_left).offset(0);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(@20);
        //        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(0);
    }];
    [self.lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.firstLabel.mas_bottom).offset(0);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(@20);
           }];
}
- (UILabel *)firstLabel{
    if(!_firstLabel){
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.font = [UIFont systemFontOfSize:20.0];
        _firstLabel.textColor = UIColorFromRGB(0xffffff);
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        //        _titleLabel.backgroundColor = UIColorFromRGB(0x67c2fc);
        [self addSubview:_firstLabel];
        
    }
    return _firstLabel;
}


- (UILabel *)lastLabel{
    if(!_lastLabel){
        _lastLabel = [[UILabel alloc] init];
        _lastLabel.font = [UIFont systemFontOfSize:12.0f];
        _lastLabel.textColor = [UIColor whiteColor];
        _lastLabel.textAlignment = NSTextAlignmentCenter;
        //        _titleLabel.backgroundColor = UIColorFromRGB(0x67c2fc);
        [self addSubview:_lastLabel];
        
    }
    return _lastLabel;
}


@end
