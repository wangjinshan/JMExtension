//
//  UIImage+JMMake.h
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 生成图片
 */
@interface UIImage (JMMake)
/**
 *  返回一张抗锯齿图片
 *  @return 本质：在图片生成一个透明为1的像素边框
 */
- (UIImage *)imageAntialias;

/**
 *  圆形图
 *
 *  @param originImage 原始图
 *
 *  @return 处理好的圆形图
 */

+ (UIImage *)imageCircleFromOriginImage:(UIImage *)originImage;

/**
 *  根据图片名字返回圆形图
 *
 *  @param imageName 图片名字
 *
 *  @return 处理好的圆形图
 */
+ (UIImage *)imageCircleFromImageName:(NSString *)imageName;

/**
 *  格局角度旋转图片
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/**
 *  获取一张高斯模糊图,大小是原图大小
 *   @param blurNumber 模糊度数值,越大越模糊
 */
- (UIImage *)getImageFilterForGaussianBlur:(int)blurNumber;

/**
 *  获取一张马赛克图
 *   @param level 模糊度数值,越大像素点越多,效果越明显
 */
- (UIImage *)getMosaicImageFromOrginImageBlockLevel:(NSUInteger)level;

/**
 *  CoreImage 获取一张马赛克图
 *   @param pixel 模糊度数值,越大像素点越多
 */
- (UIImage *)getMosaicImageFromOrginImageFromCoreImagePixelSize:(int)pixel;

/**
 *  绘制一张原图
 */
- (UIImage *)getImageWithOldImage;


+ (CGRect)getViewBoundWith:(UIImage *)image;

+ (UIImage *)getScaleImageWith:(UIImage *)image;

/**
 画一张原图大小的图

 @param image 原图
 @return 画好原图大小的图
 */
+ (UIImage *)getImageWithOldImage:(UIImage *)image;

/**
 右朝向的图

 @param image 原图
 @param orientation 朝向
 @return 朝向的图
 */
+ (UIImage *)getRotationWithImage:(UIImage *)image withOrientation:(UIDeviceOrientation)orientation;

/**
 根据图片的朝向锁定图的方向

 @param image 原图
 @param orientation 方向
 @return 指定朝向的图
 */
+ (UIImage *)getUnrotationWithImage:(UIImage *)image withOrientation:(UIDeviceOrientation)orientation;

/**
 旋转图片

 @param degrees 旋转角度
 @param image 原图
 @return 旋转后的图
 */
+ (UIImage *)rotatedByDegrees:(CGFloat)degrees withImage:(UIImage *)image;

/**
 向右旋转90度

 @param image 原图
 @return 旋转后的图
 */
+ (UIImage *)rotatedWithImage:(UIImage *)image;

/**
 屏幕等比例裁剪图片

 @param bSize 裁剪的大小
 @return 根据屏幕等比裁剪的大小
 */
+ (CGSize)getCutViewSizeWith:(CGSize)bSize;


+ (CGSize)getCutImageViewSizeWith:(CGSize)bSize cutViewSize:(CGSize)cSize;
@end
