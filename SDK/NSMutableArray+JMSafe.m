//
//  NSMutableArray+JMSafe.m
//  RRHua
//
//  Created by 山神 on 2018/12/18.
//  Copyright © 2018 Demon. All rights reserved.
//

#import "NSMutableArray+JMSafe.h"
#import <objc/runtime.h>
#import "NSObject+JMSwizzle.h"


@implementation NSMutableArray (JMSafe)

// 类簇：NSString、NSArray、NSDictionary，真实类型是其他类型
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self jm_swizzleSelector:@selector(removeObject:) withSwizzledSelector:@selector(jm_removeObject:)];

        Class cls = NSClassFromString(@"__NSArrayM");
        //2、提示数组不能添加为nil的数据
        [cls jm_swizzleSelector:@selector(addObject:) withSwizzledSelector:@selector(jm_addObject:)];

        //3、移除数据越界
        [cls jm_swizzleSelector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(jm_removeObjectAtIndex:)];

        //4、插入数据越界
        [cls jm_swizzleSelector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(jm_insertObject:atIndex:)];

        //5、处理[arr objectAtIndex:1000]这样的越界
        [cls jm_swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(jm_objectAtIndex:)];

        //6、处理arr[1000]这样的越界
        [cls jm_swizzleSelector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(jm_objectAtIndexedSubscript:)];

        //7、替换某个数据越界
        [cls jm_swizzleSelector:@selector(replaceObjectAtIndex:withObject:) withSwizzledSelector:@selector(jm_replaceObjectAtIndex:withObject:)];

    });
}

- (instancetype)jm_initWithObjects:(const id _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
            //            NSLog(@"%s object at index %lu is nil, it will be filtered", __FUNCTION__, i);
        }
    }

    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];

        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }

        //        NSLog(@"%@", [NSThread callStackSymbols]);
        return [self jm_initWithObjects:newObjects count:index];
    }

    return [self jm_initWithObjects:objects count:cnt];
}


- (void)jm_addObject:(id)obj {
    if (obj == nil) {
        //        NSLog(@"不能添加空数据 func:%s",__FUNCTION__);
    } else {
        [self jm_addObject:obj];
    }
}

- (void)jm_removeObject:(id)obj {
    if (obj == nil) {
        //        NSLog(@"不能删除空对象 func:%s", __FUNCTION__);
        return;
    }

    [self jm_removeObject:obj];
}

- (void)jm_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        //        NSLog(@"不能插入空数据 func:%s", __FUNCTION__);
    } else if (index > self.count) {
        //        NSLog(@"角标越界 func:%s", __FUNCTION__);
    } else {
        [self jm_insertObject:anObject atIndex:index];
    }
}

- (id)jm_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        //        NSLog(@"数组为空 func:%s", __FUNCTION__);
        return nil;
    }
    if (index > self.count) {
        //        NSLog(@"数组越界 func:%s", __FUNCTION__);
        return nil;
    }
    return [self jm_objectAtIndex:index];
}

- (void)jm_removeObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        //        NSLog(@"数组为空 func:%s", __FUNCTION__);
        return;
    }

    if (index >= self.count) {
        //        NSLog(@"数组越界 func:%s", __FUNCTION__);
        return;
    }

    [self jm_removeObjectAtIndex:index];
}

// 1、索引越界 2、移除索引越界 3、替换索引越界
- (instancetype)jm_objectAtIndexedSubscript:(NSUInteger)index {
    if (index > (self.count - 1)) { // 数组越界
                                    //        NSLog(@"索引越界");
        return nil;
    } else { // 没有越界
        return [self jm_objectAtIndexedSubscript:index];
    }
}

- (void)jm_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index > (self.count - 1)) { // 数组越界
                                    //        NSLog(@"移除索引越界");
    } else {                        // 没有越界
        [self jm_replaceObjectAtIndex:index withObject:anObject];
    }
}

@end
