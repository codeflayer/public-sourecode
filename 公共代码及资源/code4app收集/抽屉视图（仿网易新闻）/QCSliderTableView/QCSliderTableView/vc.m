//
//  vc.m
//  QCSliderTableView
//
//  Created by 唐开江 on 15/1/14.
//  Copyright (c) 2015年 Scasy. All rights reserved.
//

#import "vc.h"
#import "QCSlideViewController.h"

@interface vc ()

@end

@implementation vc

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    QCSlideViewController * sliderVC = [[QCSlideViewController alloc]init];
    sliderVC.firstTab = 1;
    
    sliderVC.view.backgroundColor = [UIColor redColor];
    [self presentViewController:sliderVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
