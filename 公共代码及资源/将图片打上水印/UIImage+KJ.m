//
//  UIImage+KJ.m
//  03-水印
//
//  Created by apple on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+KJ.h"

@implementation UIImage (KJ)

+(UIImage *)waterImageWithBgName:(NSString *)bgName logo:(NSString *)logo{

    UIImage *bgImage =[UIImage imageNamed:bgName];
    
    //第一个参数 放置图片的尺寸 而不UIKit的尺寸
    //第二个参数 opaque 代表不透明 YES:不透明 NO：透明
    //第三个参数 代表伸缩 用官方提供的0.0 不伸缩图片
    //这行代码相当创建了一个bitmap 也就是UIImage
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
#warning 用下面的方法图片画出来没那么清晰
    //UIGraphicsBeginImageContext(bgImage.size);
    
    //画图
    [bgImage drawAtPoint:CGPointMake(0, 0)];
    
    
    //画水印
    UIImage *logoImage = [UIImage imageNamed:logo];
    
#warning logo的尺寸在实际开发过程在重新定义
    CGFloat logoW = logoImage.size.width * 0.2;
    CGFloat logoH = logoImage.size.height * 0.2;
    CGFloat logoX = bgImage.size.width - logoW;
    CGFloat logoY = bgImage.size.height - logoH;
    
    [logoImage drawInRect:CGRectMake(logoX, logoY, logoW, logoH)];
    
    //获取新画上去的图片
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束画图片
    UIGraphicsEndImageContext();
    
    return waterImage;

}
@end
