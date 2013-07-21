//
//  UIImageAdditions.h
//  Test
//
//  Created by mac on 13-7-11.
//  Copyright (c) 2013年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Additions)

/** 
 @brief  生成一个颜色为color，大小size的图
 @discussion
 
 @params
 @params
 @return 
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 @brief  在原始图片上加一层渐变的图像，起始颜色startColor,结束颜色 endColor
 @discussion
 
 @params image 原始图片
 @params startColor 渐变起始颜色
 @params endColor 渐变终止颜色
 @return 合成图片
 
 */
+ (UIImage *)imageWithGradient:(UIImage *)image startColor:(UIColor *)startColor endColor:(UIColor *)endColor ;




- (UIImage *)setAlpha:(CGFloat)alpha;




@end
