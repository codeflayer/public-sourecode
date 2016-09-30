//
//  QCSlideViewController.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//




//-----------------新建自己controller 代理 QCListViewController------------------------



#import "QCSlideViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "QCListViewController.h"

@interface QCSlideViewController ()

@end

@implementation QCSlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //设置导航栏样式
    self.title = @"滑动切换视图";
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    
    // 创建6个控制器
    self.vc1 = [[QCListViewController alloc] init];
    self.vc1.title = @"清忧";
    
    self.vc2 = [[QCListViewController alloc] init];
    self.vc2.title = @"清澈";
    
    self.vc3 = [[QCListViewController alloc] init];
    self.vc3.title = @"清静";
    
    self.vc4 = [[QCListViewController alloc] init];
    self.vc4.title = @"清秋";
    
    self.vc5 = [[QCListViewController alloc] init];
    self.vc5.title = @"清晓";
    
    self.vc6 = [[QCListViewController alloc] init];
    self.vc6.title = @"清幽";
    

    [self.slideSwitchView buildUI];
}

#pragma mark - 滑动tab视图代理方法


//创建中间要滑动的view和tab的个数(这个必须指定，否则不知道要创建多少个tab，必须实现)
- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return 3;
}

//返回中间滑动的控制器，传递一个view一个tab的number就返回对应一个控制器(这个必须指定，并且要上面的numberOfTab 对应，不能少于上面的个数。必须实现)
- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else if (number == 4) {
        return self.vc5;
    } else if (number == 5) {
        return self.vc6;
    } else {
        return nil;
    }
}


//指定点击tab跳转到对应的控制器
- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    QCListViewController *vc = nil;
    if (number == 0) {
        vc = self.vc1;
    } else if (number == 1) {
        vc = self.vc2;
    } else if (number == 2) {
        vc = self.vc3;
    } else if (number == 3) {
        vc = self.vc4;
    } else if (number == 4) {
        vc = self.vc5;
    } else if (number == 5) {
        vc = self.vc6;
    }
    
    //提示当前的显示的view
    [vc viewDidCurrentView];
}


//指定一进来就选中某个选项
- (NSUInteger)firstSeletTab:(QCSlideSwitchView *)view
{
    return 2;
}



#pragma mark - 内存报警

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
