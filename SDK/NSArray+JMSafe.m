//
//  NSArray+JMSafe.m
//  RRHua
//
//  Created by 山神 on 2018/12/19.
//  Copyright © 2018 Demon. All rights reserved.
//

#import "NSArray+JMSafe.h"
#import "NSObject+JMSwizzle.h"
#import <objc/runtime.h>


@implementation NSArray (JMSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    //调用原方法以及新方法进行交换，处理崩溃问题。
    dispatch_once(&onceToken, ^{
        //越界崩溃方式一：[array objectAtIndex:1000];
        Class cls = NSClassFromString(@"__NSArrayI");
        [cls jm_swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(jm_objectAtIndex:)];

        //越界崩溃方式二：arr[1000];   Subscript n:下标、脚注
        [cls jm_swizzleSelector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(jm_objectAtIndexedSubscript:)];
    });
}
- (instancetype)jm_objectAtIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1)) { // 数组越界
        return nil;
    } else { // 没有越界
        return [self jm_objectAtIndex:index];
    }
}

- (instancetype)jm_objectAtIndexedSubscript:(NSUInteger)index {
    if (index > (self.count - 1)) { // 数组越界
        return nil;
    } else { // 没有越界
        return [self jm_objectAtIndexedSubscript:index];
    }
}

@end
