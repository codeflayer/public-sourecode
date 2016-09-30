//
//  QCAppDelegate.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//

#import "QCAppDelegate.h"
//#import "QCLeftMenuViewController.h"
#import "vc.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "QCSlideViewController.h"

static const CGFloat kPublicLeftMenuWidth = 180.0f;

@implementation QCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /*
    //最左边的切出的控制器(这个方法里面创建了中间的控制器)
    QCLeftMenuViewController *leftVC = [[QCLeftMenuViewController alloc]
                                         initWithNibName:@"QCLeftMenuViewController"
                                         bundle:nil];
    
    
    //最主要的控制器，包含左边，右边，中间的控制器
    QCViewController * drawerController = [[QCViewController alloc]
                                            initWithCenterViewController:leftVC.navSlideSwitchVC
                                            leftDrawerViewController:leftVC
                                            rightDrawerViewController:nil];
     //设置左边控制器最大的宽度
    [drawerController setMaximumLeftDrawerWidth:kPublicLeftMenuWidth];
    
    //设置打开抽屉视图手势
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    //设置关闭抽屉视图的手势
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //更新视图的显示的回调（当滑动navigationBar的时候，会触发这段代码）
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        
        //设置滑动视图的视差时间2.0
        block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
        block(drawerController, drawerSide, percentVisible);
    }];

      [self.window setRootViewController:drawerController];
    */
    
    vc * vc2 = [[vc alloc]init];
    vc2.view.backgroundColor = [UIColor whiteColor];
//    QCSlideViewController * QCSlideViewVC = [[QCSlideViewController alloc]init];
   
     [self.window setRootViewController:vc2];
   
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
