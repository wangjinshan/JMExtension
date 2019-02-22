//
//  CALayer+JMKeyPath.m
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#import "CALayer+JMKeyPath.h"


@implementation CALayer (JMKeyPath)

- (CGFloat)js_transformScaleX {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.x"];
    return v.doubleValue;
}

- (void)setJs_transformScaleX:(CGFloat)js_transformScaleX {
    [self setValue:@(js_transformScaleX) forKeyPath:@"transform.scale.x"];
}

- (CGFloat)js_transformScaleY {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.y"];
    return v.doubleValue;
}

- (void)setJs_transformScaleY:(CGFloat)js_transformScaleY {
    [self setValue:@(js_transformScaleY) forKeyPath:@"transform.scale.y"];
}

- (CGFloat)js_transformRotationZ {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.z"];
    return v.doubleValue;
}

- (void)setJs_transformRotationZ:(CGFloat)js_transformRotationZ {
    [self setValue:@(js_transformRotationZ) forKeyPath:@"transform.rotation.z"];
}

@end
