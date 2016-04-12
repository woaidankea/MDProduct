//
//  MDPopCollectionView.m
//  MDApplication
//
//  Created by jieku on 16/3/17.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "MDPopCollectionView.h"
#import "MDPublicConfig.h"
#import "MDPopCollectionViewCell.h"
#import "UtilsMacro.h"
@implementation MDPopCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
     self =[super initWithFrame:frame];
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    _collection = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    _collection.delegate=self;
    _collection.dataSource = self;
    _collection.backgroundColor = [UIColor whiteColor];
      _collection.alwaysBounceVertical = NO;
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    [self addSubview:_collection];

    return self;
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    _collection.delegate=self;
    _collection.dataSource = self;
    [_collection removeFromSuperview];
    
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//if(section==0){
//return 5;
//}
//if(section ==1)
//{
//return 2;
//}
   return 16;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
       return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * CellIdentifier = @"myCell";

    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor= [UIColor redColor];
    
    return cell;
    
    ////    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    //    cell.backgroundColor = [UIColor redColor];
    
}

//#pragma mark UICollectionViewFlowLayoutDelegate
////元素大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(5, 5);
//
////    if(indexPath.row >=1||indexPath.section>=1){
////        if(iPhone5){
////            return CGSizeMake(5, 5);
////        }
////        else if(iPhone6Pus){
////            
////            return CGSizeMake(207, 50);
////            
////        }
////        return CGSizeMake(375/2, 50);
////    }
////    
////    
////    if(iPhone5){
////        return CGSizeMake(320, 75);
////    }
////    else if(iPhone6Pus){
////        
////        return CGSizeMake(414, 75);
////        
////    }
////    return CGSizeMake(375, 75);
//    
//    
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    //    if(section==1)
//    //    {
//    //        return 0;
//    //    }
//    //    else{
//    return 5;
//    //    }
//    
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    
//    return 5;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if(section ==0){
//        return  CGSizeMake(320, 0);
//    }
//    return CGSizeMake(320, 12);
//}

@end
