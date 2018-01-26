/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, kAddLineDirectionOption)
{
    kAddLineNone    = 0,
    kAddLineTop     = 1<<0,
    kAddLineRight   = 1<<1,
    kAddLineBottom  = 1<<2,
    kAddLineLeft    = 1<<3,
};

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Function)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat ttScreenX;
@property (nonatomic, readonly) CGFloat ttScreenY;

@property (nonatomic, readonly) CGFloat screenViewX;
@property (nonatomic, readonly) CGFloat screenViewY;

@property (nonatomic, readonly) CGRect screenFrame;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

/******
 删除view里面所有的子view
 ******/
- (void) removeAllSubviews;

/******
 返回view所在的viewController
 ******/
- (UIViewController*) viewController;
- (void)transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view ;

/******
 将任意uiview转化成uiimage
 ******/
- (UIImage*) imageWithUIView;
- (void)setBorderWithView:(kAddLineDirectionOption)direction borderColor:(UIColor *)color borderWidth:(CGFloat)width;

/******
 从xib来加载uiview
 ******/
+ (instancetype)loadFromXib;

/**
 *  uiview的爆炸效果
 **/
- (void)lp_explode;

@end
