//
//  CALayer+JMXibBorderColor.m
//  LRent
//
//  Created by 山神 on 2018/12/5.
//  Copyright © 2018 zy. All rights reserved.
//

#import "CALayer+JMXibBorderColor.h"


@implementation CALayer (JMXibBorderColor)
- (void)setBorderXibColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderXibColor {
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
