//
//  QCSlideSwitchView.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//


#import "QCSlideSwitchView.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
//static const CGFloat kWidthOfButtonMargin = 16.0f;//以前的
static const CGFloat kWidthOfButtonMargin = 22.0f;
static const CGFloat kFontSizeOfTabButton = 17.0f;
static const NSUInteger kTagOfRightSideButton = 999;

@implementation QCSlideSwitchView

#pragma mark - 初始化参数



- (void)initValues
{
   
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = 100;
    
    
    
    //创建tab底部分割线
    UIView * deviderLine = [[UIView alloc]init];
    deviderLine.frame = CGRectMake(0, kHeightOfTopScrollView-1, self.bounds.size.width,0.8);
    deviderLine.backgroundColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:202/255.0 alpha:1];
    
    [_topScrollView addSubview:deviderLine];
    
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _userContentOffsetX = 0;

    
   
    [self addSubview:_rootScrollView];
    
    _viewArray = [[NSMutableArray alloc] init];
    
    _isBuildUI = NO;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    //创建完子视图UI才需要调整布局(_isBuildUI 是一个标记，创建完成所有控件才可以执行横竖屏幕)
    if (_isBuildUI) {

     //设置主视图的contentSize
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
     //更新主视图各个子视图的宽度(注意：这里把子控件的frame又回到初始位置排列)
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
            
            //竖向分割线
            UIView * verticalDivider = [[UIView alloc]init];
            verticalDivider.frame = CGRectMake(i*(_topScrollView.bounds.size.width/[_viewArray count]), 10, 1,_topScrollView.bounds.size.height-2*10);
            verticalDivider.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
            
            [_topScrollView addSubview:verticalDivider];
            
        }
        
        //滚动到选中的视图，
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
        
        
    }
}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    //有多少按钮就创建多少个控制器
    for (int i=0; i<number; i++) {
        
        //给外界一个接口，创建一个控制器并对应一个number,
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        
        //将自控制器的view添加到_rootScrollView
        [_rootScrollView addSubview:vc.view];
        //NSLog(@"%@",[vc.view class]);
    }
    [self createNameButtons];
 
//---------------------------默认选中view--------------------------------------
    //选中第一个view
    self.isFirstIn = YES;
    
  
    
    if ([self.slideSwitchViewDelegate respondsToSelector:@selector(firstSeletTab:)]) {
       NSUInteger index =  [self.slideSwitchViewDelegate firstSeletTab:self];
        
        if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID+index - 100];
            
            //点击btn滑动view到对应的view,(userSelectedChannelID的就是tag，等于100+i)
            UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID + index];
            [self selectNameButton:button];
        }
    }
    
    

    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

 


/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons
{
    
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:_shadowImage];
    [_topScrollView addSubview:_shadowImageView];
    
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = kWidthOfButtonMargin;
    //每个tab偏移量
    CGFloat xOffset = kWidthOfButtonMargin;
    
//--------------------------------设置btn的宽度和高度--------------------------------
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGSize textSize = [vc.title sizeWithFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]
                               constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
    
        CGFloat btnWidth = self.frame.size.width/[_viewArray count];
        [button   setFrame:CGRectMake(btnWidth *i, 0, btnWidth, kHeightOfTopScrollView)];
        [button setTag:i+100];
        if (i==0) {
            _shadowImageView.frame = CGRectMake((btnWidth-textSize.width)*0.5, 0, textSize.width, _shadowImage.size.height);
            button.selected = YES;
        }
        
//-------------------------------设置btn的宽度和高度--------------------------------
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
    }
    
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
}



#pragma mark - 顶部滚动视图逻辑方法（按钮点击事件）

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    
    }

    
    
    //按钮选中状态，如果没有选中就进来
    if (!sender.selected) {
        

        CGSize textSize = [sender.currentTitle sizeWithFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]
                               constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        CGFloat btnX = (sender.frame.origin.x+(sender.frame.size.width-textSize.width)*0.5);

        
        //第一次进入没有动画
        if (self.isFirstIn) {
             [_shadowImageView setFrame:CGRectMake(btnX, 0, textSize.width, _shadowImage.size.height)];
            self.isFirstIn = NO;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            
                [_shadowImageView setFrame:CGRectMake(btnX, 0, textSize.width, _shadowImage.size.height)];
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:YES];

                }
                _isRootScroll = NO;
                
                //切换控制器
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];

                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
        
    }
     #warning  这里先移动btn，在选中，不然会出现view还没移动，按钮就已经选中了
    sender.selected = YES;

    
}



#pragma mark 主视图逻辑方法（_rootScrollView的代理方法）


//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;


    }
}
/*
//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;

        }
        else {
            _isLeftScroll = NO;
        }
    }
}
*/

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width +100;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}





#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

@end

