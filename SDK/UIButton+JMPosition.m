
//
//  UIButton+JMPosition.m
//  LRent
//
//  Created by 山神 on 2018/12/4.
//  Copyright © 2018 zy. All rights reserved.
//

#import "UIButton+JMPosition.h"


@implementation UIButton (JMPosition)

- (void)setImagePosition:(ImageTitlePosition)postion
                 spacing:(CGFloat)spacing {
    [self setImagePosition:postion spacing:spacing padding:0];
}

- (void)setImagePosition:(ImageTitlePosition)postion
                 spacing:(CGFloat)spacing
                 padding:(CGFloat)padding {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];

    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop

    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2.f - imageWidth / 2.f;                //image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2.f + spacing / 2.f;                                 //image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2.f) - (imageWidth + labelWidth) / 2.f; //label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2.f + spacing / 2.f;                                 //label中心移动的y距离

    CGFloat changedWidth = MIN(labelWidth, imageWidth);
    CGFloat changedHeight = labelHeight + spacing;

    switch (postion) {
        case ImageTitlePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2.f, 0, spacing / 2.f);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2.f, 0, -spacing / 2.f);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2.f + padding, 0, spacing / 2.f + padding);
            break;

        case ImageTitlePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing / 2.f, 0, -(labelWidth + spacing / 2.f));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing / 2.f), 0, imageWidth + spacing / 2.f);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2.f + padding, 0, spacing / 2.f + padding);
            break;

        case ImageTitlePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY + padding, -changedWidth / 2.f, changedHeight - imageOffsetY + padding, -changedWidth / 2.f);
            break;

        case ImageTitlePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight - imageOffsetY + padding, -changedWidth / 2.f, imageOffsetY + padding, -changedWidth / 2.f);
            break;

        default:
            break;
    }
}


@end
