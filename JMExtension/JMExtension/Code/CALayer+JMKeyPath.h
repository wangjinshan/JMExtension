//
//  CALayer+JMKeyPath.h
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN


@interface CALayer (JMKeyPath)

@property (nonatomic) CGFloat js_transformScaleX;    ///< key path "tranform.scale.x"
@property (nonatomic) CGFloat js_transformScaleY;    ///< key path "tranform.scale.y"
@property (nonatomic) CGFloat js_transformRotationZ; ///< key path "tranform.rotation.z"

@end

NS_ASSUME_NONNULL_END
