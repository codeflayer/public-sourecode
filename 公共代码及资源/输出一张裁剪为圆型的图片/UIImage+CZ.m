//
//  UIImage+CZ.m
//  04-图片裁剪
//
//  Created by apple on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+CZ.h"

@implementation UIImage (CZ)


+(UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)boderWidth borderColor:(UIColor *)borderColor{
    
    UIImage *image = [UIImage imageNamed:name];
    //创建一个输入目标 也就是生成一张图片
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画一个边框
    [borderColor set];
    
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, image.size.width, image.size.height));
    CGContextFillPath(context);
    
    //画里面图片
    CGFloat smallImageW = image.size.width - boderWidth * 2;
    CGFloat smallImageH = image.size.height - boderWidth * 2;
    
    //指定裁剪路径
    CGRect smallRect = CGRectMake(boderWidth, boderWidth,smallImageW, smallImageH);
    CGContextAddEllipseInRect(context, smallRect);
    CGContextClip(context);
    //画头像
    
    [image drawInRect:smallRect];
    
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
