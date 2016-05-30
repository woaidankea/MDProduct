//
//  MDBaseCollectionViewController.m
//  MDApplication
//
//  Created by jieku on 16/3/15.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDBaseCollectionViewController.h"

@implementation MDBaseCollectionViewController


- (void)viewDidLoad{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)resetCollectionView:(UICollectionView *)collection{
    _collectionview = collection;
    _collectionview.dataSource = self;
    _collectionview.delegate = self;
    _collectionview.backgroundColor = UIColorFromRGB(0xeeeeee);
}

- (void)addHeaderRefresh{
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self tableViewHeaderRefresh];
    }];
    
    // 马上进入刷新状态
    //    [self.tableView.header beginRefreshing];
}

- (void)addFooterRefresh{
    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self tableViewFooterRefresh];
    }];
}


- (void)tableViewHeaderRefresh{
    NSLog(@"Header refresh");
}

- (void)tableViewFooterRefresh{
    NSLog(@"Footer refresh");
}



#pragma mark UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}


@end
