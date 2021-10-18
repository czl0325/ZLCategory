//
//  UITools.m
//  PetClaw
//
//  Created by yihang zhuang on 11/1/12.
//  Copyright (c) 2012 ZQ. All rights reserved.
//

#import "UITools.h"


#pragma mark date
NSString *formatDateToString( NSDate *date ){
    NSString *s = [NSString stringWithFormat:@"%04zd-%02zd-%02zd",
                   date.year,date.month,date.day];
    return s;
}

NSString *formatDateToStringALL( NSDate *date ){
    NSString *s = [NSString stringWithFormat:@"%04zd-%02zd-%02zd %02zd:%02zd:%02zd",
                   date.year,date.month,date.day,date.hour,date.minute,date.seconds];
    return s;
}

NSString *formatDateToStringALLEx( NSDate *date ){
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *res = [dateFormat stringFromDate:date];
    
    return res;
}

NSDate *formatStringToDate( NSString *string ){
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
}

NSDate *formatStringToDateEx( NSString *string ){
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
}

NSDate *formatStringToDateMilli( NSString *string ){
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
}

BOOL is12Hours() {
    //获取系统是24小时制或者12小时制
    NSString*formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA =[formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM =containsA.location != NSNotFound;
    //hasAMPM==TURE为12小时制，否则为24小时制
    return hasAMPM;
}

NSString *genRandomString(int length){
    static NSString* list = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        NSString *s = [list substringWithRange:NSMakeRange(arc4random()%list.length, 1)];
        [str appendString:s];
    }
    return str;
}

UIImage *roundCorners(UIImage* img){
    int w = img.size.width;
    int h = img.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    myAddRoundedRectToPath(context, rect, 10, 10);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *res = [UIImage imageWithCGImage:imageMasked];
    CFRelease(imageMasked);
    return res;
}

void myAddRoundedRectToPath(CGContextRef context, CGRect rect,float ovalWidth,float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect),
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

void exChangeOut(UIView * changeOutView) {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

BOOL isSameDay(NSDate* date1, NSDate* date2) {
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if (
        (int)(([date1 timeIntervalSince1970] + timezoneFix)/(24*3600)) -
        (int)(([date2 timeIntervalSince1970] + timezoneFix)/(24*3600))
        == 0)
    {
        return YES;
    }
    return NO;
}

long minuteInterval(NSDate* fromDate, NSDate* toDate) {
    NSTimeInterval late1=[fromDate timeIntervalSince1970]*1;
    NSTimeInterval late2=[toDate timeIntervalSince1970]*1;
    NSTimeInterval cha=late2-late1;
    return cha/60;
}

UIImage *imageWithColor(UIColor *color, CGSize size ,float alpha) {
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAlpha(context, alpha);
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

UIImage * launchImage()
{
    UIImage *imageP = launchImageWithType(@"Portrait");
    if(imageP) return imageP;
    UIImage *imageL = launchImageWithType(@"Landscape");
    if(imageL) return imageL;
    NSLog(@"获取LaunchImage失败!请检查是否添加启动图,或者规格是否有误.");
    return nil;
}

UIImage *launchImageWithType(NSString *type) {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = type;
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            if([dict[@"UILaunchImageOrientation"] isEqualToString:@"Landscape"])
            {
                imageSize = CGSizeMake(imageSize.height, imageSize.width);
            }
            if(CGSizeEqualToSize(imageSize, viewSize))
            {
                launchImageName = dict[@"UILaunchImageName"];
                UIImage *image = [UIImage imageNamed:launchImageName];
                return image;
            }
        }
    }
    return nil;
}

UIImage* appIcon() {
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    return [UIImage imageNamed:icon];
}

UIView* createView(UIColor* color) {
    UIView* line = [UIView new];
    line.backgroundColor = color;
    return line;
}

UIViewController *myTopViewController(UIViewController *vc) {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* v = (UINavigationController*)vc;
        return myTopViewController(v.topViewController);
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* v = (UITabBarController*)vc;
        return myTopViewController(v.selectedViewController);
    } else {
        return vc;
    }
    return nil;
}

UIViewController *topViewController(void) {
    UIViewController *resultVC;
    resultVC = myTopViewController([UIApplication sharedApplication].keyWindow.rootViewController);
    while (resultVC.presentedViewController) {
        resultVC = myTopViewController(resultVC.presentingViewController);
    }
    return resultVC;
}

NSString* getAppName(void) {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

NSString* getAppVersion(void) {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

NSString* getAppBuild(void) {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}


/**
 调整二维码清晰度，添加水印图片
 
 @param img 模糊的二维码图片
 @param size 二维码的宽高
 @param waterImg 水印图片
 @return 添加水印图片后，清晰的二维码图片
 */
UIImage *getHDImgWithCIImage(CIImage *img ,CGSize size ,UIImage *waterImg) {
    
    CGRect extent = CGRectIntegral(img.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:img fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //清晰的二维码图片
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //水印图片
    //把水印图片画到生成的二维码图片上，注意尺寸不要太大（根据上面生成二维码设置的纠错程度设置），否则有可能造成扫不出来
    [waterImg drawInRect:CGRectMake((size.width-waterImg.size.width)/2.0, (size.height-waterImg.size.height)/2.0, waterImg.size.width, waterImg.size.height)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}



/**
 修改二维码颜色
 
 @param image 二维码图片
 @param red red
 @param green green
 @param blue blue
 @return 修改颜色后的二维码图片
 */
UIImage *changeColorWithQRCodeImg(UIImage *image ,NSUInteger red ,NSUInteger green, NSUInteger blue) {
    
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t * rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, (CGRect){(CGPointZero), (image.size)}, image.CGImage);
    //遍历像素
    int pixelNumber = imageHeight * imageWidth;
    changeColorOnPixel(rgbImageBuf ,pixelNumber ,red ,green ,blue);
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow, NULL);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    UIImage * resultImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    return resultImage;
}

/**
 遍历像素点，修改颜色
 
 @param rgbImageBuf rgbImageBuf
 @param pixelNum pixelNum
 @param red red
 @param green green
 @param blue blue
 */
void changeColorOnPixel(uint32_t *rgbImageBuf ,int pixelNum, NSUInteger red, NSUInteger green, NSUInteger blue) {
    
    uint32_t * pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        
        //通过颜色区分是不是要改变的区域
        if ((*pCurPtr & 0xffffff00) < 0xd0d0d000) {
            
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[3] = red;
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            //将白色变成透明色
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
}

/**
 拼接图片
 
 @param img1 图片1
 @param img2 图片2
 @param location 图片2相对于图片1的左上角位置
 @return 拼接后的图片
 */
UIImage *spliceImg1(UIImage *img1 ,UIImage *img2, CGPoint location) {
    
    //    CGSize size1 = img1.size;
    CGSize size2 = img2.size;
    
    UIGraphicsBeginImageContextWithOptions(img1.size, NO, [[UIScreen mainScreen] scale]);
    [img1 drawInRect:CGRectMake(0, 0, img1.size.width, img1.size.height)];
    
    //    [img2 drawInRect:CGRectMake((size1.width-size2.width)/2.0, (size1.height-size2.height)/2.0, size2.width, size2.height)];
    //    [img2 drawInRect:CGRectMake(size1.width/4.0, size1.height/2.5, size1.width/2, size1.width/2)];
    [img2 drawInRect:CGRectMake(location.x, location.y, size2.width, size2.height)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

void showCustomAlert(NSString* title, NSString* message) {
  showCustomAlertWithAlign(title, message, NSTextAlignmentCenter);
}

void showCustomAlertWithAlign(NSString* title, NSString* message, NSTextAlignment align) {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
  [alert addAction:conform];
  if (align != NSTextAlignmentCenter) {
    UIView *subView1 = alert.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    UILabel *tvMessage = subView5.subviews[2];
    tvMessage.textAlignment = align;
  }
  [topViewController() presentViewController:alert animated:YES completion:nil];
}

void showInteractionAlert(NSString* title, NSString* message, ZLAlertActionBlock confirmAction, ZLAlertActionBlock cancelAction) {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:confirmAction];
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancelAction];
  [alert addAction:conform];
  [alert addAction:cancel];
  [topViewController() presentViewController:alert animated:YES completion:nil];
}
