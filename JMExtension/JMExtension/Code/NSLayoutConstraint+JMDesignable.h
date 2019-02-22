//
//  NSLayoutConstraint+JMDesignable.h
//  LRent
//
//  Created by 山神 on 2018/12/4.
//  Copyright © 2018 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 XIB 单个约束等比例处理
 */
@interface NSLayoutConstraint (JMDesignable)

@property (nonatomic, assign) IBInspectable BOOL adapterScreen;

@end

NS_ASSUME_NONNULL_END
