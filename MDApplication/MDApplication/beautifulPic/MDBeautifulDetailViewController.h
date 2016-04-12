//
//  MDBeautifulDetailViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
#import "MDBeautifulPicModel.h"
@interface MDBeautifulDetailViewController : BaseViewController

@property (nonatomic,strong)MDBeautifulPicModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *BigImage;
@property (weak, nonatomic) IBOutlet UIImageView *barcodeImage;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)shareButtonClick:(id)sender;

@end
