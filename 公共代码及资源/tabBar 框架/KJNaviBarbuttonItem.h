//
//  KJNaviBarbuttonItem.h
//  08901-01（weibo -框架）navigationBar
//
//  Created by 唐开江 on 14-9-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJNaviBarbuttonItem : UIButton

+ (UIBarButtonItem *)setBarButtonItemWithnormlimgeName:(NSString *)normalImage andhiImage:(NSString *)hiImage and:(SEL)action with:(id)target;

@end
