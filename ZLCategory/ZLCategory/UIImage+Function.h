//
//  UIImage+function.h
//  zhuanxian
//
//  Created by qipai on 2017/11/20.
//  Copyright © 2017年 huiling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Function)

//图片是否有alpha层
- (BOOL)hasAlpha;

//返回一个给定图像的副本，如果还没有一个alpha通道，就添加一个alpha通道。
- (UIImage *)imageWithAlpha;

//返回一个图像的拷贝，它的边缘有一个透明的边界。如果图像没有alpha层，就会添加一个图层。
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

//给图片加圆角
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

//改变图片大小
- (UIImage *)croppedImage:(CGRect)bounds;

//返回一个与缩略图大小的图像的拷贝。
//如果透明边界是非零的，那么在缩略图的边缘会添加一个透明边框的边界。(添加一个至少一个像素的透明边框，在使用Core动画旋转时，会产生反锯齿的副作用。)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

//返回图像的重新复制，考虑到它的方向
//如果必要的话，图像将不成比例地缩放，以符合参数指定的范围。
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

//调整图像的大小，根据给定的内容模式，考虑图像的方位
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

//根据rect来截取图像某个矩形块的内容
- (UIImage *)cutoutImage:(CGRect)rect;

//图片转换
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data;
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url;

//图片缩放
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

@end
