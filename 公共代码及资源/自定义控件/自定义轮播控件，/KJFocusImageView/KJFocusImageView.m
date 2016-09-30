//
//  KJFocusImageView.m
//  lunboViewTest
//
//  Created by 唐开江 on 15/3/13.
//  Copyright (c) 2015年 KangZhi. All rights reserved.
//



#import "KJFocusImageView.h"

#import "UIImageView+WebCache.h"


@interface KJFocusImageView ()

@property (nonatomic,strong)NSArray * imageItems;

@property (nonatomic,strong)NSArray * imageURLGroup;

@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)UIPageControl * pageControl;

@property (nonatomic,strong)NSMutableArray * imageGroup;
//轮播定时器
@property (nonatomic,strong)NSTimer * timer;


@end

@implementation KJFocusImageView


- (id)initWithFrame:(CGRect)frame delegate:(id<KJFocusImageViewDelegate>)delegate focusImageItems:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageItems = array;
        
        [self setupViews];
    
        if (self.imageItems.count!=1) {

            [self addTimer];
        }

    }
    return self;
}


- (id)initWithFrame:(CGRect)frame delegate:(id<KJFocusImageViewDelegate>)delegate focusImageURLs:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
      //  http://test.duochong.com
      //  /static/ad/ad1.jpg,
      //  /static/ad/ad2.jpg,

        self.imageURLGroup = array;
     
        [self loadPictures];
        
        
    }
    return self;

    

}

- (void)loadPictures
{
    for (int i = 0; i<self.imageURLGroup.count; i++) {

        UIImageView * imageView =  [[UIImageView alloc]init];
        [self addSubview:imageView];

        [imageView sd_setImageWithURL:self.imageURLGroup[i] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [self.imageGroup addObject:image];


            //当加载的图片数量等于url数量时候
            if (self.imageGroup.count ==self.imageURLGroup.count) {
            
                self.imageItems = self.imageGroup;
                [self setupViews];
                
                if (self.imageItems.count!=1) {
                    
                    [self addTimer];
                }

            }
        }];
        
    }
  

}



- (NSMutableArray *)imageGroup
{
    if (_imageGroup==nil) {
        
        _imageGroup = [NSMutableArray array];
    }
    return _imageGroup;
}




- (void)setupViews
{
    NSArray *imageItems = self.imageItems;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    CGSize size = CGSizeMake(100, 44);
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width *.5 - size.width *.5, self.bounds.size.height - size.height, size.width, size.height)];
    
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    

    if (self.imageItems.count==1) {
        _pageControl.hidden = YES;
    }

    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = imageItems.count;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _scrollView.delegate = self;
    
    
    // single tap gesture recognizer
//    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
//    tapGestureRecognize.delegate = self;
//    tapGestureRecognize.numberOfTapsRequired = 1;
//    [_scrollView addGestureRecognizer:tapGestureRecognize];
    if (self.imageItems.count!=1) {
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * (imageItems.count+2), _scrollView.frame.size.height);
    }else
    {
        _scrollView.contentSize = self.frame.size;
        _scrollView.scrollEnabled = NO;
    }
    
    //头尾和中部的图片设置
    for (int i = 0; i < imageItems.count+2; i++) {
        UIImage * image;
        if (i==0) {
            image = imageItems[imageItems.count-1];
        }
        else  if(i==imageItems.count+1) {
            image = imageItems[0];
            
        }
      else  if (0<i<imageItems.count+1) {
            image = imageItems[i-1];
            
        }
      

        //一进来就显示第1张图
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        
        //添加图片展示按钮
        UIButton * imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageView setFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        [imageView setBackgroundImage:image forState:UIControlStateNormal];
        imageView.tag = i;
        imageView.adjustsImageWhenHighlighted = NO;
        //添加点击事件
        [imageView addTarget:self action:@selector(clickPageImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:imageView];

    }

    

}
//- (void)moveToTargetPosition:(CGFloat)targetX
//{
//    //NSLog(@"moveToTargetPosition : %f" , targetX);
//    if (targetX >= _scrollView.contentSize.width) {
//        targetX = 0.0;
//    }
//    
//    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
//    _pageControl.currentPage = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
//}

// 开启定时器

- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//下一页
- (void)nextImage
{
    
    int page = (int)self.pageControl.currentPage;
    
    
    //倒数第一个
    if (page == self.imageItems.count+1)
    {
        page = 0;
        
    }
    else
    {
        page++;
    }
    
    //  滚动scrollview
    CGFloat x = (page +1) * self.frame.size.width;
    
    
    if (self.scrollView.contentOffset.x == 0)
    {  //一开始进来的contentOffset.x =0 防止画面拉动
        [self.scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
    }
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
    
    //NSLog(@"===%zd",self.pageControl.currentPage);
    
    
}

//  关闭定时器

- (void)removeTimer
{
    [self.timer invalidate];
}



#pragma mark - UIScrollViewDelegate

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 关闭定时器
    
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //开启定时器
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);

    //  计算页码
    CGFloat x = scrollView.contentOffset.x;
    
    //如果是倒数第二张，回到第二张
    if(x>=(self.imageItems.count+1)*self.frame.size.width)
    {
        x = self.frame.size.width;
        [self.scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
        
    }
    else if (x<=0)
    {
        x = self.frame.size.width* (self.imageItems.count);
        [self.scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
        
    }
    
    //处理page
    int page = (x + self.frame.size.width*0.5) / self.frame.size.width;
    
    page--;
    if (page>=self.pageControl.numberOfPages) {
        page=0;
    }else if (page<0)
    {
        page = (int)self.pageControl.numberOfPages-1;
    }
    
    //NSLog(@"%d",page);
    self.pageControl.currentPage = page;

}
#pragma mark - UIButtonTouchEvent
-(void)clickPageImage:(UIButton *)sender{
    NSLog(@"click button tag is %zd",sender.tag);
}

@end
