//
//  NSString+function.m
//  zhuanxian
//
//  Created by zhaoliang chen on 2017/11/18.
//  Copyright © 2017年 huiling. All rights reserved.
//

#import "NSString+Function.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Function)

size_t const kKeySize = kCCKeySizeAES128;
- (NSString *)aes128_encrypt:(NSString *)key {
    NSData *contentData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [key dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    free(encryptedBytes);
    return nil;
}

- (NSString *)aes128_decrypt:(NSString *)key {
    // 把 base64 String 转换成 Data
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    //[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [key dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}

- (float)getTextWidthfont:(UIFont *)font labelHeight:(float)height
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(1000000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size.width;
}

- (float)getTextHeightfont:(UIFont *)font labelWidth:(float)width {
    CGFloat height=0;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];
    height = rect.size.height;
    height+=20;
    return height;
}

- (NSString *)md5Hash {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSData *)sha1Hash {
    const char *cStr = [self UTF8String];
    unsigned char hashed[CC_SHA1_DIGEST_LENGTH];
    if (CC_SHA1(cStr, (CC_LONG)strlen(cStr), hashed)) {
        return [[NSData alloc] initWithBytes:hashed length:CC_SHA1_DIGEST_LENGTH];
    } else {
        return nil;
    }
}

- (NSData *)sha256 {
    const char *cStr = [self UTF8String];
    unsigned char hashed[CC_SHA256_DIGEST_LENGTH];
    if ( CC_SHA256(cStr, (CC_LONG)strlen(cStr), hashed) ) {
        return [[NSData alloc] initWithBytes:hashed length:CC_SHA256_DIGEST_LENGTH];
    } else {
        return nil;
    }
}

- (NSString *)flattenHTML {
    NSString *string=self;
    string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:self];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        string = [string stringByReplacingOccurrencesOfString:
                  [NSString stringWithFormat:@"%@>", text]
                                                   withString:@""];
        
    }
    return string;
    
}
-(NSString *)removeWhitespaceAndNewlinewithboolNewLine:(BOOL)isSure {
    if (isSure) {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    } else {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
}


-(BOOL)validateNum {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(\\d)$"] evaluateWithObject:self];
}

- (BOOL)validateMobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *string=self;
    NSRange range = [self rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        string = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    NSString *phoneRegex = @"(^((13[0-9])|(14[^7,\\D])|(17[^0,\\D])||(15[0-9])|(18[0-9]))\\d{8}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:string];
}

-(BOOL)validatePwdRangeMin:(int)min rangeMax:(int)max {
    NSString *pwdRegex = [NSString stringWithFormat:@"(^[0-9]{%d,%d}$)",min,max] ;
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwdRegex];
    return [pwdTest evaluateWithObject:self];
}

-(BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)validateIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)isContain:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    if (range.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)validateHex:(NSString *)number
{
    NSString *hexRegex = @"[0-9a-fA-F]+";
    NSPredicate *hexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",hexRegex];
    return [hexTest evaluateWithObject:number];
}


-(NSString *)filterHTML
{
    NSString* str = self;
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return str;
}

- (NSString*)retainFigure {
    return [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
}

- (NSString*)analysisHTML {
    NSString* str = self;
    str = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return str;
}

//判断是否为整形
- (BOOL)isPureInt {
    if (!self) {
        return NO;
    }
    if (self.length < 1) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点型
- (BOOL)isPureFloat {
    if (!self) {
        return NO;
    }
    if (self.length < 1) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

-(NSMutableArray *)stringCutout:(NSString *)value1 value2:(NSString *)value2 {
    NSMutableArray *array = [NSMutableArray new];
    NSString* oriStr = self;
    while (true) {
        NSUInteger startpt = 0;
        NSRange range1 = [oriStr rangeOfString:value1];
        if(range1.length>0){
            startpt = range1.location + range1.length;
            while (true) {
                oriStr = [oriStr substringFromIndex:startpt];
                NSRange range21 = [oriStr rangeOfString:value1];
                NSRange range22 = [oriStr rangeOfString:value2];
                if (range22.length == 0) {
                    break;
                }
                if (range21.location < range22.location) {
                    startpt = range21.location + range21.length;
                } else {
                    [array addObject:[oriStr substringToIndex:range22.location]];
                    oriStr = [oriStr substringFromIndex:range22.location+range22.length] ;
                    break;
                }
            }
        } else {
            break;
        }
    }
    return array;
}

//过滤获得的匹配信息的下标
-(int)indexByValue:(NSString *)str{
    //使用NSMutableString类，它可以实现追加
    NSMutableString *value = [[NSMutableString alloc] initWithFormat:@""];
    NSString *colum2 = @"";
    int j = 0;
    //遍历出下标值
    for(int i=1;i<[str length];i++){
        NSString *colum1 = [str substringFromIndex:i];
        [value appendString:colum2];
        colum2 = [colum1 substringToIndex:1];
        if([colum2 isEqualToString:@","]){
            j = [value intValue];
            break;
        }
    }
    return j;
}

#pragma mark 金币大小写 --> 封装的方法
- (NSString *)changetoBigMoney {
    //转化成double类型
    double numberals = [self doubleValue];
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    //NSLog(@"valstr: %@",valstr);
    NSString *prefix;
    NSString *suffix;
    //NSLog(@"%lu",(unsigned long)valstr.length);
    if (valstr.length <= 2) {
        prefix=@"零元";
        if (valstr.length == 0) {
            suffix = @"零角零分";
        } else if (valstr.length == 1) {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
        } else {
            NSString *head = [valstr substringToIndex:1];
            NSString *foot = [valstr substringFromIndex:1];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
        }
    } else {
        prefix=@"";
        suffix=@"";
        int flag = (int)valstr.length - 2;
        //NSLog(@"flag: %d",flag);
        NSString *head = [valstr substringToIndex:flag-1];
        NSLog(@"head: %@",head);
        NSString *foot = [valstr substringFromIndex:flag];
        NSLog(@"foot: %@",foot);
        if (head.length>13) {
            return @"数值太大（最大支持13位整数），无法处理";
        }
        //处理整数部分
        NSMutableArray * ch = [[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSLog(@"head[i]: %hu",[head characterAtIndex:i]);
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
            NSLog(@"ch: %@",ch);
        }
        NSLog(@"ch_All: %@",ch);
        int zeronum = 0;
        NSLog(@"ch.count: %ld",ch.count);
        for (int i = 0; i < ch.count; i++) {
            int index = (ch.count - i - 1) % 4;//取段内位置
            NSLog(@"index: %d",index);
            int indexloc = (int)(ch.count - i - 1) / 4;//取段位置
            NSLog(@"indexloc: %d",indexloc);
            NSLog(@"ch[i]: %@",[ch objectAtIndex:i]);
            if ([[ch objectAtIndex:i] isEqualToString:@"0"]) {
                zeronum++;
            } else {
                if (zeronum != 0) {
                    if (index != 3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum = 0;
                }
                prefix = [prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix = [prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index == 0 && zeronum < 4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix = [prefix stringByAppendingString:@"元"];
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        } else if ([foot hasPrefix:@"0"]) {
            NSString * footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix = [NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue]]];
        } else {
            NSString * headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString * footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix = [NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
        }
    }
    return [prefix stringByAppendingString:suffix];
}

- (NSString *)htmlForTextSmall {
    return [NSString stringWithFormat:@"<div style=\"text-align:justify; text-justify:inter-ideograph;\">%@",self];
}

- (NSString *)htmlForImageFit {
    return [NSString stringWithFormat:@"<html> \n"
            "<head> \n"
            "<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'> \n"
            "<style type=\"text/css\"> \n"
            "body {font-size:20px;}\n"
            "</style> \n"
            "</head> \n"
            "<body>"
            "<script type='text/javascript'>"
            "window.onload = function(){\n"
            "var $img = document.getElementsByTagName('img');\n"
            "for(var p in  $img){\n"
            //"var httpP = \"http://webapi.houno.cn\"+$img[p].getAttribute(\"src\");"
            //"$img[p].setAttribute(\"src\",httpP);"    // 这里发现拼接图片地址也能成功了。
            "$img[p].style.width = '92%%';\n"
            "$img[p].style.height ='auto'\n"
            "}\n"
            "}"
            "</script>%@"
            "</body>"
            "</html>",self];
}

- (NSString *)getParamByName:(NSString *)name {
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)", name];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:self
                                      options:0
                                        range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [self substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return @"";
}

- (NSInteger)getSubStrCount:(NSString *)subStr {
    NSInteger subStrCount = [self length] - [[self stringByReplacingOccurrencesOfString:subStr withString:@""] length];
    return subStrCount / [subStr length];
}

- (NSMutableArray *)getSubStrLocals:(NSString *)subStr {
    NSArray * separatedStrArr = [self componentsSeparatedByString:subStr];
    NSMutableArray * locMuArr = [[NSMutableArray alloc]init];
    
    NSInteger index = 0;
    for (NSInteger i = 0; i<separatedStrArr.count-1; i++) {
        NSString * separatedStr = separatedStrArr[i];
        index = index + separatedStr.length;
        NSNumber * loc_num = [NSNumber numberWithInteger:index];
        [locMuArr addObject:loc_num];
        index = index+subStr.length;
    }
    return locMuArr;
}

- (BOOL)isEqualToStringIgnoreCase:(NSString *)aString {
    // NSLiteralSearch 区分大小写(完全比较)
    // NSCaseInsensitiveSearch 不区分大小写
    // NSNumericSearch 只比较字符串的个数，而不比较字符串的字面值
    NSComparisonResult result1 = [self compare:aString options:NSCaseInsensitiveSearch | NSNumericSearch];
    if (result1 == NSOrderedSame) {
        return YES;
    } else {
        return NO;
    }
}

@end
