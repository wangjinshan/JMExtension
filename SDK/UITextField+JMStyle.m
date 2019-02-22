//
//  UITextField+JMStyle.m
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#import "UITextField+JMStyle.h"


@implementation UITextField (JMStyle)
// 重写 set get方法
- (UIColor *)js_placeholderColor {
    return self.js_placeholderColor;
}

- (void)setJs_placeholderColor:(UIColor *)js_placeholderColor {
    // 设置真正的占位文字的暗色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = js_placeholderColor;
}


@end
