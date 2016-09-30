//
//  UIImage+Scale.h
//  1103-01(xmpp项目)
//
//  Created by 唐开江 on 14/11/8.
//  Copyright (c) 2014年 aili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Scale)
/** 使用指定（最大）宽度缩小图片 */
- (UIImage *)scaleImageWithWidth:(CGFloat)width;

@end
