//
//  MDNewsCell.h
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MDNewsCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TitleImage;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;

@end
