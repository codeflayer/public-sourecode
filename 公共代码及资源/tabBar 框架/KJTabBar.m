//
//  KJTabBar.m
//  0831-01（weibo -框架）
//
//  Created by 唐开江 on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "KJTabBar.h"
#import "KJTabBarItem.h"
@interface KJTabBar()
@property (nonatomic,strong)UIButton * plusBtn;
@property (nonatomic,strong)NSMutableArray * tabBarItemArray;
@property (nonatomic,strong)KJTabBarItem * selectedBtn;
@end
@implementation KJTabBar
- (NSMutableArray *) tabBarItemArray
{
    if (_tabBarItemArray==nil) {
        _tabBarItemArray = [[NSMutableArray alloc]init];
    }
    return _tabBarItemArray;

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ////设置pluBtn按钮
        [self addPlusBtn];
    
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置pluBtn 的frame
      UIImage * image = [UIImage imageNamed:@"tabbar_compose_button"];
    self.plusBtn.frame = CGRectMake(self.width*0.5-image.size.width*0.5, 0, image.size.width, image.size.height);
    
    //设置tabBarItem 的frame
    NSUInteger totalcount = self.tabBarItemArray.count;
    for (int i= 0; i<totalcount; i++) {
        KJTabBarItem * btn = self.tabBarItemArray[i];
        CGFloat w = self.width/(totalcount+1);;
        CGFloat h = self.height;
        CGFloat x= w*i;
        CGFloat y= 0;
        if (i>=totalcount/2) {
            x = w*(i+1);
            
        }
        btn.frame = CGRectMake(x,y, w, h);
        [btn setTag:i];
        
    }
    //如果有按钮就点击一次（默认程序启动是点击第一个）
   
}


    //创建PlusBtn
- (void)addPlusBtn
{
    //创建按钮
    UIButton * plusBtn = [[UIButton alloc]init];
    //设置背景图片
    UIImage * image = [UIImage imageNamed:@"tabbar_compose_button"];
    [plusBtn setBackgroundImage:image forState:UIControlStateNormal];
    UIImage * Himage = [UIImage imageNamed:@"tabbar_compose_button_highlighted"];
    [plusBtn setBackgroundImage:Himage forState:UIControlStateSelected];
    
    
    
    //设置图标
    [plusBtn setImage:[UIImage imageNamed: @"tabbar_compose_icon_add" ]forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
    
    //添加点击事件
    [plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    self.plusBtn = plusBtn;
    [self addSubview:plusBtn];
    
   
    
}

- (void)addTabBarItem:(UITabBarItem *)barItem
{
    
    //自定义tabBarItem
    KJTabBarItem * btn = [[KJTabBarItem alloc]init];
    btn.barItem = barItem;
//    btn.backgroundColor = [UIColor greenColor];
    //添加监听时间
    [btn addTarget:self  action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
    

        //添加到数组
        [self.tabBarItemArray addObject:btn];
    if (self.tabBarItemArray.count==1) {
        [self btnClick:btn];
        
    }
    
}

#pragma mark --点击事件
- (void)plusBtnClick:(UIButton *)btn
{
//    NSLog(@"postStatus");
    
    if ([self.delegate respondsToSelector:@selector(KJTabBarDidClickPlusBtn:)]) {
        [self.delegate KJTabBarDidClickPlusBtn:btn];
    }
   
    
}

- (void)btnClick:(KJTabBarItem *)btn
{
    //切换控制器的代理
    if ([self.delegate respondsToSelector:@selector(KJTabBar:swithfrom:to:)]) {
        [self.delegate KJTabBar:self swithfrom:self.selectedBtn.tag to:btn.tag];
    }
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
   


}


@end
