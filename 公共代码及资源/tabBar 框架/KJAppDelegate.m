//
//  KJAppDelegate.m
//  0831-01（weibo -框架）
//
//  Created by 唐开江 on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "KJAppDelegate.h"
#import "KJMainViewController.h"
#import "KJNewfeatureViewController.h"
#import "KJOAouthViewController.h"
#import "KJAcount.h"
#import "KJSaveAcount.h"
#import "KJViewControllerTool.h"
#import "UIImageView+WebCache.h"
#define  versonKey  @"CFBundleVersion"
@interface KJAppDelegate()

@property (nonatomic, assign) UIBackgroundTaskIdentifier identifier;

@end
@implementation KJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //显示状态栏
    application.statusBarHidden = NO;
    
    //创建uiwindow
   self.window  = [[UIWindow alloc]init];
    self.window .backgroundColor = [UIColor redColor];
    self.window .frame = [UIScreen mainScreen].bounds;
    
    //设置主窗口
    [self.window makeKeyAndVisible];
    
    //取出沙盒里面的授权数据，如果没有数据（解归档）
  /*
   NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [documentPath stringByAppendingPathComponent:@"acount.data"];
    
    KJAcount * acountDict = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
   */
     KJAcount * acount = [KJSaveAcount  readAcount];
 
    
    if (acount) {
     
        //进入下个界面
         [KJViewControllerTool chooseRootViewController];
        
    }
    
        /*
         //取出以前版本号码
         NSString * key = ((__bridge NSString*)kCFBundleVersionKey);
         NSUserDefaults * standerd = [NSUserDefaults standardUserDefaults];
         NSString * localVersion =[standerd objectForKey:key];
         
         NSLog(@"%@",localVersion);
         
         
         
         // 当前版本
         NSDictionary * currentDict = [NSBundle mainBundle].infoDictionary;
         
         //找出沙盒的地址
//         /Users/tangkaijiang/Library/Application Support/iPhone Simulator/6.1/Applications/3C34C104-7994-419E-8744-935C4D1F67CB/Documents
        
         NSString * currentVersion = currentDict[versonKey];
         //    KJLog(@"%@",infoStr);
         
         // 两个版本对比
         if ([currentVersion compare:localVersion]) {
         
         //第一次打开，就进入新特性界面,scorellerView
         KJNewfeatureViewController * newFeatuVc = [[KJNewfeatureViewController alloc]init];
         self.window.rootViewController = newFeatuVc;
         
         //存储当前版本
         [standerd setObject:currentVersion forKey:key];
         [standerd synchronize];
         
         }
         else{
         
         //如果第二次打开，直接进入tabBarController
         KJMainViewController * mainCon = [[KJMainViewController alloc]init];
         self.window.rootViewController = mainCon;
         
         }
         
        
    } 
         */
    else
    {
        //创建授权controller
        KJOAouthViewController * OACtl = [[KJOAouthViewController alloc]init];
       self.window.rootViewController = OACtl;
    
    }
    
    
    
    
    
    return YES;
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
       //停止所有的下载任务
    [[SDWebImageManager sharedManager] cancelAll];
    
    //清空内存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    

}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
  //后台继续执行
    self.identifier = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:self.identifier];
    }];

}

@end
