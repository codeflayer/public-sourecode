//
//  UIImage+MJ.h
//  预习-01-UIPopoverController
//
//  Created by MJ Lee on 14-5-25.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MJ)
/**
 *  获得某个像素的颜色
 *
 *  @param point 像素点的位置
 */
- (UIColor *)pixelColorAtLocation:(CGPoint)point;
@end
