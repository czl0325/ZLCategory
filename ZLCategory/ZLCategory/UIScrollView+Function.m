//
//  UIScrollView+Function.m
//  ZLCategory
//
//  Created by zhaoliang chen on 2018/4/12.
//  Copyright © 2018年 czl. All rights reserved.
//

#import "UIScrollView+Function.h"
#import "UIView+Function.h"

@implementation UIScrollView (Function)

- (void)adjustBehavior {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
