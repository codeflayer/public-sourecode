//
//  NSString+Helper.m
//  03-二维码生成
//
//  Created by apple on 13-11-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+Helper.h"
#import <CoreImage/CoreImage.h>

@implementation NSString (Helper)

/**
 返回当前字符串对应的二维码图像
 
 二维码的实现是将字符串传递给滤镜，滤镜直接转换生成二维码图片
 */
- (UIImage *)createQRCode
{
    // 1. 实例化一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 1.1 设置filter的默认值
    // 因为之前如果使用过滤镜，输入有可能会被保留，因此，在使用滤镜之前，最好设置恢复默认值
    [filter setDefaults];
    
    // 2. 将传入的字符串转换为NSData
//    NSString * str = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    // 3. 将NSData传递给滤镜(通过KVC的方式，设置inputMessage)
    [filter setValue:data forKey:@"inputMessage"];
    
    // 4. 由filter输出图像
    CIImage *outputImage = [filter outputImage];
    
    // 5. 将CIImage转换为UIImage
    return [UIImage imageWithCIImage:outputImage];
}

@end
