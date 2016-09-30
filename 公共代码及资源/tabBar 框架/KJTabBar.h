//
//  KJTabBar.h
//  0831-01（weibo -框架）
//
//  Created by 唐开江 on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KJTabBar;
@protocol tabBarDelegate <NSObject>
//切换控制器
- (void)KJTabBar:(KJTabBar*)tabBar swithfrom:(NSUInteger)from to:(NSUInteger)to;
//弹出发送view
- (void)KJTabBarDidClickPlusBtn:(UIButton *) plusBtn;

@end
@interface KJTabBar : UIView

- (void)addTabBarItem:(UITabBarItem *)barItem;
@property (nonatomic,weak)id <tabBarDelegate> delegate;
@end
