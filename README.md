# ZLCategory
整合一些常用的category类

 
支持cocoapod，
可以使用 pod ZLCategory 来导入

使用的时候可以导入总的头文件
```
#import "ZLCategory.h"
```
也可以按自己需要导入头文件

# 文档：

## NSDate+Function.h

```
// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes;

/***
 * 一些NSDate的比较函数
 ***/
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSString *)compareCurrentTime;

/***
 * 返回date的各个参数，年，月，日，时，分，秒（已经经过时区处理）
 ***/
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

/**
 *  获取自1970年的时间戳毫秒
 *
 *  @return 毫秒时间戳
 */
-(long long)getTimeIntervalSince1970Millisecond;
-(NSDate *)extractByDislodgeHour;
-(NSDate* )getDateFirstTime;
-(NSDate* )getDateLastTime;
/***
 * 判断是否在某个时间段内
 * 返回YES 或者 NO
 ***/
- (BOOL)isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
```

## NSString+Function.h

```
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
```

## UIColor+Function.h

```
@interface UIColor (Function)
/**
 *  传入红绿蓝返回UIColor
 *
 *  @param red green blue
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

/**
 *  16进制转uicolor
 *
 *  @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 *
 *  @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
```

## UIImage+Function.h

```
@interface UIImage (Function)

//图片是否有alpha层
- (BOOL)hasAlpha;

//返回一个给定图像的副本，如果还没有一个alpha通道，就添加一个alpha通道。
- (UIImage *)imageWithAlpha;

//返回一个图像的拷贝，它的边缘有一个透明的边界。如果图像没有alpha层，就会添加一个图层。
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

//给图片加圆角
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

//改变图片大小
- (UIImage *)croppedImage:(CGRect)bounds;

//返回一个与缩略图大小的图像的拷贝。
//如果透明边界是非零的，那么在缩略图的边缘会添加一个透明边框的边界。(添加一个至少一个像素的透明边框，在使用Core动画旋转时，会产生反锯齿的副作用。)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

//返回图像的重新复制，考虑到它的方向
//如果必要的话，图像将不成比例地缩放，以符合参数指定的范围。
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

//调整图像的大小，根据给定的内容模式，考虑图像的方位
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

//根据rect来截取图像某个矩形块的内容
- (UIImage *)cutoutImage:(CGRect)rect;

//图片转换
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data;
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url;

//图片缩放
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

@end
```

## UINavigationController+Function.h

```
@interface UINavigationController (Function)

//回退到指定页面
-(BOOL)popToViewController:(Class)vcClass;

@end
```

## UISlider+Function.h

```
@interface UISlider (Function)

// 为UISlider添加单击事件
- (void)addTapGestureWithTarget: (id)target
                         action: (SEL)action;

@end
```

## UITableView+Function.h

```
@interface UITableView (Function)

//是否隐藏多余的cell
@property (nonatomic,assign) BOOL hideExtraCell;

//当UITableView没有数据的时候需要展示的内容
- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
```

## UITools.h

```
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
NSInteger minuteInterval(NSDate* fromDate, NSDate* toDate);
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
```

## UIView+Function.h

```
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat ttScreenX;
@property (nonatomic, readonly) CGFloat ttScreenY;

@property (nonatomic, readonly) CGFloat screenViewX;
@property (nonatomic, readonly) CGFloat screenViewY;

@property (nonatomic, readonly) CGRect screenFrame;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

/******
 删除view里面所有的子view
 ******/
- (void) removeAllSubviews;

/******
 返回view所在的viewController
 ******/
- (UIViewController*) viewController;
- (void)transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view ;

/******
 将任意uiview转化成uiimage
 ******/
- (UIImage*) imageWithUIView;
- (void)setBorderWithView:(kAddLineDirectionOption)direction borderColor:(UIColor *)color borderWidth:(CGFloat)width;

/******
 从xib来加载uiview
 ******/
+ (instancetype)loadFromXib;

/**
 *  uiview的爆炸效果
 **/
- (void)lp_explode;

@end
```

## UIButton+Function.h  

```
/**
 倒计时：带 title，返回时间，title，具体使用看 demo
 
 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)ba_countDownWithTimeInterval:(NSTimeInterval)duration
                     countDownFormat:(NSString *)format;

/**
 倒计时：返回当前时间，可以自定义 title 和 image，具体使用看 demo
 
 @param duration 倒计时时间
 @param block 返回当前时间
 */
- (void)ba_countDownCustomWithTimeInterval:(NSTimeInterval)duration
                                     block:(BAKit_BAButtonCountDownBlock)block;

/**
 * 倒计时：结束，取消倒计时
 */
- (void)ba_cancelTimer;
```