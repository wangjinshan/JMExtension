//
//  NSObject+JMSwizzle.h
//  RRHua
//
//  Created by 山神 on 2018/12/18.
//  Copyright © 2018 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (JMSwizzle)

/**
 交换两个方法

 @param originalSelector 原始的方法
 @param swizzledSelector 自定义的方法
 */
+ (void)jm_swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;
@end
