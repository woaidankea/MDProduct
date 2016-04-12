//
//  MDEditNameViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/19.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDEditNameViewController.h"

@interface MDEditNameViewController ()

@end

@implementation MDEditNameViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _NameField.placeholder = _placeName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改姓名";
    [self setleftBarItemWith:@"back_ico@2x.png"];
    _placeName = [NSString new];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    [rightBar setTintColor:[UIColor whiteColor]];
    rightBar.title = @"确定";
    [self.navigationItem setRightBarButtonItem:rightBar];


    
    // Do any additional setup after loading the view.
}

- (void)rightItemAction{
    if([self.delegate respondsToSelector:@selector(EditName:)]){
        [self.delegate performSelector:@selector(EditName:) withObject:_NameField.text];
    }
    
     [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
