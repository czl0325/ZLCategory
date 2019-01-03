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


/************  处理html的方法   *****************/
// Strips HTML tags & comments, removes extra whitespace and decodes HTML character entities.
- (NSString *)stringByConvertingHTMLToPlainText;

// Decode all HTML entities using GTM.
- (NSString *)stringByDecodingHTMLEntities;

// Encode all HTML entities using GTM.
- (NSString *)stringByEncodingHTMLEntities;

- (NSString *)gtm_stringByEscapingForHTML;
- (NSString *)gtm_stringByEscapingForAsciiHTML;
- (NSString *)gtm_stringByUnescapingFromHTML;

// Minimal unicode encoding will only cover characters from table
// A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// which is what you want for a unicode encoded webpage.
- (NSString *)stringByEncodingHTMLEntities:(BOOL)isUnicode;

// Replace newlines with <br /> tags.
- (NSString *)stringWithNewLinesAsBRs;

// Remove newlines and white space from string.
- (NSString *)stringByRemovingNewLinesAndWhitespace;

// Wrap plain URLs in <a href="..." class="linkified">...</a>
//  - Ignores URLs inside tags (any URL beginning with =")
//  - HTTP & HTTPS schemes only
//  - Only works in iOS 4+ as we use NSRegularExpression (returns self if not supported so be careful with NSMutableStrings)
//  - Expression: (?<!=")\b((http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?)
//  - Adapted from http://regexlib.com/REDetails.aspx?regexp_id=96
- (NSString *)stringByLinkifyingURLs;

// DEPRECIATED - Please use NSString stringByConvertingHTMLToPlainText
- (NSString *)stringByStrippingTags __attribute__((deprecated));

+ (NSDictionary *)htmlEscapes;
+ (NSDictionary *)htmlUnescapes;
- (NSString *)htmlEscapedString;
- (NSString *)htmlUnescapedString;

//访问网页源码
- (NSString *)urlString:(NSString *)value;
/*
 作用:截取从value1到value2之间的字符串
 str:要处理的字符串
 value1:左边匹配字符串
 value2:右边匹配字符串
 */
- (NSMutableArray *)stringCutout:(NSString *)value1 value2:(NSString *)value2;
//过滤获得的匹配信息的下标
- (int)indexByValue:(NSString *)str;

#pragma mark 金币大小写 --> 封装的方法
- (NSString *)changetoBigMoney;

- (NSString *)htmlForTextSmall;

- (NSString *)htmlForImageFit;

@end
