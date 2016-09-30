//
//  VPTestViewController.m
//  VPImageCropperDemo
//
//  Created by 唐开江 on 14/12/20.
//  Copyright (c) 2014年 Vinson.D.Warm. All rights reserved.
//

#import "VPTestViewController.h"
//#import "UIImageView+KJ.h"
@implementation VPTestViewController

-  (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView * portraintView =[self addPortaitImageViewWidth:90 portraitX:30 portraitY:40 width:2 circleColor:[UIColor redColor]];
    [self.view addSubview:portraintView];

    
}







@end
