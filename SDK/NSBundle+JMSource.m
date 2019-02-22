//
//  NSBundle+JMSource.m
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#import "NSBundle+JMSource.h"


@implementation NSBundle (JMSource)

+ (instancetype)_imagePickerBundle {
    static NSBundle *jsBundle = nil;
    if (jsBundle == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JSPhotoSDK" ofType:@"bundle"];
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:@"JSPhotoSDK" ofType:@"bundle" inDirectory:@"Frameworks/JSPhotoSDK.framework/"];
        }
        jsBundle = [NSBundle bundleWithPath:path];
    }
    return jsBundle;
}

+ (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:@""];
}

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle _imagePickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *needValue = [bundle localizedStringForKey:key value:value table:nil];
    return needValue;
}

// 动态BundleName
+ (instancetype)_imagePickerBundleName:(NSString *)name {
    static NSBundle *jsBundle = nil;
    if (jsBundle == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"];
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle" inDirectory:[NSString stringWithFormat:@"Frameworks/%@.framework/", name]];
        }
        jsBundle = [NSBundle bundleWithPath:path];
    }
    return jsBundle;
}
// 方法调用
+ (NSString *)localizedStringForKey:(NSString *)key bundleName:(NSString *)name {
    return [self localizedStringForKey:key value:@"" bundleName:name];
}

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value bundleName:(NSString *)name {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle _imagePickerBundleName:name] pathForResource:language ofType:@"lproj"]];
    }
    NSString *needValue = [bundle localizedStringForKey:key value:value table:nil];
    return needValue;
}

@end
