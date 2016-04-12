//
//  AMBaseViewController.h
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMBaseViewController : UIViewController

@property(strong,nonatomic)UIButton *backBtn;
@property(strong,nonatomic)UIButton *nextBtn;
@property(strong,nonatomic)UILabel *titleNameLabel;
@property(strong,nonatomic)UIView *titleView;
@property(strong,nonatomic)NSString *titleName;
@property(assign,nonatomic)BOOL isBackBtn;
@property(assign,nonatomic)BOOL isNextBtn;

-(id)initWithTitleName:(NSString *)titleName isBackBtn:(BOOL)isBackBtn isNextBtn:(BOOL)isNextBtn;
-(void)initBaseLayout;

@end
