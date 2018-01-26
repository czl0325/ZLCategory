//
//  UINavigationController+Function.h
//  Seven
//
//  Created by qipai on 2017/12/14.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Function)

//回退到指定页面
-(BOOL)popToViewController:(Class)vcClass;

@end
