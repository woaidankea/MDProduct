//
//  DXBarCode.m
//  MDApplication
//
//  Created by jieku on 16/3/18.
//  Copyright © 2016年 jieku. All rights reserved.
//

#import "DXBarCode.h"

@implementation DXBarCode
+(DXBarCode *)shareInstance;
{
    static DXBarCode *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareInstance =[[self alloc] init];
    });
    return shareInstance;
}
-(CIImage *)erweima:(NSString *)string

{
    
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    return outputImage;
    //将CIImage转换成UIImage,并放大显示
    
//    _imgView.image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
//    
//    
//    
//    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
//    
//    _imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
//    
//    _imgView.layer.shadowRadius=1;//设置阴影的半径
//    
//    _imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
//    
//    _imgView.layer.shadowOpacity=0.3;
    
    
    
}



//改变二维码大小

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}


- (UIImage *)createBarCodeImageFrom:(NSString *) string withSize:(CGFloat)size{

    return [self createNonInterpolatedUIImageFormCIImage:[self erweima:string] withSize:size];
}


@end
