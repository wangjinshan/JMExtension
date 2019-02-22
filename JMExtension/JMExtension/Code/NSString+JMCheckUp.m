//
//  NSString+JMCheckUp.m
//  RRHua
//
//  Created by 山神 on 2018/12/14.
//  Copyright © 2018 Demon. All rights reserved.
//

#import "NSString+JMCheckUp.h"
#import "JMEMacro.h"


@implementation NSString (JMCheckUp)

+ (BOOL)isEmptyString:(NSString *)string {
    if (string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidatePassword {
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[a-zA-Z0-9]+"];
    return [passWordPredicate evaluateWithObject:self];
}

- (NSString *)stringByAddingPercentEncodingWithAllowedCharactersWithChinese {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)stringByRemovingPercentEncodingWithMessyCode {
    return [self stringByRemovingPercentEncoding];
}

- (NSMutableAttributedString *)attributedStringWithLineSpacing:(CGFloat)lineSpaing {
    if ([NSString isEmptyString:self]) {
        return [[NSMutableAttributedString alloc] init];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpaing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    return attributedString;
}

- (NSString *)stringByGetRidOfWhiteSpaceAndReturnKey {
    NSString *mnemonicStr = self;
    mnemonicStr = [mnemonicStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    mnemonicStr = [mnemonicStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    mnemonicStr = [mnemonicStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return mnemonicStr;
}

- (CGFloat)getTextHeight:(UIFont *)font
                   width:(CGFloat)width {
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attribute
                                     context:nil]
                      .size;
    return ceilf(size.height);
}

- (CGFloat)getTextWidth:(UIFont *)font
                 height:(CGFloat)height {
    CGFloat width = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                       options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{ NSFontAttributeName : font }
                                       context:nil]
                        .size.width +
        5.f;
    return width;
}

- (BOOL)isStringAndNumberAndCNYString:(XCTextFieldStringType)stringType {
    return [self matchRegularWith:stringType];
}
- (BOOL)isSpecialLetter {
    if ([self isStringAndNumberAndCNYString:XCTextFieldStringTypeNumber] || [self isStringAndNumberAndCNYString:XCTextFieldStringTypeLetter] || [self isStringAndNumberAndCNYString:XCTextFieldStringTypeChinese]) {
        return NO;
    }
    return YES;
}

#pragma mark--- 用正则判断条件
- (BOOL)matchRegularWith:(XCTextFieldStringType)type {
    NSString *regularStr = @"";
    switch (type) {
        case XCTextFieldStringTypeNumber: //数字
            regularStr = @"^[0-9]*$";
            break;
        case XCTextFieldStringTypeLetter: //字母
            regularStr = @"^[A-Za-z]+$";
            break;
        case XCTextFieldStringTypeChinese: //汉字
            regularStr = @"^[\u4e00-\u9fa5]{0,}$";
            break;
        default:
            break;
    }
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    if ([regextestA evaluateWithObject:self] == YES) {
        return YES;
    }
    return NO;
}
- (int)getStringLengthWithCh2En1 {
    int strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strLength++;
        } else {
            p++;
        }
    }
    return strLength;
}

- (NSString *)removeSpecialLettersExceptLetters:(NSArray<NSString *> *)exceptLetters {
    if (self.length > 0) {
        NSMutableString *resultStr = [[NSMutableString alloc] init];
        for (int i = 0; i < self.length; i++) {
            NSString *indexStr = [self substringWithRange:NSMakeRange(i, 1)];
            if (![indexStr isSpecialLetter] || (exceptLetters && [exceptLetters containsObject:indexStr])) {
                [resultStr appendString:indexStr];
            }
        }
        if (resultStr.length > 0) {
            return resultStr;
        } else {
            return @"";
        }
    } else {
        return @"";
    }
}

- (NSString *)utcTime {
    NSString *timestamp = self;
    if (timestamp == nil) {
        return @"--";
    }
    if (timestamp.length > 10) {
        timestamp = [timestamp substringToIndex:10];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss Z"];

    NSTimeInterval timeInterval = [timestamp doubleValue];
    if (timeInterval == 0) {
        timeInterval = [[NSDate date] timeIntervalSince1970];
    }
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];

    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *)formatTimeWithFormatString:(NSString *)formatString {
    NSString *timestamp = self;
    if (timestamp == nil) {
        return @"--";
    }
    if (timestamp.length > 10) {
        timestamp = [timestamp substringToIndex:10];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([NSString isEmptyString:formatString]) formatString = @"MM/dd/yyyy HH:mm:ss";
    [dateFormatter setDateFormat:formatString];

    NSTimeInterval timeInterval = [timestamp doubleValue];
    if (timeInterval == 0) {
        timeInterval = [[NSDate date] timeIntervalSince1970];
    }
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];

    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

//TODO:几分钟前/小时前 今天 昨天 09-13 2016-09-02等
- (NSString *)formatDate {
    @try {
        NSString *timeInterval = self;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        if (timeInterval.length == 13) {
            timeInterval = [timeInterval substringToIndex:10];
        }
        NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];

        NSTimeInterval secondsPerDay = 24 * 60 * 60;

        NSDate *today = [NSDate date];
        NSDate *yearsterDay = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
        NSDate *theDayBeforeYesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-2 * secondsPerDay];

        //日历
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

        NSDateComponents *comp1 = [calendar components:unitFlags fromDate:needFormatDate];
        NSDateComponents *comp2 = [calendar components:unitFlags fromDate:today];
        NSDateComponents *comp3 = [calendar components:unitFlags fromDate:yearsterDay];
        NSDateComponents *comp4 = [calendar components:unitFlags fromDate:theDayBeforeYesterday];

        if (comp1.year == comp2.year &&
            comp1.month == comp2.month &&
            comp1.day == comp2.day) {
            NSTimeInterval time = [today timeIntervalSinceDate:needFormatDate];
            NSInteger sec = time / 60; // 秒转分钟
            if (sec <= 0) {
                return [NSString stringWithFormat:@"1分钟内"];
            }
            if (sec < 60) {
                return [NSString stringWithFormat:@"%ld分钟前", sec];
            }

            NSInteger hours = time / 3600; // 秒转小时
            return [NSString stringWithFormat:@"%ld小时前", (long)hours];
        } else if (comp1.year == comp3.year &&
                   comp1.month == comp3.month &&
                   comp1.day == comp3.day) {
            return @"昨天";
        } else if (comp1.year == comp4.year &&
                   comp1.month == comp4.month &&
                   comp1.day == comp4.day) {
            return @"前天";
        } else {
            [dateFormatter setDateFormat:@"yyyy"];
            NSString *yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:today];
            if ([yearStr isEqualToString:nowYear]) {
                [dateFormatter setDateFormat:@"MM-dd"];
                return [dateFormatter stringFromDate:needFormatDate];
            } else {
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                return [dateFormatter stringFromDate:needFormatDate];
            }
        }
    }
    @catch (NSException *exception) {
        return @"";
    }
}
// 今天 昨天 09-13 2016-09-02等
- (NSString *)formatDateWithoutSeconds {
    @try {
        NSString *timeInterval = self;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        if (timeInterval.length == 13) {
            timeInterval = [timeInterval substringToIndex:10];
        }
        NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];

        NSTimeInterval secondsPerDay = 24 * 60 * 60;

        NSDate *today = [NSDate date];
        NSDate *yearsterDay = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
        NSDate *theDayBeforeYesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-2 * secondsPerDay];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

        NSDateComponents *comp1 = [calendar components:unitFlags fromDate:needFormatDate];
        NSDateComponents *comp2 = [calendar components:unitFlags fromDate:today];
        NSDateComponents *comp3 = [calendar components:unitFlags fromDate:yearsterDay];
        NSDateComponents *comp4 = [calendar components:unitFlags fromDate:theDayBeforeYesterday];

        if (comp1.year == comp2.year &&
            comp1.month == comp2.month &&
            comp1.day == comp2.day) {
            return @"今天";
        } else if (comp1.year == comp3.year &&
                   comp1.month == comp3.month &&
                   comp1.day == comp3.day) {
            return @"昨天";
        } else if (comp1.year == comp4.year &&
                   comp1.month == comp4.month &&
                   comp1.day == comp4.day) {
            return @"前天";
        } else {
            [dateFormatter setDateFormat:@"yyyy"];
            NSString *yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:today];
            if ([yearStr isEqualToString:nowYear]) {
                [dateFormatter setDateFormat:@"MM-dd"];
                return [dateFormatter stringFromDate:needFormatDate];
            } else {
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                return [dateFormatter stringFromDate:needFormatDate];
            }
        }
    }
    @catch (NSException *exception) {
        return @"";
    }
}

+ (BOOL)compareNumber:(NSString *)numberA numberB:(NSString *)numberB {
    if ([self isEmptyString:numberA]) {
        return NO;
    }

    if ([self isEmptyString:numberB]) {
        return NO;
    }

    NSDecimalNumber *numA = [[NSDecimalNumber alloc] initWithString:numberA];
    NSDecimalNumber *numB = [[NSDecimalNumber alloc] initWithString:numberB];

    NSComparisonResult result = [numA compare:numB];
    switch (result) {
        case NSOrderedAscending:
            return NO;
        case NSOrderedDescending:
        case NSOrderedSame:
            return YES;
    }
}

+ (double)intervalSinceNow:(NSString *)theDate {
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[theDate integerValue]];
    NSTimeInterval late = [d timeIntervalSince1970] * 1;
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970] * 1;
    NSTimeInterval timeDiff = now - late;
    return timeDiff;
}

+ (BOOL)hasPrefixAeiou:(NSString *)string {
    NSArray *arr = @[ @"a", @"e", @"i", @"o", @"u", @"A", @"E", @"I", @"O", @"U" ];
    __block BOOL isok = NO;
    [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([string hasPrefix:obj]) {
            isok = YES;
            *stop = YES;
        }
    }];
    return isok;
}

- (BOOL)hasAtleastOneNumOneLetter {
    NSString *regularStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    if ([regextestA evaluateWithObject:self] == YES) {
        return YES;
    }
    return NO;
}

+ (BOOL)isEmailAddressJudgeObjc:(NSString *)objcName {
    NSString *emailRegex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    return [[self class] _isValidateByRegex:emailRegex judgeObjc:objcName];
}

- (NSString *)stringWithTrimmingCharacters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)seperateNumberByComma:(NSInteger)number {
    //提取正数部分
    BOOL negative = number < 0;
    NSInteger num = labs(number);
    NSString *numStr = [NSString stringWithFormat:@"%ld", (long)num];
    //根据数据长度判断所需逗号个数
    NSInteger length = numStr.length;
    NSInteger count = numStr.length / 3;

    //在适合的位置插入逗号
    for (int i = 1; i <= count; i++) {
        NSInteger location = length - i * 3;
        if (location <= 0) {
            break;
        }
        //插入逗号拆分数据
        numStr = [numStr stringByReplacingCharactersInRange:NSMakeRange(location, 0) withString:@","];
    }
    //别忘给负数加上符号
    if (negative) {
        numStr = [NSString stringWithFormat:@"-%@", numStr];
    }
    return numStr;
}
//TODO:精确判断身份证
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    value = [value uppercaseString];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    int length = 0;
    if (!value) {
        return NO;
    } else {
        length = (int)value.length;

        if (length != 15 && length != 18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[ @"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91" ];

    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }

    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;

    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6, 2)].intValue + 1900;

            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil]; //测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil]; //测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];

            if (numberofMatch > 0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6, 4)].intValue;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil]; //测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil]; //测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];

            if (numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0, 1)].intValue + [value substringWithRange:NSMakeRange(10, 1)].intValue) * 7 + ([value substringWithRange:NSMakeRange(1, 1)].intValue + [value substringWithRange:NSMakeRange(11, 1)].intValue) * 9 + ([value substringWithRange:NSMakeRange(2, 1)].intValue + [value substringWithRange:NSMakeRange(12, 1)].intValue) * 10 + ([value substringWithRange:NSMakeRange(3, 1)].intValue + [value substringWithRange:NSMakeRange(13, 1)].intValue) * 5 + ([value substringWithRange:NSMakeRange(4, 1)].intValue + [value substringWithRange:NSMakeRange(14, 1)].intValue) * 8 + ([value substringWithRange:NSMakeRange(5, 1)].intValue + [value substringWithRange:NSMakeRange(15, 1)].intValue) * 4 + ([value substringWithRange:NSMakeRange(6, 1)].intValue + [value substringWithRange:NSMakeRange(16, 1)].intValue) * 2 + [value substringWithRange:NSMakeRange(7, 1)].intValue * 1 + [value substringWithRange:NSMakeRange(8, 1)].intValue * 6 + [value substringWithRange:NSMakeRange(9, 1)].intValue * 3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y, 1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17, 1)]]) {
                    return YES; // 检测ID的校验位
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }
}
#pragma mark - 私有
+ (BOOL)_isValidateByRegex:(NSString *)regex judgeObjc:(id)objcName {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:objcName];
}

@end
