//
//  NSString+function.h
//  zhuanxian
//
//  Created by zhaoliang chen on 2017/11/18.
//  Copyright © 2017年 huiling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Function)

/**< AES加密和解密 */
-(NSString *) aes128_encrypt:(NSString *)key;
-(NSString *) aes128_decrypt:(NSString *)key;

/* 获取到文本的宽度 */
-(float)getTextWidthfont:(UIFont *)font labelHeight:(float)height;

/* 获取文本的高度 */
-(float)getTextHeightfont:(UIFont *)font labelWidth:(float)width;

/* 去掉HTML标签 */
-(NSString *)flattenHTML;

/* 去掉内容前面的空格和回车 或者去掉空格 */
-(NSString *)removeWhitespaceAndNewlinewithboolNewLine:(BOOL)isSure;

/* md5加密 */
-(NSString *)md5Hash;
-(NSData *)sha1Hash;
-(NSData *)sha256;

/** 判断是否是电话号码 */
-(BOOL)validateMobile;

/** 判断是否是数字 */
-(BOOL)validateNum;

/** 判断是否是数字密码 */
-(BOOL)validatePwdRangeMin:(int)min rangeMax:(int)max;

/* 判断是否是邮箱 */
-(BOOL)validateEmail;
/* 判断是否为身份证 */
-(BOOL)validateIdentityCard;

/* 判断是否含有特定字符 */
-(BOOL)isContain:(NSString*)str;

/* 替换html标签的br和&nbsp; */
-(NSString *)filterHTML;

/* 只保留数字 */
-(NSString*)retainFigure;

-(NSString*)analysisHTML;

//判断是否为整形
-(BOOL)isPureInt;

//判断是否为浮点型
-(BOOL)isPureFloat;

// 作用:截取从value1到value2之间的字符串
- (NSMutableArray *)stringCutout:(NSString *)value1 value2:(NSString *)value2;

//过滤获得的匹配信息的下标
- (int)indexByValue:(NSString *)str;

#pragma mark 金币大小写 --> 封装的方法
- (NSString *)changetoBigMoney;

- (NSString *)htmlForTextSmall;

- (NSString *)htmlForImageFit;

//获取url的参数
- (NSString *)getParamByName:(NSString *)name;

//获取字符出现的次数
- (NSInteger)getSubStrCount:(NSString *)subStr;

//获取字符出现的位置数组
- (NSMutableArray *)getSubStrLocals:(NSString *)subStr;

//对比字符串不区分大小写
- (BOOL)isEqualToStringIgnoreCase:(NSString *)aString;

@end
