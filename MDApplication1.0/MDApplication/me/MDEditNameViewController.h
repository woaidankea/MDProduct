//
//  MDEditNameViewController.h
//  MDApplication
//
//  Created by jieku on 16/3/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "BaseViewController.h"
@protocol MDInfomationDelegate <NSObject>

-(void)EditName:(NSString *)name;

@end

@interface MDEditNameViewController : BaseViewController
@property(assign,nonatomic)id<MDInfomationDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *NameField;
@property (copy,nonatomic)NSString *placeName;

@end
