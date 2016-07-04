//
//  KSGuideManager.m
//  KSGuide
//
//  Created by bing.hao on 16/3/10.
//  Copyright © 2016年 Tsingda. All rights reserved.
//

#import "KSGuideManager.h"
#import "UIImageView+WebCache.h"
#import "AdModel.h"
#import "ViewControllerFactory.h"
#import "AppDelegate.h"
#define kScreenBounds [UIScreen mainScreen].bounds

static NSString *identifier = @"Cell";

@interface KSGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;


@end

@implementation KSGuideViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self myInit];
    }
    return self;
}

- (void)myInit {
    
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = kScreenBounds;
    self.imageView.center = CGPointMake(kScreenBounds.size.width / 2, kScreenBounds.size.height / 2);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.hidden = YES;
 
    [button setBackgroundColor:[UIColor clearColor]];
    
    self.button = button;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.button];
    
    [self.button setCenter:CGPointMake(kScreenBounds.size.width -44,44)];
}

@end

@interface KSGuideManager ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UICollectionView *view;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation KSGuideManager

+ (instancetype)shared {
    static id __staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __staticObject = [KSGuideManager new];
    });
    return __staticObject;
}

- (UICollectionView *)view {
    if (_view == nil) {
        
        CGRect screen = [UIScreen mainScreen].bounds;
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = screen.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _view = [[UICollectionView alloc] initWithFrame:screen collectionViewLayout:layout];
        _view.bounces = YES;
        _view.backgroundColor = [UIColor clearColor];
        _view.showsHorizontalScrollIndicator = NO;
        _view.showsVerticalScrollIndicator = NO;
        _view.pagingEnabled = YES;
        _view.dataSource = self;
        _view.delegate = self;
        [_view registerClass:[KSGuideViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _view;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, 0, kScreenBounds.size.width, 44.0f);
        _pageControl.center = CGPointMake(kScreenBounds.size.width / 2, kScreenBounds.size.height - 60);
    }
    return _pageControl;
}

- (void)showGuideViewWithImages:(NSArray *)images withtype:(BOOL)isAd{
    
    _Ad = isAd;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //根据版本号来区分是否要显示引导图
    BOOL show = [ud boolForKey:[NSString stringWithFormat:@"Guide_%@", version]];
    
//    if (!show && self.window == nil) {

        self.images = images;
        self.pageControl.numberOfPages = images.count;
        self.window = [[[UIApplication sharedApplication] delegate] window];
        
        [self.window addSubview:self.view];
//        [self.window addSubview:self.pageControl];
    
        [ud setBool:YES forKey:[NSString stringWithFormat:@"Guide_%@", version]];
        [ud synchronize];
//    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_Ad){
    AdModel *model  = [self.images objectAtIndex:indexPath.row];
    
    if([model.isclick isEqualToString:@"1"]){
        BaseViewController *vc = [ViewControllerFactory TabMenuFactoryCreateViewControllerWithType:kWebViewController];
        
        [vc setleftBarItemWith:nil];
        vc.url = model.clickurl;
        [self guideRemove];

        [((AppDelegate *)[UIApplication sharedApplication].delegate).rootController pushViewController:vc animated:YES];
    }else{
        return;
    }
    }
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KSGuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(_Ad){
    AdModel *path = [self.images objectAtIndex:indexPath.row];
    
//    UIImage *img = [UIImage imageWithContentsOfFile:path];
//    CGSize size = [self adapterSizeImageSize:img.size compareSize:kScreenBounds.size];
//    
//    //自适应图片位置,图片可以是任意尺寸,会自动缩放.
//    cell.imageView.frame = CGRectMake(0, 0, size.width, size.height);
//    cell.imageView.image = [UIImage imageWithContentsOfFile:path];
//    cell.imageView.center = CGPointMake(kScreenBounds.size.width / 2, kScreenBounds.size.height / 2);
  
        SDWebImageManager *manage = [[SDWebImageManager alloc] init];
        NSURL *url = [[NSURL alloc] initWithString: path.adurl];
        if ([manage cachedImageExistsForURL: url] == NO) {
            [self guideRemove];
            [self requestBanner:path.adurl];
        }else{
        
        
    
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:path.adurl] placeholderImage:[UIImage imageNamed:@"LaunchImage"]];
        [cell.button setFrame:CGRectMake(0, 0,50, 25)];
        [cell.button setTitle:@"跳过" forState:UIControlStateNormal];
        [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.button.layer setCornerRadius:12.5];
        [cell.button.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.button.layer setBorderWidth:0.5f];
        cell.button.titleLabel.font = [UIFont systemFontOfSize:15];
          [cell.button setCenter:CGPointMake(kScreenBounds.size.width -44,44)];
        [cell.button addTarget:self action:@selector(nextButtonHandler:) forControlEvents:UIControlEventTouchUpInside];

        [cell.button setHidden:NO];
        }
    
    }else{
        NSString *path = [self.images objectAtIndex:indexPath.row];
        
            UIImage *img = [UIImage imageWithContentsOfFile:path];
            CGSize size = [self adapterSizeImageSize:img.size compareSize:kScreenBounds.size];
        
            //自适应图片位置,图片可以是任意尺寸,会自动缩放.
            cell.imageView.frame = CGRectMake(0, 0, size.width, size.height);
            cell.imageView.image = [UIImage imageWithContentsOfFile:path];
            cell.imageView.center = CGPointMake(kScreenBounds.size.width / 2, kScreenBounds.size.height / 2);
        if(indexPath.row == self.images.count - 1){
            [cell.button addTarget:self action:@selector(nextButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"2208-a"] forState:UIControlStateNormal];
            if(iPhone6Pus){
                [cell.button setFrame:CGRectMake((1242/3 - 724/3)/2, kScreenBounds.size.height - 140, 724/3, 188/3)];
            }else if(iPhone6){
              [cell.button setFrame:CGRectMake((750/2 - 220)/2, kScreenBounds.size.height - 120, 220, 57)];
            }else{
              [cell.button setFrame:CGRectMake((640/2 - 362)/2, kScreenBounds.size.height - 120, 186, 49)];
            }
            [cell.button setTitle:@"开始赚钱" forState:UIControlStateNormal];
            [cell.button setTitleColor:UIColorFromRGB(0xd53c3e) forState:UIControlStateNormal];
            cell.button.titleLabel.font = [UIFont systemFontOfSize:20];
            [cell.button setHidden:NO];
        }

    }


    return cell;
}

#pragma mark - 获取本地图片缓存，如果没有广告结束
- (void) displayCachedAd {
//    SDWebImageManager *manage = [[SDWebImageManager alloc] init];
//    NSURL *url = [[NSURL alloc] initWithString: self.imageURL];
//    if ([manage cacheKeyForURL: url] == NO) {
//        self.hidden = YES;
//    } else {
//        [self showImage];
//    }
}

#pragma mark - 下载图片
- (void) requestBanner:(NSString *)imageURL {
    [[SDWebImageManager sharedManager] downloadImageWithURL: [[NSURL alloc] initWithString: imageURL]
                                                    options: SDWebImageAvoidAutoSetImage
                                                   progress: nil
                                                  completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      NSLog(@"图片下载成功");
                                                  }];
}


- (CGSize)adapterSizeImageSize:(CGSize)is compareSize:(CGSize)cs
{
    CGFloat w = cs.width;
    CGFloat h = cs.width / is.width * is.height;
    
    if (h < cs.height) {
        w = cs.height / h * w;
        h = cs.height;
    }
    return CGSizeMake(w, h);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = (scrollView.contentOffset.x / kScreenBounds.size.width);

   
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"%f,%f",scrollView.contentOffset.x,kScreenBounds.size.width);
    if (scrollView.contentOffset.x > kScreenBounds.size.width*(self.images.count-1)) {
        [self guideRemove];
    }
}

- (void)nextButtonHandler:(id)sender {

    [self guideRemove];
    [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
    

}

-(void)guideRemove{
    [self.view removeFromSuperview];
    [self.pageControl removeFromSuperview];
    
    [self setWindow:nil];
    [self setView:nil];
    [(AppDelegate*)[UIApplication sharedApplication].delegate EnterMainViewController:AM_NORMAL_ENTER];
    

   
}

@end
