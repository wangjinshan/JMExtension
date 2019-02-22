//
//  UIButton+JMPosition.h
//  LRent
//
//  Created by 山神 on 2018/12/4.
//  Copyright © 2018 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ImageTitlePosition) {
    ImageTitlePositionLeft = 0,   //图片在左，文字在右
    ImageTitlePositionRight = 1,  //图片在右，文字在左
    ImageTitlePositionTop = 2,    //图片在上，文字在下
    ImageTitlePositionBottom = 3, //图片在下，文字在上
};

/**
 button 方位控制
 */
@interface UIButton (JMPosition)
/**
 设置button的图文的位置

 @param postion 位置枚举
 @param spacing 文字和image之间间距
 */
- (void)setImagePosition:(ImageTitlePosition)postion
                 spacing:(CGFloat)spacing;

/**
 设置button的图文的位置

 @param postion 位置枚举
 @param spacing 文字和image之间间距
 @param padding button 内边距
 */
- (void)setImagePosition:(ImageTitlePosition)postion
                 spacing:(CGFloat)spacing
                 padding:(CGFloat)padding;
@end

NS_ASSUME_NONNULL_END
