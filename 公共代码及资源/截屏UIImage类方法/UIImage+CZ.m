//
//  UIImage+CZ.m
//  08-涂鸦
//
//  Created by apple on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+CZ.h"

@implementation UIImage (CZ)

+(UIImage *)captureFromView:(UIView *)view{
    CGSize size = view.bounds.size;
    
    //创建一张图片
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //把图层的东西渲染到上下文
    [view.layer renderInContext:context];
    
    //从输出目标获取图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
