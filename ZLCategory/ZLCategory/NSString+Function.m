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

typedef struct {
    __unsafe_unretained NSString *escapeSequence;
    unichar uchar;
} HTMLEscapeMap;

// Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// Ordered by uchar lowest to highest for bsearching
static HTMLEscapeMap gAsciiHTMLEscapeMap[] = {
    // A.2.2. Special characters
    { @"&quot;", 34 },
    { @"&amp;", 38 },
    { @"&apos;", 39 },
    { @"&lt;", 60 },
    { @"&gt;", 62 },
    
    // A.2.1. Latin-1 characters
    { @"&nbsp;", 160 },
    { @"&iexcl;", 161 },
    { @"&cent;", 162 },
    { @"&pound;", 163 },
    { @"&curren;", 164 },
    { @"&yen;", 165 },
    { @"&brvbar;", 166 },
    { @"&sect;", 167 },
    { @"&uml;", 168 },
    { @"&copy;", 169 },
    { @"&ordf;", 170 },
    { @"&laquo;", 171 },
    { @"&not;", 172 },
    { @"&shy;", 173 },
    { @"&reg;", 174 },
    { @"&macr;", 175 },
    { @"&deg;", 176 },
    { @"&plusmn;", 177 },
    { @"&sup2;", 178 },
    { @"&sup3;", 179 },
    { @"&acute;", 180 },
    { @"&micro;", 181 },
    { @"&para;", 182 },
    { @"&middot;", 183 },
    { @"&cedil;", 184 },
    { @"&sup1;", 185 },
    { @"&ordm;", 186 },
    { @"&raquo;", 187 },
    { @"&frac14;", 188 },
    { @"&frac12;", 189 },
    { @"&frac34;", 190 },
    { @"&iquest;", 191 },
    { @"&Agrave;", 192 },
    { @"&Aacute;", 193 },
    { @"&Acirc;", 194 },
    { @"&Atilde;", 195 },
    { @"&Auml;", 196 },
    { @"&Aring;", 197 },
    { @"&AElig;", 198 },
    { @"&Ccedil;", 199 },
    { @"&Egrave;", 200 },
    { @"&Eacute;", 201 },
    { @"&Ecirc;", 202 },
    { @"&Euml;", 203 },
    { @"&Igrave;", 204 },
    { @"&Iacute;", 205 },
    { @"&Icirc;", 206 },
    { @"&Iuml;", 207 },
    { @"&ETH;", 208 },
    { @"&Ntilde;", 209 },
    { @"&Ograve;", 210 },
    { @"&Oacute;", 211 },
    { @"&Ocirc;", 212 },
    { @"&Otilde;", 213 },
    { @"&Ouml;", 214 },
    { @"&times;", 215 },
    { @"&Oslash;", 216 },
    { @"&Ugrave;", 217 },
    { @"&Uacute;", 218 },
    { @"&Ucirc;", 219 },
    { @"&Uuml;", 220 },
    { @"&Yacute;", 221 },
    { @"&THORN;", 222 },
    { @"&szlig;", 223 },
    { @"&agrave;", 224 },
    { @"&aacute;", 225 },
    { @"&acirc;", 226 },
    { @"&atilde;", 227 },
    { @"&auml;", 228 },
    { @"&aring;", 229 },
    { @"&aelig;", 230 },
    { @"&ccedil;", 231 },
    { @"&egrave;", 232 },
    { @"&eacute;", 233 },
    { @"&ecirc;", 234 },
    { @"&euml;", 235 },
    { @"&igrave;", 236 },
    { @"&iacute;", 237 },
    { @"&icirc;", 238 },
    { @"&iuml;", 239 },
    { @"&eth;", 240 },
    { @"&ntilde;", 241 },
    { @"&ograve;", 242 },
    { @"&oacute;", 243 },
    { @"&ocirc;", 244 },
    { @"&otilde;", 245 },
    { @"&ouml;", 246 },
    { @"&divide;", 247 },
    { @"&oslash;", 248 },
    { @"&ugrave;", 249 },
    { @"&uacute;", 250 },
    { @"&ucirc;", 251 },
    { @"&uuml;", 252 },
    { @"&yacute;", 253 },
    { @"&thorn;", 254 },
    { @"&yuml;", 255 },
    
    // A.2.2. Special characters cont'd
    { @"&OElig;", 338 },
    { @"&oelig;", 339 },
    { @"&Scaron;", 352 },
    { @"&scaron;", 353 },
    { @"&Yuml;", 376 },
    
    // A.2.3. Symbols
    { @"&fnof;", 402 },
    
    // A.2.2. Special characters cont'd
    { @"&circ;", 710 },
    { @"&tilde;", 732 },
    
    // A.2.3. Symbols cont'd
    { @"&Alpha;", 913 },
    { @"&Beta;", 914 },
    { @"&Gamma;", 915 },
    { @"&Delta;", 916 },
    { @"&Epsilon;", 917 },
    { @"&Zeta;", 918 },
    { @"&Eta;", 919 },
    { @"&Theta;", 920 },
    { @"&Iota;", 921 },
    { @"&Kappa;", 922 },
    { @"&Lambda;", 923 },
    { @"&Mu;", 924 },
    { @"&Nu;", 925 },
    { @"&Xi;", 926 },
    { @"&Omicron;", 927 },
    { @"&Pi;", 928 },
    { @"&Rho;", 929 },
    { @"&Sigma;", 931 },
    { @"&Tau;", 932 },
    { @"&Upsilon;", 933 },
    { @"&Phi;", 934 },
    { @"&Chi;", 935 },
    { @"&Psi;", 936 },
    { @"&Omega;", 937 },
    { @"&alpha;", 945 },
    { @"&beta;", 946 },
    { @"&gamma;", 947 },
    { @"&delta;", 948 },
    { @"&epsilon;", 949 },
    { @"&zeta;", 950 },
    { @"&eta;", 951 },
    { @"&theta;", 952 },
    { @"&iota;", 953 },
    { @"&kappa;", 954 },
    { @"&lambda;", 955 },
    { @"&mu;", 956 },
    { @"&nu;", 957 },
    { @"&xi;", 958 },
    { @"&omicron;", 959 },
    { @"&pi;", 960 },
    { @"&rho;", 961 },
    { @"&sigmaf;", 962 },
    { @"&sigma;", 963 },
    { @"&tau;", 964 },
    { @"&upsilon;", 965 },
    { @"&phi;", 966 },
    { @"&chi;", 967 },
    { @"&psi;", 968 },
    { @"&omega;", 969 },
    { @"&thetasym;", 977 },
    { @"&upsih;", 978 },
    { @"&piv;", 982 },
    
    // A.2.2. Special characters cont'd
    { @"&ensp;", 8194 },
    { @"&emsp;", 8195 },
    { @"&thinsp;", 8201 },
    { @"&zwnj;", 8204 },
    { @"&zwj;", 8205 },
    { @"&lrm;", 8206 },
    { @"&rlm;", 8207 },
    { @"&ndash;", 8211 },
    { @"&mdash;", 8212 },
    { @"&lsquo;", 8216 },
    { @"&rsquo;", 8217 },
    { @"&sbquo;", 8218 },
    { @"&ldquo;", 8220 },
    { @"&rdquo;", 8221 },
    { @"&bdquo;", 8222 },
    { @"&dagger;", 8224 },
    { @"&Dagger;", 8225 },
    // A.2.3. Symbols cont'd
    { @"&bull;", 8226 },
    { @"&hellip;", 8230 },
    
    // A.2.2. Special characters cont'd
    { @"&permil;", 8240 },
    
    // A.2.3. Symbols cont'd
    { @"&prime;", 8242 },
    { @"&Prime;", 8243 },
    
    // A.2.2. Special characters cont'd
    { @"&lsaquo;", 8249 },
    { @"&rsaquo;", 8250 },
    
    // A.2.3. Symbols cont'd
    { @"&oline;", 8254 },
    { @"&frasl;", 8260 },
    
    // A.2.2. Special characters cont'd
    { @"&euro;", 8364 },
    
    // A.2.3. Symbols cont'd
    { @"&image;", 8465 },
    { @"&weierp;", 8472 },
    { @"&real;", 8476 },
    { @"&trade;", 8482 },
    { @"&alefsym;", 8501 },
    { @"&larr;", 8592 },
    { @"&uarr;", 8593 },
    { @"&rarr;", 8594 },
    { @"&darr;", 8595 },
    { @"&harr;", 8596 },
    { @"&crarr;", 8629 },
    { @"&lArr;", 8656 },
    { @"&uArr;", 8657 },
    { @"&rArr;", 8658 },
    { @"&dArr;", 8659 },
    { @"&hArr;", 8660 },
    { @"&forall;", 8704 },
    { @"&part;", 8706 },
    { @"&exist;", 8707 },
    { @"&empty;", 8709 },
    { @"&nabla;", 8711 },
    { @"&isin;", 8712 },
    { @"&notin;", 8713 },
    { @"&ni;", 8715 },
    { @"&prod;", 8719 },
    { @"&sum;", 8721 },
    { @"&minus;", 8722 },
    { @"&lowast;", 8727 },
    { @"&radic;", 8730 },
    { @"&prop;", 8733 },
    { @"&infin;", 8734 },
    { @"&ang;", 8736 },
    { @"&and;", 8743 },
    { @"&or;", 8744 },
    { @"&cap;", 8745 },
    { @"&cup;", 8746 },
    { @"&int;", 8747 },
    { @"&there4;", 8756 },
    { @"&sim;", 8764 },
    { @"&cong;", 8773 },
    { @"&asymp;", 8776 },
    { @"&ne;", 8800 },
    { @"&equiv;", 8801 },
    { @"&le;", 8804 },
    { @"&ge;", 8805 },
    { @"&sub;", 8834 },
    { @"&sup;", 8835 },
    { @"&nsub;", 8836 },
    { @"&sube;", 8838 },
    { @"&supe;", 8839 },
    { @"&oplus;", 8853 },
    { @"&otimes;", 8855 },
    { @"&perp;", 8869 },
    { @"&sdot;", 8901 },
    { @"&lceil;", 8968 },
    { @"&rceil;", 8969 },
    { @"&lfloor;", 8970 },
    { @"&rfloor;", 8971 },
    { @"&lang;", 9001 },
    { @"&rang;", 9002 },
    { @"&loz;", 9674 },
    { @"&spades;", 9824 },
    { @"&clubs;", 9827 },
    { @"&hearts;", 9829 },
    { @"&diams;", 9830 }
};

// Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// This is table A.2.2 Special Characters
static HTMLEscapeMap gUnicodeHTMLEscapeMap[] = {
    // C0 Controls and Basic Latin
    { @"&quot;", 34 },
    { @"&amp;", 38 },
    { @"&apos;", 39 },
    { @"&lt;", 60 },
    { @"&gt;", 62 },
    
    // Latin Extended-A
    { @"&OElig;", 338 },
    { @"&oelig;", 339 },
    { @"&Scaron;", 352 },
    { @"&scaron;", 353 },
    { @"&Yuml;", 376 },
    
    // Spacing Modifier Letters
    { @"&circ;", 710 },
    { @"&tilde;", 732 },
    
    // General Punctuation
    { @"&ensp;", 8194 },
    { @"&emsp;", 8195 },
    { @"&thinsp;", 8201 },
    { @"&zwnj;", 8204 },
    { @"&zwj;", 8205 },
    { @"&lrm;", 8206 },
    { @"&rlm;", 8207 },
    { @"&ndash;", 8211 },
    { @"&mdash;", 8212 },
    { @"&lsquo;", 8216 },
    { @"&rsquo;", 8217 },
    { @"&sbquo;", 8218 },
    { @"&ldquo;", 8220 },
    { @"&rdquo;", 8221 },
    { @"&bdquo;", 8222 },
    { @"&dagger;", 8224 },
    { @"&Dagger;", 8225 },
    { @"&permil;", 8240 },
    { @"&lsaquo;", 8249 },
    { @"&rsaquo;", 8250 },
    { @"&euro;", 8364 },
};

// Utility function for Bsearching table above
static int EscapeMapCompare(const void *ucharVoid, const void *mapVoid) {
    const unichar *uchar = (const unichar*)ucharVoid;
    const HTMLEscapeMap *map = (const HTMLEscapeMap*)mapVoid;
    int val;
    if (*uchar > map->uchar) {
        val = 1;
    } else if (*uchar < map->uchar) {
        val = -1;
    } else {
        val = 0;
    }
    return val;
}

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

#pragma mark 处理html的方法
- (NSString *)stringByConvertingHTMLToPlainText {
    // Character sets
    NSCharacterSet *stopCharacters = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"< \t\n\r%d%d%d%d", 0x0085, 0x000C, 0x2028, 0x2029]];
    NSCharacterSet *newLineAndWhitespaceCharacters = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@" \t\n\r%d%d%d%d", 0x0085, 0x000C, 0x2028, 0x2029]];
    NSCharacterSet *tagNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    
    // Scan and find all tags
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:self.length];
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    [scanner setCaseSensitive:YES];
    NSString *str = nil, *tagName = nil;
    BOOL dontReplaceTagWithSpace = NO;
    do {
        
        // Scan up to the start of a tag or whitespace
        if ([scanner scanUpToCharactersFromSet:stopCharacters intoString:&str]) {
            [result appendString:str];
            str = nil; // reset
        }
        
        // Check if we've stopped at a tag/comment or whitespace
        if ([scanner scanString:@"<" intoString:NULL]) {
            
            // Stopped at a comment or tag
            if ([scanner scanString:@"!--" intoString:NULL]) {
                
                // Comment
                [scanner scanUpToString:@"-->" intoString:NULL];
                [scanner scanString:@"-->" intoString:NULL];
                
            } else {
                
                // Tag - remove and replace with space unless it's
                // a closing inline tag then dont replace with a space
                if ([scanner scanString:@"/" intoString:NULL]) {
                    
                    // Closing tag - replace with space unless it's inline
                    tagName = nil; dontReplaceTagWithSpace = NO;
                    if ([scanner scanCharactersFromSet:tagNameCharacters intoString:&tagName]) {
                        tagName = [tagName lowercaseString];
                        dontReplaceTagWithSpace = ([tagName isEqualToString:@"a"] ||
                                                   [tagName isEqualToString:@"b"] ||
                                                   [tagName isEqualToString:@"i"] ||
                                                   [tagName isEqualToString:@"q"] ||
                                                   [tagName isEqualToString:@"span"] ||
                                                   [tagName isEqualToString:@"em"] ||
                                                   [tagName isEqualToString:@"strong"] ||
                                                   [tagName isEqualToString:@"cite"] ||
                                                   [tagName isEqualToString:@"abbr"] ||
                                                   [tagName isEqualToString:@"acronym"] ||
                                                   [tagName isEqualToString:@"label"]);
                    }
                    // Replace tag with string unless it was an inline
                    if (!dontReplaceTagWithSpace && result.length > 0 && ![scanner isAtEnd]) [result appendString:@" "];
                }
                // Scan past tag
                [scanner scanUpToString:@">" intoString:NULL];
                [scanner scanString:@">" intoString:NULL];
            }
        } else {
            // Stopped at whitespace - replace all whitespace and newlines with a space
            if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
                if (result.length > 0 && ![scanner isAtEnd]) [result appendString:@" "]; // Dont append space to beginning or end of result
            }
        }
    } while (![scanner isAtEnd]);
    NSString *retString = [result stringByDecodingHTMLEntities];
    return retString;
}

- (NSString *)stringByDecodingHTMLEntities {
    // Can return self so create new string if we're a mutable string
    return [NSString stringWithString:[self gtm_stringByUnescapingFromHTML]];
}


- (NSString *)stringByEncodingHTMLEntities {
    // Can return self so create new string if we're a mutable string
    return [NSString stringWithString:[self gtm_stringByEscapingForAsciiHTML]];
}

- (NSString *)stringByEncodingHTMLEntities:(BOOL)isUnicode {
    // Can return self so create new string if we're a mutable string
    return [NSString stringWithString:(isUnicode ? [self gtm_stringByEscapingForHTML] : [self gtm_stringByEscapingForAsciiHTML])];
}

- (NSString *)gtm_stringByEscapingHTMLUsingTable:(HTMLEscapeMap*)table
                                          ofSize:(NSUInteger)size
                                 escapingUnicode:(BOOL)escapeUnicode {
    NSUInteger length = [self length];
    if (!length) {
        return self;
    }
    
    NSMutableString *finalString = [NSMutableString string];
    NSMutableData *data2 = [NSMutableData dataWithCapacity:sizeof(unichar) * length];
    
    // this block is common between GTMNSString+HTML and GTMNSString+XML but
    // it's so short that it isn't really worth trying to share.
    const unichar *buffer = CFStringGetCharactersPtr((CFStringRef)self);
    if (!buffer) {
        // We want this buffer to be autoreleased.
        NSMutableData *data = [NSMutableData dataWithLength:length * sizeof(UniChar)];
        if (!data) {
            // COV_NF_START  - Memory fail case
            //            _GTMDevLog(@"couldn't alloc buffer");
            return nil;
            // COV_NF_END
        }
        [self getCharacters:[data mutableBytes]];
        buffer = [data bytes];
    }
    
    if (!buffer || !data2) {
        // COV_NF_START
        //        _GTMDevLog(@"Unable to allocate buffer or data2");
        return nil;
        // COV_NF_END
    }
    
    unichar *buffer2 = (unichar *)[data2 mutableBytes];
    
    NSUInteger buffer2Length = 0;
    
    for (NSUInteger i = 0; i < length; ++i) {
        HTMLEscapeMap *val = bsearch(&buffer[i], table,
                                     size / sizeof(HTMLEscapeMap),
                                     sizeof(HTMLEscapeMap), EscapeMapCompare);
        if (val || (escapeUnicode && buffer[i] > 127)) {
            if (buffer2Length) {
                CFStringAppendCharacters((CFMutableStringRef)finalString,
                                         buffer2,
                                         buffer2Length);
                buffer2Length = 0;
            }
            if (val) {
                [finalString appendString:val->escapeSequence];
            }
            else {
                //                _GTMDevAssert(escapeUnicode && buffer[i] > 127, @"Illegal Character");
                [finalString appendFormat:@"&#%d;", buffer[i]];
            }
        } else {
            buffer2[buffer2Length] = buffer[i];
            buffer2Length += 1;
        }
    }
    if (buffer2Length) {
        CFStringAppendCharacters((CFMutableStringRef)finalString,
                                 buffer2,
                                 buffer2Length);
    }
    return finalString;
}

- (NSString *)gtm_stringByEscapingForHTML {
    return [self gtm_stringByEscapingHTMLUsingTable:gUnicodeHTMLEscapeMap
                                             ofSize:sizeof(gUnicodeHTMLEscapeMap)
                                    escapingUnicode:NO];
} // gtm_stringByEscapingHTML

- (NSString *)gtm_stringByEscapingForAsciiHTML {
    return [self gtm_stringByEscapingHTMLUsingTable:gAsciiHTMLEscapeMap
                                             ofSize:sizeof(gAsciiHTMLEscapeMap)
                                    escapingUnicode:YES];
} // gtm_stringByEscapingAsciiHTML

- (NSString *)gtm_stringByUnescapingFromHTML {
    NSRange range = NSMakeRange(0, [self length]);
    NSRange subrange = [self rangeOfString:@"&" options:NSBackwardsSearch range:range];
    
    // if no ampersands, we've got a quick way out
    if (subrange.length == 0) return self;
    NSMutableString *finalString = [NSMutableString stringWithString:self];
    do {
        NSRange semiColonRange = NSMakeRange(subrange.location, NSMaxRange(range) - subrange.location);
        semiColonRange = [self rangeOfString:@";" options:0 range:semiColonRange];
        range = NSMakeRange(0, subrange.location);
        // if we don't find a semicolon in the range, we don't have a sequence
        if (semiColonRange.location == NSNotFound) {
            continue;
        }
        NSRange escapeRange = NSMakeRange(subrange.location, semiColonRange.location - subrange.location + 1);
        NSString *escapeString = [self substringWithRange:escapeRange];
        NSUInteger length = [escapeString length];
        // a squence must be longer than 3 (&lt;) and less than 11 (&thetasym;)
        if (length > 3 && length < 11) {
            if ([escapeString characterAtIndex:1] == '#') {
                unichar char2 = [escapeString characterAtIndex:2];
                if (char2 == 'x' || char2 == 'X') {
                    // Hex escape squences &#xa3;
                    NSString *hexSequence = [escapeString substringWithRange:NSMakeRange(3, length - 4)];
                    NSScanner *scanner = [NSScanner scannerWithString:hexSequence];
                    unsigned value;
                    if ([scanner scanHexInt:&value] &&
                        value < USHRT_MAX &&
                        value > 0
                        && [scanner scanLocation] == length - 4) {
                        unichar uchar = value;
                        NSString *charString = [NSString stringWithCharacters:&uchar length:1];
                        [finalString replaceCharactersInRange:escapeRange withString:charString];
                    }
                    
                } else {
                    // Decimal Sequences &#123;
                    NSString *numberSequence = [escapeString substringWithRange:NSMakeRange(2, length - 3)];
                    NSScanner *scanner = [NSScanner scannerWithString:numberSequence];
                    int value;
                    if ([scanner scanInt:&value] &&
                        value < USHRT_MAX &&
                        value > 0
                        && [scanner scanLocation] == length - 3) {
                        unichar uchar = value;
                        NSString *charString = [NSString stringWithCharacters:&uchar length:1];
                        [finalString replaceCharactersInRange:escapeRange withString:charString];
                    }
                }
            } else {
                // "standard" sequences
                for (unsigned i = 0; i < sizeof(gAsciiHTMLEscapeMap) / sizeof(HTMLEscapeMap); ++i) {
                    if ([escapeString isEqualToString:gAsciiHTMLEscapeMap[i].escapeSequence]) {
                        [finalString replaceCharactersInRange:escapeRange withString:[NSString stringWithCharacters:&gAsciiHTMLEscapeMap[i].uchar length:1]];
                        break;
                    }
                }
            }
        }
    } while ((subrange = [self rangeOfString:@"&" options:NSBackwardsSearch range:range]).length != 0);
    return finalString;
} // gtm_stringByUnescapingHTML

- (NSString *)stringWithNewLinesAsBRs {
    // Strange New lines:
    //  Next Line, U+0085
    //  Form Feed, U+000C
    //  Line Separator, U+2028
    //  Paragraph Separator, U+2029
    
    // Scanner
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *temp;
    NSCharacterSet *newLineCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                         [NSString stringWithFormat:@"\n\r%d%d%d%d", 0x0085, 0x000C, 0x2028, 0x2029]];
    // Scan
    do {
        
        // Get non new line characters
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        temp = nil;
        
        // Add <br /> s
        if ([scanner scanString:@"\r\n" intoString:nil]) {
            
            // Combine \r\n into just 1 <br />
            [result appendString:@"<br />"];
            
        } else if ([scanner scanCharactersFromSet:newLineCharacters intoString:&temp]) {
            
            // Scan other new line characters and add <br /> s
            if (temp) {
                for (NSUInteger i = 0; i < temp.length; i++) {
                    [result appendString:@"<br />"];
                }
            }
            
        }
        
    } while (![scanner isAtEnd]);
    
    // Cleanup & return
    NSString *retString = [NSString stringWithString:result];
    
    // Return
    return retString;
    
}

- (NSString *)stringByRemovingNewLinesAndWhitespace {
    
    // Strange New lines:
    //  Next Line, U+0085
    //  Form Feed, U+000C
    //  Line Separator, U+2028
    //  Paragraph Separator, U+2029
    
    // Scanner
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *temp;
    NSCharacterSet *newLineAndWhitespaceCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                                      [NSString stringWithFormat:@" \t\n\r%d%d%d%d", 0x0085, 0x000C, 0x2028, 0x2029]];
    // Scan
    while (![scanner isAtEnd]) {
        
        // Get non new line or whitespace characters
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        
        // Replace with a space
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@" "];
        }
        
    }
    
    // Return
    NSString *retString = [NSString stringWithString:result];
    
    // Return
    return retString ;
    
}

- (NSString *)stringByLinkifyingURLs {
    if (!NSClassFromString(@"NSRegularExpression")) return self;
    NSString *pattern = @"(?<!=\")\\b((http|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%%&amp;:/~\\+#]*[\\w\\-\\@?^=%%&amp;/~\\+#])?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length])
                                                          withTemplate:@"<a href=\"$1\" class=\"linkified\">$1</a>"];
    return modifiedString ;
}

- (NSString *)stringByStrippingTags {
    // Find first & and short-cut if we can
    NSUInteger ampIndex = [self rangeOfString:@"<" options:NSLiteralSearch].location;
    if (ampIndex == NSNotFound) {
        return [NSString stringWithString:self]; // return copy of string as no tags found
    }
    
    // Scan and find all tags
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableSet *tags = [[NSMutableSet alloc] init];
    NSString *tag;
    do {
        
        // Scan up to <
        tag = nil;
        [scanner scanUpToString:@"<" intoString:NULL];
        [scanner scanUpToString:@">" intoString:&tag];
        
        // Add to set
        if (tag) {
            NSString *t = [[NSString alloc] initWithFormat:@"%@>", tag];
            [tags addObject:t];
        }
        
    } while (![scanner isAtEnd]);
    
    // Strings
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    NSString *finalString;
    
    // Replace tags
    NSString *replacement;
    for (NSString *t in tags) {
        
        // Replace tag with space unless it's an inline element
        replacement = @" ";
        if ([t isEqualToString:@"<a>"] ||
            [t isEqualToString:@"</a>"] ||
            [t isEqualToString:@"<span>"] ||
            [t isEqualToString:@"</span>"] ||
            [t isEqualToString:@"<strong>"] ||
            [t isEqualToString:@"</strong>"] ||
            [t isEqualToString:@"<em>"] ||
            [t isEqualToString:@"</em>"]) {
            replacement = @"";
        }
        
        // Replace
        [result replaceOccurrencesOfString:t
                                withString:replacement
                                   options:NSLiteralSearch
                                     range:NSMakeRange(0, result.length)];
    }
    
    // Remove multi-spaces and line breaks
    finalString = [result stringByRemovingNewLinesAndWhitespace];
    
    return finalString;
    
}

static NSDictionary *htmlEscapes = nil;
static NSDictionary *htmlUnescapes = nil;

+ (NSDictionary *)htmlEscapes {
    if (!htmlEscapes) {
        htmlEscapes = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"&amp;", @"&",
                       @"&lt;", @"<",
                       @"&gt;", @">",
                       nil
                       ];
    }
    return htmlEscapes;
}

+ (NSDictionary *)htmlUnescapes {
    if (!htmlUnescapes) {
        htmlUnescapes = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"\n", @"<br>",
                         @"\n", @"<p>",
                         @"", @"</p>",
                         @"", @"<ol>",
                         @"", @"</ol>",
                         @"", @"<li>",
                         @"\n", @"</li>",
                         @"", @"<em>",
                         @"", @"</em>",
                         @"", @"<div>",
                         @"\n", @"</div>",
                         @"", @"<b>",
                         @"", @"</b>",
                         @"", @"<i>",
                         @"", @"</i>",
                         @"", @"<span>",
                         @"", @"</span>",
                         @"", @"<strong>",
                         @"", @"</strong>",
                         @"&", @"&amp;",
                         @"<", @"&lt;",
                         @">", @"&gt;",
                         //@"\n", @"&nbsp;",
                         nil
                         ];
    }
    return htmlUnescapes;
}

static NSString *replaceAll(NSString *s, NSDictionary *replacements) {
    for (NSString *key in replacements) {
        NSString *replacement = [replacements objectForKey:key];
        s = [s stringByReplacingOccurrencesOfString:key withString:replacement];
    }
    return s;
}

- (NSString *)htmlEscapedString {
    return replaceAll(self, [[self class] htmlEscapes]);
}

- (NSString *)htmlUnescapedString {
    return replaceAll(self, [[self class] htmlUnescapes]);
}

//访问网页源码
-(NSString *)urlString:(NSString *)value{
    NSURL *url = [NSURL URLWithString:value];
    NSData *data = [NSData dataWithContentsOfURL:url];
    //解决中文乱码,用GBK
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    return retStr;
}
/*
 作用:截取从value1到value2之间的字符串
 str:要处理的字符串
 value1:左边匹配字符串
 value2:右边匹配字符串
 */
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

@end
