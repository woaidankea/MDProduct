//
//  MDBeautifulPicViewControlleCell.h
//  MDApplication
//
//  Created by jieku on 16/3/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MDBeautifulPicModel.h"
@interface MDBeautifulPicViewControlleCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *AdPic;
@property (weak, nonatomic) IBOutlet UILabel *ScanNo;


@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *MoneyLabel;
@property (nonatomic,strong)MDBeautifulPicModel *model;
@end
