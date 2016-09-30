
//  KJMainViewController.m
//  0831-01（weibo -框架）
//
//  Created by 唐开江 on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "KJMainViewController.h"
#import "KJDiscoverViewController.h"
#import "KJHomeViewController.h"
#import "KJMessageViewController.h"
#import "KJProfileViewController.h"
#import "KJnavigationController.h"
#import "KJComposeViewController.h"
#import "AFNetworking.h"
#import "KJSaveAcount.h"
#import "KJAcount.h"
#import "KJTabBar.h"
#import "KJTabBarItem.h"
#import "KJStatusTool.h"
#import "KJUserTool.h"
#import "KJUnReadResponseResult.h"
#import "KJUnReadRequestParams.h"
@interface KJMainViewController ()<tabBarDelegate>
@property (nonatomic,strong)KJTabBar * mytabBar;
@property (nonatomic,strong)KJHomeViewController * homeCtrl;
@property (nonatomic,strong)KJMessageViewController * messageCtrl;
@property (nonatomic,strong)KJDiscoverViewController * discoverCtrl;
@property (nonatomic,strong)KJProfileViewController * profileCtrl;


@end

@implementation KJMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //添加子控制器
        
     
        
        //1home
        KJHomeViewController * home = [[KJHomeViewController alloc]init];
        [self addOneChildController:home image:@"tabbar_home" andSelectedImage:@"tabbar_home_selected" controllerName:@"主页"];
        self.homeCtrl = home;
        
        //2message
        KJMessageViewController * message = [[KJMessageViewController alloc]init];
        
        [self addOneChildController:message image:@"tabbar_message_center" andSelectedImage:@"tabbar_message_center_selected" controllerName:@"消息"];
        self.messageCtrl = message;
        
        //3dicover
        KJDiscoverViewController * discover = [[KJDiscoverViewController alloc]init];
        
        [self addOneChildController:discover image:@"tabbar_discover" andSelectedImage:@"tabbar_discover_selected" controllerName:@"广场"];
        self.discoverCtrl = discover;
      
        //4profile
        KJProfileViewController * profile = [[KJProfileViewController alloc]init];
        
        [self addOneChildController:profile image:@"tabbar_profile" andSelectedImage:@"tabbar_profile_selected" controllerName:@"我"];
        self.profileCtrl =profile;
   
    }
    
    return self;
}

//添加自控制器
- (void)addOneChildController:(UITableViewController * )controller image:(NSString *)image andSelectedImage:(NSString *)selectedImage controllerName:(NSString *)name;
{
     //设置控制器的tabBarItem的背景图片
    controller.tabBarItem.image = [UIImage imageWithName:image];
  
    controller.tabBarItem.title = name;
    controller.title = name;
    controller.view.backgroundColor=[UIColor whiteColor];
    
    //设置控制器的tabBarItem的选中背景图片
     controller.tabBarItem.selectedImage = [UIImage imageWithName:selectedImage];
    
   //如果是ios7的话设置tabBarItem的背景图片，不渲染图片
    if (iOS7) {
        UIImage * image = [UIImage imageWithName:selectedImage];
        controller.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    //创建一个navigationController
    KJnavigationController * nav =  [[KJnavigationController alloc]initWithRootViewController:controller];
    
    //添加自控件
   
    
    [self addChildViewController:nav];
    
    //添加一个自定义的按钮
    [self.mytabBar  addTabBarItem:controller.tabBarItem];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self addtabBar];
   
    //定时发送请求
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(postMessage) userInfo:nil repeats:YES];
    
}





- (void)addtabBar
{
    //1。自定义tabBar
    KJTabBar * myTabBar = [[KJTabBar alloc]init];
    myTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    myTabBar.frame =self.tabBar.bounds;
    self.mytabBar = myTabBar;
    //设置代理
    myTabBar.delegate = self;

    
    //3 。添加myTabBar到系统的tabBar
    [self.tabBar addSubview:myTabBar];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
        //2。移除tabBar的子控件
    
    for (UIView *item in self.tabBar.subviews) {
        
        if (![item isKindOfClass:[KJTabBar class]]) {
             [item removeFromSuperview];
    
        }
//        NSLog(@"%@",item);
        
    }
   
}
#pragma mark -- tabBar 代理方法

- (void)KJTabBar:(KJTabBar *)tabBar swithfrom:(NSUInteger)from to:(NSUInteger)to
{ //切换控制器
    self.selectedIndex = to;
    //下拉刷新
    if (0==to&&0==from)
    [self.homeCtrl refresh];
   
}
- (void)KJTabBarDidClickPlusBtn:(UIButton *)plusBtn
{
    
//    NSLog(@"ddff");
    KJComposeViewController * composeCtrl = [[KJComposeViewController alloc]init];
  
    UINavigationController * composeNvCtrl = [[UINavigationController alloc]initWithRootViewController:composeCtrl];
    

   //展现控制器
    [self presentViewController:composeNvCtrl animated:YES completion:nil];
}


@end
