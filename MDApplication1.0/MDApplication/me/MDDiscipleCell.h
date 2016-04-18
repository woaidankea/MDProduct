//
//  MDDiscipleCell.h
//  MDApplication
//
//  Created by jieku on 16/3/16.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBaseTableviewCell.h"
#import "MDPupilModel.h"
#import "MDRankModel.h"
#import "MDTXModel.h"
@interface MDDiscipleCell : MDBaseTableviewCell
@property (weak, nonatomic) IBOutlet UILabel *First;
@property (weak, nonatomic) IBOutlet UILabel *Second;
@property (weak, nonatomic) IBOutlet UILabel *Third;
@property (nonatomic,strong)MDPupilModel *pupilModel;
@property (nonatomic,strong)MDRankModel *rankModel;
@property (nonatomic,strong)MDTXModel *txModel;

@end
