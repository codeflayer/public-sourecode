//
//  VPViewController.h
//  VPImageCropperDemo
//
//  Created by Vinson.D.Warm on 1/13/14.
//  Copyright (c) 2014 Vinson.D.Warm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPViewController : UIViewController

/**
 *  *  创建返回一个可以选择图片的iamgeView
 *
 *  @param width 宽度
 *  @param X     x值
 *  @param Y     y值
 *  @param borderW     外圆宽度，一般为2.0f
 *  @param borderColor 外圆颜色，默认白色

 */
- (UIImageView *)addPortaitImageViewWidth:(CGFloat)imageW portraitX:(CGFloat)X portraitY:(CGFloat)Y width:(CGFloat)borderW circleColor:(UIColor *)borderColor;





@end
