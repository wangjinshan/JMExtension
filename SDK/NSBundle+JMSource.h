//
//  NSBundle+JMSource.h
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *  获取资源类,默认是从 JSPhotoSDK中获取
 */
@interface NSBundle (JMSource)

/**
 *  通过key获取国际化字符串
 *
 *  @param key         key
 *  @return 国际化字符串
 */
+ (NSString *)localizedStringForKey:(NSString *)key;
/**
 *  通过key value 获取国家化字符串
 *
 *  @param key         key
 *  @param value          value
 *  @return 国际化字符串
 */
+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

/**
 动态从bundle中获取字段进行国际化

 @param key key
 @param name bundleName 必须是字符串bundle的名字
 @return 国际化字符串
 */
+ (NSString *)localizedStringForKey:(NSString *)key bundleName:(NSString *)name;

/**
 动态从bundle中获取字段进行国际化

 @param key key
 @param value 自定义的value
 @param name bundleName
 @return 国际化字符串
 */
+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value bundleName:(NSString *)name;


@end
