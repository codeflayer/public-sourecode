//
//  UIImage+Scale.m
//  1103-01(xmpp项目)
//
//  Created by 唐开江 on 14/11/8.
//  Copyright (c) 2014年 aili. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage(Scale)
/** 使用指定（最大）宽度缩小图片 */
- (UIImage *)scaleImageWithWidth:(CGFloat)width
{
 
        // 判断图像宽度，是否需要缩放
        if (self.size.width < width || width <= 0) {
            return self;
        }
        
        // 缩放比例
        CGFloat scale = self.size.width / width;
        CGFloat height = self.size.height / scale;
        
        // 生成缩小的图像 => 使用Quartz2D绘图
        // 开始图像上下文，大小是计算出的目标大小
        CGRect r = CGRectMake(0, 0, width, height);
        UIGraphicsBeginImageContext(r.size);
        
        // 绘制图像，在指定区域内拉伸图像
        [self drawInRect:r];
        
        // 从上下文中获得绘制结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        // 返回结果
        return result;
}

@end
