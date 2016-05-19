//
//  BaseViewController.m
//  AMen
//
//  Created by libo on 15/10/19.
//  Copyright © 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewController.h"
#import "AMTools.h"
#import "MDPublicConfig.h"
#import "MBProgressHUD.h"

@interface BaseViewController (){
    int _busyCount;
}

@property (strong, nonatomic)MBProgressHUD *busyIndicator;

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)delayToEnableUserInteraction:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    [self performSelector:@selector(delayToEnableUser:) withObject:sender afterDelay:1];
}

- (void)delayToEnableUser:(UIButton *)sender{
    sender.userInteractionEnabled = YES;
}

-(void)setBusyIndicatorVisible:(BOOL)visible{
    if(visible){
        _busyCount++;
        if(self.busyIndicator==nil){
            self.busyIndicator=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
            self.busyIndicator.dimBackground=YES;
        }
    }else{
        _busyCount--;
        if(_busyCount==0 || _busyCount<0){
            _busyCount=0;
            [self.busyIndicator hide:YES];
            [self.busyIndicator removeFromSuperview];
            self.busyIndicator=nil;
        }
    }
}

-(BOOL)handleResponseError:(BaseViewController *)currentController
                   request:(AMBaseRequest *)request
       treatErrorAsUnknown:(BOOL) treated{
    
    NSString *confirmTitle=UILocalizedString(@"UI_TEXT_CONFIRM");
    if(request.response.statusCode==-100){
//        [AMTools showAlertViewWithMessage:request.response.errorMessage cancelButtonTitle:confirmTitle];
        [AMTools showHUDtoView:self.view title:request.response.errorMessage delay:2];
        return YES;
    }
    
    if (request.response.errorMessage) {
        [AMTools showAlertViewWithTitle:request.response.errorMessage cancelButtonTitle:confirmTitle];
        return YES;
    }
    
    if(treated){
        [AMTools showAlertViewWithMessage:UILocalizedString(@"UI_UNKOWN_ERROR_MESSAGE") cancelButtonTitle:confirmTitle];
        return YES;
    }
    
    return NO;
}

-(void)setleftBarItemWith:(NSString *)imageNamed{


    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageNamed] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    [leftBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftBar];
}


- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setrightBarItemWith:(NSString *)imageNamed{
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageNamed] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    [rightBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightBar];
}


- (void)rightItemAction{
    
}


- (void)addNotification{}

- (void)removeNotification{}

- (void)dealloc{
    [self removeNotification];
}

@end
