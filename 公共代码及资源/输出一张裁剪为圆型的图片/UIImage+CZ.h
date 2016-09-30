//
//  UIImage+CZ.h
//  04-图片裁剪
//
//  Created by apple on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CZ)

/**
 * name 图片名称
 * boderWidth 边框长度
 * borderColor 边框的颜色
 */
+(UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)boderWidth borderColor:(UIColor *)borderColor;

@end
