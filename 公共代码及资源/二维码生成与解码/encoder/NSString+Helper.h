//
//  NSString+Helper.h
//  03-二维码生成
//
//  Created by apple on 13-11-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**
 * 返回当前字符串对应的二维码图像
 *
 * 二维码的实现是将字符串传递给滤镜，滤镜直接转换生成二维码图片
 */
- (UIImage *)createQRCode;

@end
