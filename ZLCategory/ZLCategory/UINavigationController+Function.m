//
//  UINavigationController+Function.m
//  Seven
//
//  Created by qipai on 2017/12/14.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import "UINavigationController+Function.h"

@implementation UINavigationController (Function)

-(BOOL)popToViewController:(Class)vcClass; {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    //    遍历导航控制器中的控制器
    BOOL isIn = NO;
    NSInteger i=viewControllers.count-1;
    while (i>=0) {
        UIViewController *vc = viewControllers[i];
        if (![vc isKindOfClass:vcClass]) {
            [viewControllers removeLastObject];
        } else {
            isIn = YES;
            break;
        }
        i--;
    }
    if (isIn) {
        //把控制器重新添加到导航控制器
        [self setViewControllers:viewControllers animated:YES];
    }
    return isIn;
}

@end
