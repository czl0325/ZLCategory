//
//  UILabel+Function.h
//  ZLCategory
//
//  Created by zhaoliang chen on 2019/1/7.
//  Copyright © 2019 czl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Function)

/**
 修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets zl_contentInsets;

@end

NS_ASSUME_NONNULL_END
