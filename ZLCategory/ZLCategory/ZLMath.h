//
//  ZLMath.hpp
//  wave
//
//  Created by qipai on 2018/3/16.
//  Copyright © 2018年 czl. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <stdio.h>
#import <QuartzCore/QuartzCore.h>

#define radiansToDegrees(x) (180.0 * x / M_PI)
#define degreesToRadians(angle) ((angle) / 180.0 * M_PI)

//计算两个点之间的距离
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second);

//两个点之间的角度
CGFloat angleBetweenPoints(CGPoint first, CGPoint second);

//两条线之间的角度
CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End);
