//
//  KJNaviBarbuttonItem.m
//  08901-01（weibo -框架）navigationBar
//
//  Created by 唐开江 on 14-9-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "KJNaviBarbuttonItem.h"

@implementation KJNaviBarbuttonItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// 设置batButtonItem
+ (UIBarButtonItem *)setBarButtonItemWithnormlimgeName:(NSString *)normalImage andhiImage:(NSString *)hiImage and:(SEL)action with:(id)target
{
    UIButton * leftBtn = [[UIButton alloc]init];
    [leftBtn setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:hiImage] forState:UIControlStateHighlighted];
    leftBtn.size = leftBtn.currentBackgroundImage.size;
    [leftBtn addTarget:target action:(SEL)action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    return leftItem;
}

@end
