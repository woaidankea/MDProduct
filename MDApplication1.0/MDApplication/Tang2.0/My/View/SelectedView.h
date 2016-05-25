//
//  SelectedView.h
//  MDApplication
//
//  Created by jieku on 16/5/24.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectedViewDelegate <NSObject>
- (void)SelectedViewDidSelectedAtIndex:(NSInteger )index;
@end
@interface SelectedView : UIView

@property(nonatomic,strong)UITableView *table;
@property (nonatomic,assign)NSInteger currentSelected;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,assign)id<SelectedViewDelegate> delegate;
@end
