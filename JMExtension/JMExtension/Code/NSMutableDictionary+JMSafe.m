//
//  NSMutableDictionary+JMSafe.m
//  RRHua
//
//  Created by 山神 on 2018/12/18.
//  Copyright © 2018 Demon. All rights reserved.
//

#import "NSMutableDictionary+JMSafe.h"
#import <objc/runtime.h>


@implementation NSMutableDictionary (JMSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self handleMutableDictionary];
        [self handleNSDictionary];
        [self handlePlaceholderDictionaryhandle];
    });
}

+ (void)handleMutableDictionary {
    Class cls = NSClassFromString(@"__NSDictionaryM");
    Method method1 = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
    Method method2 = class_getInstanceMethod(cls, @selector(jm_setObject:forKeyedSubscript:));
    method_exchangeImplementations(method1, method2);
}

+ (void)handleNSDictionary {
    Class cls = NSClassFromString(@"__NSDictionaryI");
    Method method1 = class_getInstanceMethod(cls, @selector(objectForKeyedSubscript:));
    Method method2 = class_getInstanceMethod(cls, @selector(jm_objectForKeyedSubscript:));
    method_exchangeImplementations(method1, method2);
}

+ (void)handlePlaceholderDictionaryhandle {
    Class cls = NSClassFromString(@"__NSPlaceholderDictionary");
    Method method1 = class_getInstanceMethod(cls, @selector(initWithObjects:forKeys:count:));
    Method method2 = class_getInstanceMethod(cls, @selector(jm_initWithObjects:forKeys:count:));
    method_exchangeImplementations(method1, method2);
}

- (void)jm_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) return;
    [self jm_setObject:obj forKeyedSubscript:key];
}

- (id)jm_objectForKeyedSubscript:(id)key {
    if (!key) return nil;
    return [self jm_objectForKeyedSubscript:key];
}

- (instancetype)jm_initWithObjects:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (objects[i] == nil) { // objc 是空
            objects[i] = [NSNull null];
        }
        if (keys[i] == nil) {
            keys[i] = @"jmSDK";
        }
        rightCount++;
    }
    return [self jm_initWithObjects:objects forKeys:keys count:rightCount];
}


@end
