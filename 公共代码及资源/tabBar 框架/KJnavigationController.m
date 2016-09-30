//
//  KJnavigationController.m
//  08901-01（weibo -框架）navigationBar
//
//  Created by 唐开江 on 14-9-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "KJnavigationController.h"

@interface KJnavigationController ()

@end

@implementation KJnavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}


+ (void)initialize
{
    //设置navigationBar的背景和属性
    [self setTheme];
    
    
}

+ (void)setTheme
{

    //设置navigationBar的背景和属性
       UINavigationBar * nav = [UINavigationBar appearance];
    if (!iOS7) {
     
        [nav setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
 
    NSMutableDictionary * titleDict = [NSMutableDictionary dictionary];
    titleDict[UITextAttributeFont]= [UIFont systemFontOfSize:20];
    titleDict[UITextAttributeTextColor]= [UIColor blackColor];
    titleDict[UITextAttributeTextShadowOffset] =[NSValue valueWithUIOffset: UIOffsetZero];
    
    [nav setTitleTextAttributes:titleDict];
    [nav setTintColor:[UIColor blackColor]];

    
    //设置barButtonItem的属性
       UIBarButtonItem * barButton = [UIBarButtonItem appearance];
    if ( !iOS7) {
       [barButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
 
    //普通状态
    NSMutableDictionary * textDict = [NSMutableDictionary dictionary];
    textDict[UITextAttributeFont]= [UIFont systemFontOfSize:16];
    textDict[UITextAttributeTextColor]= [UIColor purpleColor];
    textDict[UITextAttributeTextShadowOffset] =[NSValue valueWithUIOffset: UIOffsetZero];
    [barButton setTitleTextAttributes:textDict forState:UIControlStateNormal];
    //高亮状态
    NSMutableDictionary * textDictH = [NSMutableDictionary dictionary];
    textDictH[UITextAttributeFont]= [UIFont systemFontOfSize:16];
    textDictH[UITextAttributeTextColor]= [UIColor redColor];
    textDictH[UITextAttributeTextShadowOffset] =[NSValue valueWithUIOffset: UIOffsetZero];
    [barButton setTitleTextAttributes:textDictH forState:UIControlStateHighlighted];
    
    //  返回按钮的属性
    [barButton setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.navigationBar.backgroundColor = [UIColor redColor];
    if (iOS7) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIViewController * destController = viewController;

    if ( self.childViewControllers.count>0) {
        destController.hidesBottomBarWhenPushed = YES;
    
        //左边的返回按钮
        destController.navigationItem.leftBarButtonItem = [KJNaviBarbuttonItem setBarButtonItemWithnormlimgeName:@"navigationbar_back" andhiImage:@"navigationbar_back_highlighted" and:@selector(backClick) with:self];
        //右边返回按钮
        destController.navigationItem.rightBarButtonItem = [KJNaviBarbuttonItem setBarButtonItemWithnormlimgeName:@"navigationbar_more" andhiImage:@"navigationbar_more_highlighted" and:@selector(back2Top) with:self];
        
        
    }
    
 [super pushViewController:viewController animated:YES];
  
    
}

//左边返回backClick的点击方法
- (void)backClick
{
   
    [self popViewControllerAnimated:YES];
}
//右边返回backClick的点击方法
- (void)back2Top
{
     [self popToRootViewControllerAnimated:YES];
    
}
@end
