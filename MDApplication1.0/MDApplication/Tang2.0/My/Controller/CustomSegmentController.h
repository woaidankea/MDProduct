//
//  CustomSegmentController.h
//  MDApplication
//
//  Created by jieku on 16/5/23.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "JYSlideSegmentController.h"






@interface CustomSegmentController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

/**
 *  Child viewControllers of SlideSegmentController
 */
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, assign, readwrite) NSInteger startIndex;

@property (nonatomic, strong, readwrite) UICollectionView *segmentBar;
@property (nonatomic, strong, readwrite) JYSlideView *slideView;

@property (nonatomic, weak, readwrite) UIViewController *selectedViewController;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

/**
 *  Custom UI
 */
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat segmentBarHeight;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) UIEdgeInsets indicatorInsets;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, strong) UIColor *segmentBarColor;
@property (nonatomic, assign) UIEdgeInsets segmentBarInsets;
@property (nonatomic, assign) CGFloat separatorHeight;

/**
 *  By default segmentBar use viewController's title for segment's button title
 *  You should implement JYSlideSegmentDataSource & JYSlideSegmentDelegate instead of segmentBar delegate & datasource
 */
@property (nonatomic, assign) id <JYSlideSegmentDelegate> delegate;
@property (nonatomic, assign) id <JYSlideSegmentDataSource> dataSource;

@property (nonatomic,assign)BOOL canSelected;


@property (nonatomic, assign, readwrite) NSInteger previousIndex;
@property (nonatomic, assign, readwrite) CGFloat lastDestination;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UIView *indicatorBgView;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, assign) CGRect currentIndicatorFrame;

@property (nonatomic, strong) UICollectionViewFlowLayout *segmentBarLayout;


@property (nonatomic,strong)UIView *line;
- (void)reset;
- (void)setupSubviews;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers;
- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                             startIndex:(NSInteger)startIndex;

- (void)scrollToViewWithIndex:(NSInteger)index animated:(BOOL)animated;

@end
