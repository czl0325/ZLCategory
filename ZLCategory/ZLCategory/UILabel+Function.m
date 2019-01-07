//
//  UILabel+Function.m
//  ZLCategory
//
//  Created by zhaoliang chen on 2019/1/7.
//  Copyright © 2019 czl. All rights reserved.
//

#import "UILabel+Function.h"
#import <objc/runtime.h>

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@implementation UILabel (Function)



+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(zl_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(zl_sizeThatFits:));
    });
}

- (void)zl_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.zl_contentInsets;
    [self zl_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)zl_sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.zl_contentInsets;
    size = [self zl_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedZl_contentInsets;
- (void)setZl_contentInsets:(UIEdgeInsets)zl_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedZl_contentInsets, [NSValue valueWithUIEdgeInsets:zl_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)zl_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedZl_contentInsets) UIEdgeInsetsValue];
}


@end
