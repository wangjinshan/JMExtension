//
//  UIView+JMAdaptScreen.h
//  LRent
//
//  Created by 山神 on 2018/12/4.
//  Copyright © 2018 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Xib 等比例适配方案
 */
typedef NS_ENUM(NSInteger, FTAdaptScreenWidthType) {
    AdaptScreenWidthTypeNone = 0,
    FTAdaptScreenWidthTypeConstraint = 1 << 0,   /**< 对约束的constant等比例 */
    FTAdaptScreenWidthTypeFontSize = 1 << 1,     /**< 对字体等比例 */
    FTAdaptScreenWidthTypeCornerRadius = 1 << 2, /**< 对圆角等比例 */
    FTAdaptScreenWidthTypeAll = 1 << 3,          /**< 对现有支持的属性等比例 */
};


@interface UIView (JMAdaptScreen)

/**
 遍历当前view对象的subviews和constraints，对目标进行等比例换算

 @param type 想要和基准屏幕等比例换算的属性类型
 @param exceptViews 需要对哪些类进行例外
 */
- (void)adaptScreenWidthWithType:(FTAdaptScreenWidthType)type
                     exceptViews:(NSArray<Class> *)exceptViews;

@end
