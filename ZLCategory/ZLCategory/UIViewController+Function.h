//
//  UIViewController+Function.h
//  ZLCategory
//
//  Created by zhaoliang chen on 2018/5/5.
//  Copyright © 2018年 czl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
-(BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (Function)<BackButtonHandlerProtocol>



@end
