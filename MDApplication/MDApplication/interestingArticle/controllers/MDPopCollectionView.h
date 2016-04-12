//
//  MDPopCollectionView.h
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDPopCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)UICollectionView *collection;


@end
