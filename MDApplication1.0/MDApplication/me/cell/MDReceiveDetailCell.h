//
//  MDReceiveDetailCell.h
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MDMoneyDetailModel.h"
@interface MDReceiveDetailCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Money;

@property (weak, nonatomic) IBOutlet UILabel *Date;

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (nonatomic,strong)MDMoneyDetailModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;

@end
