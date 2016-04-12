//
//  DXShareTools.h
//  MDApplication
//
//  Created by jieku on 16/3/29.
//  Copyright © 2016年 jieku. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ShareModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,retain)NSArray *imageArray;
@property (nonatomic,copy)NSString *desc;

@end



@interface DXShareTools : NSObject
{
    ShareModel *CurrentModel;
}
@property (nonatomic, retain)NSArray         *shareAry;
@property (nonatomic, retain)NSArray         *shareImageValue;
@property (nonatomic, retain)NSArray         *shareImageActionTypes;
@property (nonatomic,assign)BOOL isPic;

+(DXShareTools *)shareToolsInstance;

-(void)showShareView:(NSArray *)shareAry contentModel:(ShareModel *) model view:(UIView *)view;
-(void)shareWithMode:(int)action fromSender:(UIView*)sender shareContent:(NSString*)someText;
@end
