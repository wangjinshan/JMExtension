
//
//  NSLayoutConstraint+JMDesignable.m
//  LRent
//
//  Created by 山神 on 2018/12/4.
//  Copyright © 2018 zy. All rights reserved.
//

#import "NSLayoutConstraint+JMDesignable.h"


@implementation NSLayoutConstraint (JMDesignable)

- (void)setAdapterScreen:(BOOL)adapterScreen {
    adapterScreen = adapterScreen;
    if (adapterScreen) {
        self.constant = self.constant * ([UIScreen mainScreen].bounds.size.width / 375.0f);
    }
}
- (BOOL)adapterScreen {
    return YES;
}

@end
