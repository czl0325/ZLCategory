# ZLCategory

整合一些ios各种常用的category类

支持cocoapod，
```
pod ZLCategory
```

使用的时候可以导入总的头文件,也可以按自己需要导入头文件
```
#import "ZLCategory.h"
```

## APIs

* ### NSDate 相关 -> NSDate+Function.h

#####  成员函数
```
dateTomorrow                        : 获取明天
dateYesterday                       : 获取昨天
dateWithDaysFromNow                 : 某个时间点往后几天
dateWithDaysBeforeNow               : 某个时间点往前几天
dateWithHoursFromNow                : 某个时间点往后几个小时
dateWithHoursBeforeNow              : 某个时间点往前几个小时
dateWithMinutesFromNow              : 某个时间点往后几分钟
dateWithMinutesBeforeNow            : 某个时间点往前几分钟
isEqualToDateIgnoringTime           : 日期相等，忽略时分秒
isToday                             : 是否今天
isTomorrow                          : 是否明天
isYesterday                         : 是否昨天
isSameWeekAsDate                    : 是否同一周
isThisWeek                          : 是否本周
isNextWeek                          : 是否下周
isLastWeek                          : 是否上周
isSameYearAsDate                    : 是否同一年
isThisYear                          : 是否今年
isNextYear                          : 是否明年
isLastYear                          : 是否前一年
isEarlierThanDate                   : 是否比某个日期早
isLaterThanDate                     : 是否比某个日期晚
dateByAddingDays                    : 某个日期加几天
dateBySubtractingDays               : 某个日期减几天
dateByAddingHours                   : 某个时间点加几个小时
dateBySubtractingHours              : 某个时间点减几个小时
dateByAddingMinutes                 : 某个时间点加几分钟
dateBySubtractingMinutes            : 某个时间点减几分钟
dateAtStartOfDay                    : 某一天的00：00：00
compareCurrentTime                  : 对比当前时间
extractByDislodgeHour               : 移除日期的时分秒
getDateFirstTime                    : 获取某天的00：00：00
getDateLastTime                     : 获取某天的23：59：59
isBetweenDate                       : 是否在某个时间段内
```


#####  成员变量

```
nearestHour                         : 小时
hour                                : 小时
minute                              : 分
seconds                             : 秒
day                                 : 日
month                               : 月
week                                : 周
weekday                             : 周
nthWeekday                          : 星期
year                                : 年


```

* ### NSString 相关 -> NSString+Function.h

```
aes128_encrypt                      : AES加密
aes128_decrypt                      : AES解密
getTextWidthfont                    : 获取到文本的宽度 
getTextHeightfont                   : 获取文本的高度
flattenHTML                         : 去掉HTML标签
emoveWhitespaceAndNewlinewithboolNewLine: 去掉内容前面的空格和回车 或者去掉空格
md5Hash                             : md5加密
sha1Hash                            : sha1加密
sha256                              : sha256加密
validateMobile                      : 是否电话号码
validateNum                         : 是否是数字
validatePwdRangeMin                 : 是否是数字密码
validateEmail                       : 是否是邮箱
validateIdentityCard                : 是否为身份证
isContain                           : 是否含有特定字符
filterHTML                          : 替换html标签的br和&nbsp; 
retainFigure                        : 只保留数字
analysisHTML                        : 处理html字符串
isPureInt                           : 是否为整形
isPureFloat                         : 是否为浮点型
stringCutout                        : 截取从value1到value2之间的字符串
indexByValue                        : 获得的匹配信息的下标
getParamByName                      : 根据key获取url的参数
getSubStrCount                      : 获取字符出现的次数
getSubStrLocals                     : 获取字符出现的位置的数组
isEqualToStringIgnoreCase           : 对比字符串忽略大小写
```

* ### UIColor 相关 -> UIColor+Function.h

```
colorWithRed                        : 通过red，green，blue创建颜色，无需除以255
colorWithHexString                  : 16进制转颜色
```

* ### UIImage 相关 -> UIImage+Function.h

```
hasAlpha                            : 图片是否有alpha层
imageWithAlpha                      : 返回一个给定图像的副本，如果还没有一个alpha通道，就添加一个alpha通道。
transparentBorderImage              : 返回一个图像的拷贝，它的边缘有一个透明的边界。如果图像没有alpha层，就会添加一个图层。
roundedCornerImage                  : 给图片加圆角
croppedImage                        : 裁剪图片
thumbnailImage                      : 返回一个与缩略图大小的图像的拷贝。
resizedImage                        : 改变图片大小
resizedImageWithContentMode         : 调整图像的大小，根据给定的内容模式，考虑图像的方位
cutoutImage                         : 根据rect来截取图像某个矩形块的内容
animatedImageWithAnimatedGIFData    : NSData转UIImage
animatedImageWithAnimatedGIFURL     : NSURL转UIImage
imageByScalingProportionallyToSize  : 图片缩放
```

* ### UINavigationController 相关 -> UINavigationController+Function.h

```
popToViewController                 : 回退到指定页面
```

* ### UISlider 相关 -> UISlider+Function.h

```
addTapGestureWithTarget             : 为UISlider添加单击事件
```

* ### UITableView 相关 -> UITableView+Function.h

#####  成员函数
```
tableViewDisplayWitMsg              : 当UITableView无数据时展示的文字
tableViewDisplayWithImage           : 当UITableView无数据时展示的图片
commonSetTableView					: IOS11中tableview的通用设置
```

#####  成员变量
```
hideExtraCell                       : 是否隐藏多余的cell
```

* ### UIButton 相关 -> UIButton+Function.h 

```
countDownWithTimeInterval           : 倒计时
countDownCustomWithTimeInterval     : 倒计时返回当前时间，可以自定义 title 和 image
cancelTimer                         : 倒计时结束，取消倒计时
layoutButtonWithEdgeInsetsStyle     : 设置button样式  图上文下  图下文上  图左文右  图右文左
layoutButtonWithEdgeInsetsStyle     : 设置button样式和图文之间的间距
layoutButtonWithEdgeInsetsStyle     : 设置button样式，图文间距，图片缩放大小（仅横向可用）
```


* ### UITools 相关 -> UITools.h

```
formatDateToString                  : NSDate类型转化成NSString("2018-01-01")
formatDateToStringALL               : NSDate类型转化成NSString("2018-01-01 00:00:00")
formatDateToStringALLEx             : NSDate类型转化成NSString("2018-01-01 00:00:00.000")
formatStringToDate                  : NSString类型转化成NSDate("2018-01-01")
formatStringToDateEx                : NSString类型转化成NSDate("2018-01-01 00:00:00")
formatStringToDateMilli             : NSString类型转化成NSDate("2018-01-01 00:00:00.000")
is12Hours(void)                     : 判断系统是12小时制还是24小时制
genRandomString                     : 根据长度返回一串随机的字符串
exChangeOut                         : view的消失动画
isSameDay                           : 判断是否是同一天
minuteInterval                      : 计算两个时间点相距几分钟
imageWithColor                      : 创建一个uiimage，通过传入颜色，大小，以及透明度
launchImage                         : 获取app的启动页
launchImageWithType                 : 获取app的启动页
UIImage *appIcon                    : 获取app的图标
UIView* createView                  : 根据颜色创建一个view
topViewController                   : 获取最上层的ViewController
getAppName                          : 获取app名称
getAppVersion                       : 获取app版本
getAppBuild                         : 获取app的build版本   
```

* ### UIView 相关 -> UIView+Function.h

#####  成员变量

```
origin                              : 左上点
size                                : 大小
bottomLeft                          : 左下点
bottomRight                         : 右下点
topRight                            : 右上点
height                              : 高
width                               : 宽
top                                 : 上
left                                : 左
bottom                              : 下
right                               : 右
centerX                             : x中心
centerY                             : y中心
ttScreenX                           : 在最顶层布局x
ttScreenY                           : 在最顶层布局y
screenViewX                         : 在屏幕x
screenViewY                         : 在屏幕x
screenFrame                         : 在屏幕frame
```

#####  成员函数
```
moveBy                              : 移动
scaleBy                             : 缩放
fitInSize                           : 按比例缩小
removeAllSubviews                   : 删除view里面所有的子view
viewController                      : 返回view所在的viewController
transitionWithType                  : 组合动画
imageWithUIView                     : 将任意uiview转化成uiimage
setBorderWithView                   : 给view某个边添加border
lp_explode                          : iew的爆炸效果
```

* ### UILabel 相关 -> UILabel+Function.h

#####  成员变量
```
zl_contentInsets					: 设置内边距
```

* ### ZLMath相关
```
distanceBetweenPoints 				: 计算两个点之间的距离
angleBetweenPoints					: 两个点之间的角度
angleBetweenLines					: 两条线之间的角度
```

* ### 通用的define
```
UIColorFromRGB                      : 16进制值转UIColor
RandomColor                         : 返回一个随机颜色
SCREEN_MAX_WIDTH                    : 屏幕宽度
SCREEN_MAX_HEIGHT                   : 屏幕高度
WeakSelf                            : 弱引用
HomePath                            : App路径
DocumentsPath                       : App Documents路径
CachePath                           : App Cache路径
TempPath                            : App Temp路径
```
