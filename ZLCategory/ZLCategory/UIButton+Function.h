//
//  UIButton+Function.h
//  ZLCategory
//
//  Created by zhaoliang chen on 2018/8/8.
//  Copyright © 2018年 czl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BAKit_BAButtonCountDownBlock)(NSInteger currentTime);

typedef NS_ENUM(NSUInteger, ZLButtonEdgeInsetsStyle) {
    ZLButtonEdgeInsetsStyleTop, // image在上，label在下
    ZLButtonEdgeInsetsStyleLeft, // image在左，label在右
    ZLButtonEdgeInsetsStyleBottom, // image在下，label在上
    ZLButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Function)

@property (nonatomic, copy) void(^timeStoppedCallback)(void);

/**
 倒计时：带 title，返回时间，title，具体使用看 demo
 
 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)countDownWithTimeInterval:(NSTimeInterval)duration
                  countDownFormat:(NSString *)format;

/**
 倒计时：返回当前时间，可以自定义 title 和 image，具体使用看 demo
 
 @param duration 倒计时时间
 @param block 返回当前时间
 */
- (void)countDownCustomWithTimeInterval:(NSTimeInterval)duration
                                  block:(BAKit_BAButtonCountDownBlock)block;

/**
 * 倒计时：结束，取消倒计时
 */
- (void)cancelTimer;

- (void)layoutButtonWithEdgeInsetsStyle:(ZLButtonEdgeInsetsStyle)style;

- (void)layoutButtonWithEdgeInsetsStyle:(ZLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

//small 缩小的尺寸
- (void)layoutButtonWithEdgeInsetsStyle:(ZLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
                                  small:(CGFloat)smallSize;


@end
