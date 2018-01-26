//
//  UISlider+touch.h
//  SevenDressHD
//
//  Created by czl on 15/11/3.
//  Copyright © 2015年 chi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (Function)

// 为UISlider添加单击事件
- (void)addTapGestureWithTarget: (id)target
                         action: (SEL)action;

@end
