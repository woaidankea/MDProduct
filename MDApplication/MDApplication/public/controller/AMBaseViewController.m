//
//  AMBaseViewController.m
//  AMen
//
//  Created by gaoxinfei on 15/7/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMBaseViewController.h"
#import "MDPublicConfig.h"
#import "AMTools.h"
#import "UIImageView+WebCache.h"
#import "MDPublicConfig.h"
#import "UIColor+HexStringToColor.h"
#import "AMColorAndFontConfig.h"

@interface AMBaseViewController (){
  
}

@end

@implementation AMBaseViewController

-(id)init{
    
    self =[super init];
    if (self) {
    }
    return self;
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor ColorWithHexString:AM_LOWERBACK_COLOR];
//    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBarHidden=YES;
    [self.view setFrame:CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT)];
    [self initBaseLayout];
}

-(void)initBaseLayout{
    self.titleView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, FRAME_WIDTH, NavightBarHeight)];
    [self.view addSubview:self.titleView];
    self.titleView.backgroundColor =[UIColor ColorWithHexString:AM_NAVIGHTBAR_COLOR];
   
    self.titleNameLabel  =[AMTools creatLableWithFrame:CGRectMake (FRAME_WIDTH/4.0, 30*AM_HEIGHT_RATIO,FRAME_WIDTH/2.0, 19*AM_HEIGHT_RATIO) andText:self.titleName andColor:[UIColor blackColor] andFont:AM_FONT_38];

    self.titleNameLabel.textAlignment=NSTextAlignmentCenter;
    

    
    [self.titleView addSubview:self.titleNameLabel];
    [self.view addSubview:self.titleView];
    if (self.isBackBtn) {
        self.backBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 10*AM_HEIGHT_RATIO,60*AM_WIDTH_RATIO, 49)];
        self.backBtn.titleLabel.font =[UIFont systemFontOfSize:AM_FONT_32];
        [self.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:self.backBtn];
    }
    if (self.isNextBtn) {
        self.nextBtn =[[UIButton alloc]initWithFrame:CGRectMake(FRAME_WIDTH-60*AM_WIDTH_RATIO, 10*AM_HEIGHT_RATIO, 60*AM_WIDTH_RATIO, 49)];
        self.nextBtn.titleLabel.font =[UIFont systemFontOfSize:AM_FONT_32];
        [self.nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:self.nextBtn];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.view setFrame:CGRectMake(0, 0, FRAMEWIDTH, FRAMEHEIGTH)];
}

-(instancetype)initWithTitleName:(NSString *)titleName isBackBtn:(BOOL)isBackBtn isNextBtn:(BOOL)isNextBtn{
    self = [super init];
    if (self) {
        self.titleName =titleName;
        self.isNextBtn =isNextBtn;
        self.isBackBtn =isBackBtn;
    }
    return self;
}

-(void)backBtnAction{
    
}

-(void)nextBtnAction{
    
}

@end
