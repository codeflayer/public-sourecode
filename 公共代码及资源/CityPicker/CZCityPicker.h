//
//  CZCityPicker.h
//  02-数据联动
//
//  Created by apple on 05/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 1. 定义协议
 2. 定义代理属性
 3. 在需要的时候，通知代理执行协议方法
 */

@class CZCityPicker;

@protocol CZCityPickerDelegate <NSObject>

@optional
- (void)cityPicker:(CZCityPicker *)cityPicker selectedCityName:(NSString *)cityName;

@end

@interface CZCityPicker : UIPickerView

// 因为UIPickerView本身就有一个delegate属性，因此再定义的属性不能够以delegate命名
@property (nonatomic, weak) id <CZCityPickerDelegate> cityDelegate;

@end
