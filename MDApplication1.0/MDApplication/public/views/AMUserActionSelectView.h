//
//  AMSelectPictureView.h
//  AMen
//
//  Created by gaoxinfei on 15/8/25.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPublicConfig.h"
@protocol SelectPictureDelegate <NSObject>

-(void)actionSelectAlertMethod:(NSInteger)btnTag alertType:(AM_AlertType)alertType;

@end
@interface AMUserActionSelectView : UIView

@property(assign,nonatomic)id<SelectPictureDelegate> delegate;
@property(assign,nonatomic)AM_AlertType alertType;

- (id)initWithAlertMessageArray:(NSArray *)messageArray :(AM_AlertType)alertType;

@end
