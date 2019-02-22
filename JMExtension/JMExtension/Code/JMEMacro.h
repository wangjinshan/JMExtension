//
//  JMEMacro.h
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#ifndef JMEMacro_h
#define JMEMacro_h

#define IOS11 @available(iOS 11.0, *)
#define JMEKeyWindow [UIApplication sharedApplication].keyWindow

#ifdef DEBUG
#define JMELog(format, ...) printf("\n>> -----------------------JME Beging --------------------- <<\nclass: <%s:(%d) > method: %s \n%s\n>> -----------------------JME End --------------------- <<\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])
#else
#define JMELog(...)
#endif

#define JMEScreenBounds [[UIScreen mainScreen] bounds]
#define JMEScreenWidth [[UIScreen mainScreen] bounds].size.width
#define JMEScreenHeight [[UIScreen mainScreen] bounds].size.height
#define JMEKeyWindow [UIApplication sharedApplication].keyWindow

#define iPhoneXSeries ((JMEScreenWidth == 375.f || JMEScreenWidth == 414.f) && (JMEScreenHeight == 812.f || JMEScreenHeight == 896.f) ? YES : NO)
#define JMEStatusbarHeight (iPhoneXSeries ? 44.f : 20.f)
#define JMENavigationHeightiphoneXSeries (iPhoneXSeries ? 44.f : 0.f)
#define JMENavigationHeight 44.f
#define JMETabbarHeight (iPhoneXSeries ? (49.f + 34.f) : 49.f)
#define JMETabbarSafeBottomMargin (iPhoneXSeries ? 34.f : 0.f)
#define JMEStatusbarAndNavigationBarHeight (iPhoneXSeries ? 88.f : 64.f)
#define UIViewSafeAreinsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets; })
// 比例
#define SCALE (JMEScreenWidth / 375.0f) //比例


#endif /* JMEMacro_h */
