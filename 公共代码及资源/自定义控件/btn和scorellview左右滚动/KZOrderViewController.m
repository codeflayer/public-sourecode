
//  KZOrderViewController.m
//  DuoChong
//
//  Created by 唐开江 on 14/11/24.
//  Copyright (c) 2014年 KangZhi. All rights reserved.
//

#import "KZOrderViewController.h"

@interface KZOrderViewController () <UIScrollViewDelegate>

@property (nonatomic,weak)UIButton * selectedBtn;

@property (nonatomic,weak)UIScrollView * containerView;
@end

@implementation KZOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单";
    
 
    //添加scorellView
    [self addScorllViewWithCount:3];
    //添加button
    [self addbtnWithCount:3];
    
    //NSLog(@"%f",self.navigationController.navigationBar.height);
    //UIApplication * application = [UIApplication sharedApplication];
    //NSLog(@"%f",application.statusBarFrame.size.height);
}

//添加btn
- (void)addbtnWithCount:(int)count
{
    for (int i = 0; i<count;i++) {
        UIButton * btn= [[UIButton alloc]init];
        btn.width = self.view.width/count;
        btn.height = 50;
        btn.x = btn.width *i;
        btn.y = self.navigationController.navigationBar.height+20;
        [btn setTitle:@"服务" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(chooseView:) forControlEvents:UIControlEventTouchDown];
        btn.backgroundColor = [UIColor greenColor];
        btn.tag = i;
        [self.view addSubview:btn];
        
        //默认选中服务
        if (btn.tag==0) {
        [self chooseView:btn];
        }
       
    
    }
    
    
}

//按钮点击事件
-  (void)chooseView:(UIButton *)btn
{
    //选择btn
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;

    //变换container的contentOffset
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint  tempContentOffset = self.containerView.contentOffset;
        tempContentOffset.x= btn.tag* self.view.width;
        self.containerView.contentOffset = tempContentOffset;
    }];
    
    
}



//添加view
- (void)addScorllViewWithCount:(int)count
{
    
    //添加一个UIScrollView 的 容器view
    UIScrollView * containerView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    containerView.backgroundColor = [UIColor yellowColor];
    containerView.contentSize = CGSizeMake(self.view.width * count, self.view.height);
    containerView.showsHorizontalScrollIndicator = NO;
    containerView.showsVerticalScrollIndicator = NO;
    containerView.bounces = NO;
    containerView.pagingEnabled = YES;
    containerView.delegate = self;
    containerView.contentInset = UIEdgeInsetsMake(-70, 0, 0, 0);
    self.containerView = containerView;
    
    //添加三个子scrollView
    for (int i = 0;i<count;i++)
    {
    UIScrollView * serveView = [[UIScrollView alloc]init];
    serveView.x = 0;
    serveView.y = self.navigationController.navigationBar.height+20+50;;
    serveView.width = self.view.width*i;
    serveView.height = self.view.height-serveView.y;
    serveView.backgroundColor = KJRandomColor;
    [containerView addSubview:serveView];
        
    }


    [self.view addSubview:containerView];

}


- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
  
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    //选择btn
    
    //判断contenOffset的x
   int index = scrollView.contentOffset.x/self.view.width;
    for (UIView * view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            //如果是相应UIbutton,就点击一次事件
            UIButton * btn = (UIButton *)view;
            if (index==btn.tag) {
                [self chooseView:btn];
            }
        }
        
    }
   
}



@end
