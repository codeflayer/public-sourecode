//
//  UIImageView+KJ.m
//  VPImageCropperDemo
//
//  Created by 唐开江 on 14/12/20.
//  Copyright (c) 2014年 Vinson.D.Warm. All rights reserved.
//

#import "UIImageView+KJ.h"

@implementation UIImageView (KJ)

- (instancetype)initImageViewWidth:(CGFloat)imageV X:(CGFloat)imageViewX Y:(CGFloat)imageViewY circleColor:(UIColor *)color borderWidth:(CGFloat)borderW isRound:(BOOL)round
{
        CGFloat w = imageV; CGFloat h = w;
        self = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, w, h)];
        if(round)
        {
        [self.layer setCornerRadius:(self.frame.size.height/2)];
        }
        [self.layer setMasksToBounds:YES];
        [self setContentMode:UIViewContentModeScaleAspectFill];
        [self setClipsToBounds:YES];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(4, 4);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 2.0;
    
    if (color) {
        self.layer.borderColor = [color CGColor];
    }else
    {
        self.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    
        self.layer.borderWidth = borderW;

        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor greenColor];


    return self;
}
@end
