//
//  AMNoNetWorkLinkViewController.m
//  AMen
//
//  Created by gaoxinfei on 15/9/13.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AMNoNetWorkLinkViewController.h"

@implementation AMNoNetWorkLinkViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.backBtn setTitle:UILocalizedString(@"UI_NO_NETWORKLINK_BACK") forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
