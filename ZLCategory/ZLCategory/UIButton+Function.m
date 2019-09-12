//
//  UIButton+Function.m
//  ZLCategory
//
//  Created by zhaoliang chen on 2018/8/8.
//  Copyright © 2018年 czl. All rights reserved.
//

#import "UIButton+Function.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, assign) NSTimeInterval leaveTime;
@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *countDownFormat;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation UIButton (Function)

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLeaveTime:(NSTimeInterval)leaveTime {
    objc_setAssociatedObject(self, @selector(leaveTime), @(leaveTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)leaveTime {
    return  [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setCountDownFormat:(NSString *)countDownFormat {
    objc_setAssociatedObject(self, @selector(countDownFormat), countDownFormat, OBJC_ASSOCIATION_COPY);
}

- (NSString *)countDownFormat {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTimeStoppedCallback:(void (^)(void))timeStoppedCallback {
    objc_setAssociatedObject(self, @selector(timeStoppedCallback), timeStoppedCallback, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))timeStoppedCallback {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNormalTitle:(NSString *)normalTitle {
    objc_setAssociatedObject(self, @selector(normalTitle), normalTitle, OBJC_ASSOCIATION_COPY);
}

- (NSString *)normalTitle {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - public
/**
 倒计时：带 title，返回时间，title，具体使用看 demo
 
 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)countDownWithTimeInterval:(NSTimeInterval)duration
                     countDownFormat:(NSString *)format
{
    if (!format) {
        self.countDownFormat = @"%zd秒";
    }  else {
        self.countDownFormat = format;
    }
    self.userInteractionEnabled = NO;
    self.enabled = NO;
    self.normalTitle = self.titleLabel.text;
    __block NSInteger timeOut = duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __typeof(self) weakself = self;
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (timeOut <= 0) { // 倒计时结束，关闭
                [weakself cancelTimer];
            } else {
                NSString *title = [NSString stringWithFormat:weakself.countDownFormat, timeOut];
                [weakself setTitle:title forState:UIControlStateNormal];
                timeOut--;
            }
        });
    });
    dispatch_resume(self.timer);
}

/**
 倒计时：返回当前时间，可以自定义 title 和 image，具体使用看 demo
 
 @param duration 倒计时时间
 @param block 返回当前时间
 */
- (void)countDownCustomWithTimeInterval:(NSTimeInterval)duration
                                     block:(BAKit_BAButtonCountDownBlock)block
{
    self.normalTitle = self.titleLabel.text;
    self.userInteractionEnabled = NO;
    self.enabled = NO;
    __block NSInteger timeOut = duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(timeOut);
            }
            if (timeOut <= 0) {
                // 倒计时结束，关闭
                [self cancelTimer];
            } else {
                timeOut--;
            }
        });
    });
    dispatch_resume(self.timer);
}

/**
 * 倒计时：结束，取消倒计时
 */
- (void)cancelTimer {
    if (!self.timer) {
        return;
    }
    dispatch_source_cancel(self.timer);
    self.timer = nil;
    // 设置界面的按钮显示 根据自己需求设置
    [self setTitle:self.normalTitle forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
    self.enabled = YES;
    if (self.timeStoppedCallback) {
        self.timeStoppedCallback();
    }
}

- (void)layoutButtonWithEdgeInsetsStyle:(ZLButtonEdgeInsetsStyle)style {
    [self layoutButtonWithEdgeInsetsStyle:style imageTitleSpace:0];
}

- (void)layoutButtonWithEdgeInsetsStyle:(ZLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    [self layoutButtonWithEdgeInsetsStyle:style imageTitleSpace:0 small:0];
}

- (void)layoutButtonWithEdgeInsetsStyle:(ZLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
                                  small:(CGFloat)smallSize {
    /**
     *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    
    if (smallSize > 0) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    CGFloat imageWith = self.imageView.image.size.width ;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (style) {
        case ZLButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case ZLButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(smallSize/2.0, -space/2.0, smallSize/2.0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case ZLButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case ZLButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(smallSize/2.0, labelWidth+space/2.0, smallSize/2.0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
