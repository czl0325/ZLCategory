//
//  UITools.h
//  PetClaw
//
//  Created by yihang zhuang on 11/1/12.
//  Copyright (c) 2012 ZQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSDate+Function.h"

/***
 * 将NSDate类型转化成NSString
 * 格式为:"2018-01-01"
 ***/
NSString *formatDateToString( NSDate *date );
/***
 * 将NSDate类型转化成NSString
 * 格式为:"2018-01-01 00:00:00"
 ***/
NSString *formatDateToStringALL( NSDate *date );
/***
 * 将NSDate类型转化成NSString
 * 格式为:"2018-01-01 00:00:00.000"
 ***/
NSString *formatDateToStringALLEx( NSDate *date );
/***
 * 将NSString类型转化成NSDate，只含年月日
 * 格式为:"2018-01-01"
 ***/
NSDate *formatStringToDate( NSString *string );
/***
 * 将NSString类型转化成NSDate，含年月日时分秒
 * 格式为:"2018-01-01 00:00:00.000"
 ***/
NSDate *formatStringToDateEx( NSString *string );
/***
 * 将NSString类型转化成NSDate，含年月日时分秒 以及毫秒
 * 格式为:"2018-01-01 00:00:00.000"
 ***/
NSDate *formatStringToDateMilli( NSString *string );

/***
 * 判断系统是12小时制还是24小时制
 * 返回YES 或者 NO
 ***/
BOOL is12Hours(void);

/***
 * 根据长度返回一串随机的字符串
 * 返回NSString
 ***/
NSString *genRandomString(int length);

UIImage *roundCorners(UIImage* img);
void myAddRoundedRectToPath(CGContextRef context, CGRect rect,
                          float ovalWidth,float ovalHeight);
/***
 * view的消失动画
 ***/
void exChangeOut(UIView * changeOutView);


/***
 * 判断是否是同一天
 * 返回YES 或者 NO
 ***/
BOOL isSameDay(NSDate* date1, NSDate* date2);
/***
 * 计算两个时间点相距几分钟
 ***/
long minuteInterval(NSDate* fromDate, NSDate* toDate);
/***
 * 创建一个uiimage，通过传入颜色，大小，以及透明度
 ***/
UIImage *imageWithColor(UIColor *color, CGSize size ,float alpha);

/***
 * 获取app的启动页
 ***/
UIImage *launchImage(void);
UIImage *launchImageWithType(NSString *type);
/***
 * 获取app的图标
 ***/
UIImage *appIcon(void);

//创建一个线条
UIView* createView(UIColor* color);









