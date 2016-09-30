//
//  KJFocusImageView.h
//  lunboViewTest
//
//  Created by 唐开江 on 15/3/13.
//  Copyright (c) 2015年 KangZhi. All rights reserved.
// 注意：该控件依赖SDWebImage 框架，注意导入#import "UIImageView+WebCache.h"


#import <UIKit/UIKit.h>

#pragma mark - KJFocusImageViewDelegate
@protocol KJFocusImageViewDelegate <NSObject>

@end
@interface KJFocusImageView : UIView<UIGestureRecognizerDelegate, UIScrollViewDelegate>
/**
 *  创建一个轮播UIView
 *
 *  @param frame    轮播view的frame
 *  @param delegate 遵守KJFocusImageViewDelegate协议的控制器对象
 *  @param array    要加载的图片数组
 *
 *  @return 装有一个scrollView 的UIView
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<KJFocusImageViewDelegate>)delegate focusImageItems:(NSArray *)array;



/**
 *  创建一个轮播UIView
 *
 *  @param frame    轮播view的frame
 *  @param delegate 遵守KJFocusImageViewDelegate协议的控制器对象
 *  @param array    要加载的图片url数组
 *
 *  @return 装有一个scrollView 的UIView
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<KJFocusImageViewDelegate>)delegate focusImageURLs:(NSArray *)array;


@end
