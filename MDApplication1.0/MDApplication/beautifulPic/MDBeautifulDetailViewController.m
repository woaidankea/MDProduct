//
//  MDBeautifulDetailViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/21.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDBeautifulDetailViewController.h"
#import "DXBarCode.h"
#import "UIImageView+WebCache.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "MDInterestDetailViewController.h"
#import "AppDelegate.h"
#import "MDArticleModel.h"
#import "DXShareTools.h"
#import "MDShareModel.h"
@interface MDBeautifulDetailViewController ()

@end

@implementation MDBeautifulDetailViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    _barcodeImage.frame = CGRectMake([_model.startX integerValue], [_model.startY integerValue], [_model.size integerValue]/2, [_model.size integerValue]/2);
    _barcodeImage.image =  [[DXBarCode shareInstance]createBarCodeImageFrom:_model.codeUrl withSize:[_model.size integerValue]/2];
   _barcodeImage.hidden =YES;
//    [_BigImage sd_setImageWithURL:[NSURL URLWithString:_model.imageBig] placeholderImage:nil];
    
    [_BigImage sd_setImageWithURL:[NSURL URLWithString:_model.imageBig] placeholderImage:[UIImage imageNamed:@"place_order_big"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        _BigImage.image = [self addImage: _barcodeImage.image toImage:_BigImage.image];
    }];
    
    
//    [self.BigImage sd_setImageWithURL:[NSURL URLWithString:self.bigImageUrl] placeholderImage:nil];
//    self.barcodeImage.frame = CGRectMake(0, 0, 100, 100);
}
//UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍照",@"照片图库",nil];
//[sheet showInView:self.view];
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(CGSizeMake(320, 390));
    
    // Draw image1
    [image2 drawInRect:CGRectMake(0, 0,320,390)];
    
    // Draw image2
    NSLog(@"%f",image2.size.width);
    [image1 drawInRect:CGRectMake([self.model.startX integerValue]/2, [self.model.startY integerValue]/2,[self.model.size integerValue]/2,[self.model.size integerValue]/2)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return resultingImage;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
     [self setleftBarItemWith:@"back_ico@2x.png"];
     [self  setrightBarItemWith:@"share_top"];
    _barcodeImage.translatesAutoresizingMaskIntoConstraints = YES;
    //添加长摁手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    //设置长按时间
    longPressGesture.minimumPressDuration = 0.5; //(2秒)
    [self.view addGestureRecognizer:longPressGesture];
    // Do any additional setup after loading the view.
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

- (void)share{
    
    
    if(!USER_DEFAULT_KEY(@"token")){
        
        [(AppDelegate*)[UIApplication sharedApplication].delegate exitAppToLandViewController];
        return;
        
        
    }

    
    
    NSArray *shareAry = @[@{@"image":@"share_wx",
                            @"title":@"微信"},
                          @{@"image":@"share_wx_timeline",
                            @"title":@"朋友圈"},
                          @{@"image":@"share_qq",
                            @"title":@"QQ"},
                          @{@"image":@"share_weibo",
                            @"title":@"新浪微博"},
                          @{@"image":@"share_qzone",
                            @"title":@"QQ空间"}];
    
    ShareModel *sharemodel = [[ShareModel alloc]init];
   
    
    
    
    sharemodel.title = self.model.title;
    sharemodel.url = self.model.codeUrl;
    sharemodel.imageArray = @[_BigImage.image];
    sharemodel.key = self.model.authCode;
    [DXShareTools shareToolsInstance].isPic = YES;
    [[DXShareTools shareToolsInstance]showShareView:shareAry contentModel:sharemodel view:[UIApplication sharedApplication].keyWindow];
}


//常摁手势触发方法
-(void)longPressGesture:(id)sender
{
    
    UILongPressGestureRecognizer *longPress = sender;
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"发送给朋友",@"识别图中二维码",nil];
        [sheet showInView:self.view];

//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"长按事件" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil nil];
//        [alter show];
    }
}
- (IBAction)shareButtonClick:(id)sender {
    [self share];
}
#pragma mark -selectPictureDelegate


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self share];
       
        
    }else if(buttonIndex==1){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MDInterestingArticleViewController" bundle:nil];
        MDInterestDetailViewController *vc = [story instantiateViewControllerWithIdentifier:@"MDInterestDetailViewController"];
        MDArticleModel *_nextModel = [[MDArticleModel alloc]init];
        _nextModel.cover =  self.model.imageSmall;
        _nextModel.assignUrl = self.model.codeUrl;
        MDShareModel *timeline = [[MDShareModel alloc]init];
        timeline.platform =@"4";
        timeline.show = YES;
        
        MDShareModel *QQ = [[MDShareModel alloc]init];
        QQ.show = YES;
         QQ.platform = @"1";
        _nextModel.shareConfig = @[timeline,QQ];
        
        vc.model =_nextModel;
        //    [self.navigationController pushViewController:vc animated:YES];
        
        
        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
    }
}

- (void)rightItemAction{
         [self share];
}
@end
