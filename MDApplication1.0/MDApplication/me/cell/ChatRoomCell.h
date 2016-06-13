//
//  ChatRoomCell.h
//  Medicalmmt
//
//  Created by jieku on 16/4/28.
//  Copyright © 2016年 gulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyContentModel.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface ChatRoomCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *iconImage;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *countLabel;

- (void)setContentModel:(MyContentModel *)model;
@end
