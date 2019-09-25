//
//  ZLCategory.h
//  ZLCategory
//
//  Created by qipai on 2018/1/26.
//  Copyright © 2018年 czl. All rights reserved.
//

//版本  v0.1.6.1

#import "NSDate+Function.h"
#import "NSString+Function.h"
#import "UIColor+Function.h"
#import "UIImage+Function.h"
#import "UINavigationController+Function.h"
#import "UISlider+Function.h"
#import "UITableView+Function.h"
#import "UIButton+Function.h"
#import "UIViewController+Function.h"
#import "UIView+Function.h"
#import "UIScrollView+Function.h"
#import "UILabel+Function.h"
#import "ZLMath.h"
#import "UITools.h"

#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RandomColor                     [UIColor colorWithRed:(arc4random()%255)/255.0f green:(arc4random()%255)/255.0f blue:(arc4random()%255)/255.0f alpha:1.0f]
#define SCREEN_MAX_WIDTH                [UIScreen mainScreen].bounds.size.width
#define SCREEN_MAX_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define WeakSelf                        __weak typeof(self) weakSelf = self

#define HomePath        NSHomeDirectory()
#define DocumentsPath   ((NSString*)(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]))
#define CachePath       ((NSString*)(NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]))
#define TempPath        NSTemporaryDirectory();
