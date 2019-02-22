//
//  NSString+JMCheckUp.h
//  RRHua
//
//  Created by 山神 on 2018/12/14.
//  Copyright © 2018 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XCTextFieldStringType) {
    XCTextFieldStringTypeNumber, //数字
    XCTextFieldStringTypeLetter, //字母
    XCTextFieldStringTypeChinese //汉字
};

/**
 处理字符
 */
@interface NSString (JMCheckUp)
/**
 判断字符串是不是空的

 @return YES是空,NO非空
 */
+ (BOOL)isEmptyString:(NSString *)string;

/**
 判断字符串是不是仅包含字母和数字  (密码)

 @return YES- 仅包含字母和数字   NO-  还包括汉字或符号
 */
- (BOOL)isValidatePassword;

/**
 *  utl中含有中文数字的转换
 *
 *  @return 中文转义过的url
 */
- (NSString *)stringByAddingPercentEncodingWithAllowedCharactersWithChinese;

/**
 *  对url中含有%3A%2F%2F的url转码
 *
 *  @return 转义过的url
 */
- (NSString *)stringByRemovingPercentEncodingWithMessyCode;

/**
 设置行间距

 @param lineSpaing 行间距
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)attributedStringWithLineSpacing:(CGFloat)lineSpaing;

/**
 * 带时区的时间格式  2018 12-09 05:09 +8000
 */
- (NSString *)utcTime;

/**
 * 去掉首尾的换行符和回车键
 */
- (NSString *)stringByGetRidOfWhiteSpaceAndReturnKey;

- (CGFloat)getTextHeight:(UIFont *)font width:(CGFloat)width;
- (CGFloat)getTextWidth:(UIFont *)font height:(CGFloat)height;

/**
 某个字符串是不是数字、字母、汉字。
 */
- (BOOL)isStringAndNumberAndCNYString:(XCTextFieldStringType)stringType;

/**
 字符串是不是特殊字符，此时的特殊字符就是：出数字、字母、汉字以外的。
 */
- (BOOL)isSpecialLetter;

/**
 获取字符串长度 一个汉字算2个字符串，一个英文算1个字符串
 */
- (int)getStringLengthWithCh2En1;


/**
 移除字符串中除exceptLetters外的所有特殊字符
 */
- (NSString *)removeSpecialLettersExceptLetters:(NSArray<NSString *> *)exceptLetters;

/**
 格式化时间,直接显示 MM/dd/yyyy HH:mm:ss  formatString:想格式化的数据
 */
- (NSString *)formatTimeWithFormatString:(NSString *)formatString;

/**
 时间戳格式化

 @return 几分钟前/小时前 今天 昨天 09-13 2016-09-02等
 */
- (NSString *)formatDate;

/**
 时间戳格式化

 @return 今天 昨天 09-13 2016-09-02等
 */
- (NSString *)formatDateWithoutSeconds;

/**
 *  计算指定时间到当前时间差值
 */
+ (double)intervalSinceNow:(NSString *)theDate;

/**
 正则判断,匹配 aeiou

 @param string 判断的字符
 @return yes 就是包含 no 就是不包含
 */
+ (BOOL)hasPrefixAeiou:(NSString *)string;

/**
 至少一个字母一个数字,必须同时包含数字和字母
 */
- (BOOL)hasAtleastOneNumOneLetter;

/**
 判断邮箱

 */
+ (BOOL)isEmailAddressJudgeObjc:(NSString *)objcName;

/**
 删除字符串首尾部字符
 */
- (NSString *)stringWithTrimmingCharacters;

/**
 把数据格式化成 xxx,xxx,xxx
 */
+ (NSString *)seperateNumberByComma:(NSInteger)number;

/**
 精确判断身份证

 @param value 身份证
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

@end
