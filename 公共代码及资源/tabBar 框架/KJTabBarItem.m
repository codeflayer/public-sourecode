//
//  KJTabBarItem.m
//  0831-01（weibo -框架）
//
//  Created by 唐开江 on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "KJTabBarItem.h"
@interface KJTabBarItem()
@property (nonatomic,weak)UIButton * badgeBtn;


@end
@implementation KJTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        //图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        //设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //添加一个提醒按钮
        UIButton * badgeBtn = [[UIButton alloc]init];
        [badgeBtn setBackgroundImage:[UIImage stretchableImageWithName:@"main_badge"] forState:UIControlStateNormal];
//        badgeBtn.backgroundColor = [UIColor blackColor];
        badgeBtn.titleLabel.font =[UIFont systemFontOfSize:12];
//        badgeBtn.titleLabel.textAlignment =NSTextAlignmentCenter;
        [badgeBtn setTitle:@"20" forState:UIControlStateNormal];
        badgeBtn.userInteractionEnabled = NO;
        [badgeBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        badgeBtn.hidden = YES;
//        badgeBtn.size = self.currentImage.size;
          [self addSubview:badgeBtn];
        self.badgeBtn = badgeBtn;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //提醒按钮的frame
    
    CGFloat badgeW =self.badgeBtn.currentBackgroundImage.size.width ;
    CGFloat badgeH =self.badgeBtn.currentBackgroundImage.size.height;
    CGFloat badgeX= self.width- 1.7*badgeW;
    CGFloat badgeY= 0;
    self.badgeBtn.frame = CGRectMake(badgeX, badgeY, badgeW , badgeH);
    
   

}


-(void)setBarItem:(UITabBarItem *)barItem
{
    _barItem = barItem;

        _barItem = barItem;
        //设置按钮正常状态的图片
        [self setImage:barItem.image forState:UIControlStateNormal];
        //设置选择状态的图片
        [self setImage:barItem.selectedImage forState:UIControlStateSelected];
        //设置按钮的文字
        [self setTitle:barItem.title forState:UIControlStateNormal];
        

    
    //添加barItem监听
    [_barItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_barItem addObserver:self  forKeyPath:@"image" options:0 context:nil];
    [_barItem  addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [_barItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    

}

//移出监听
-(void)dealloc
{
   
     [_barItem removeObserver:self forKeyPath:@"title"];
     [_barItem removeObserver:self forKeyPath:@"image"];
     [_barItem removeObserver:self forKeyPath:@"selectedImage"];
     [_barItem removeObserver:self forKeyPath:@"badgeValue"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
   //设置按钮的属性
    int count = self.barItem.badgeValue.intValue;
    
    //如果大于0
    if (count>0) {
         self.badgeBtn.hidden = NO;
        if (count>100) {
            [self.badgeBtn setTitle:@"N" forState:UIControlStateNormal];
        }
        else
        {
        [self.badgeBtn setTitle:self.barItem.badgeValue forState:UIControlStateNormal];
        }
    }else
    {
        self.badgeBtn.hidden = YES;
    }
    
    
    [self setTitle:self.barItem.title forState:UIControlStateNormal];
    [self setTitle:self.barItem.title forState:UIControlStateSelected];
    [self setImage:self.barItem.image forState:UIControlStateNormal];
    [self setImage:self.barItem.selectedImage forState:UIControlStateSelected];
   
//    NSLog(@"%@",self.badgeBtn.titleLabel.text);

}



//重写setHigligted方法
- (void)setHighlighted:(BOOL)highlighted
{
   //不调用父类方法
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
   
    CGFloat w = self.width;
    CGFloat h = self.height*0.6;
    CGFloat x = 0;
    CGFloat y = 0 ;
    
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = self.height*0.6;
    CGFloat w = self.width;
    CGFloat h =self.height-y;
   
    
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}




@end
