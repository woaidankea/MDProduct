//
//  MDArticleCell.h
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBaseTableviewCell.h"
#import "MDArticleModel.h"

@protocol ArticleCellDelegate <NSObject>

- (void)choseButton:(UIButton *)sender;

@end

@interface MDArticleCell : MDBaseTableviewCell
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *income;
@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) id<ArticleCellDelegate> delegate;
- (IBAction)shareButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *datetime;


@property (nonatomic,strong)MDArticleModel *model;
@end
