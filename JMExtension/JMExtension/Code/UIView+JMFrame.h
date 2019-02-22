//
//  UIView+JMFrame.h
//  LRent
//
//  Created by 山神 on 2018/12/4.
//  Copyright © 2018 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIView (JMFrame)

@property (nonatomic, assign) CGFloat js_width;   // 宽度
@property (nonatomic, assign) CGFloat js_height;  // 高度
@property (nonatomic, assign) CGFloat js_x;       // x
@property (nonatomic, assign) CGFloat js_y;       // y
@property (nonatomic, assign) CGFloat js_centerX; // 中心点X
@property (nonatomic, assign) CGFloat js_centerY; // 中心点Y
@property (nonatomic) CGFloat js_left;            // 左
@property (nonatomic) CGFloat js_top;             // 上
@property (nonatomic) CGFloat js_right;           // 右
@property (nonatomic) CGFloat js_bottom;          //下
@property (nonatomic) CGPoint js_origin;          // 原始大
@property (nonatomic) CGSize js_size;             //大小
/**
 *  根据类名字创建xib
 *
 *  @return 创建好的xib
 */
+ (instancetype)viewFromXib;

@end

NS_ASSUME_NONNULL_END
