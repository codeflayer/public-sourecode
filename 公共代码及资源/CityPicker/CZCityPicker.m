//
//  CZCityPicker.m
//  02-数据联动
//
//  Created by apple on 05/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZCityPicker.h"
#import "CZProvince.h"

@interface CZCityPicker() <UIPickerViewDataSource, UIPickerViewDelegate>
/** 省份数组 */
@property (nonatomic, strong) NSArray *provinces;
@end

@implementation CZCityPicker

- (NSArray *)provinces
{
    if (!_provinces) _provinces = [CZProvince provinces];
    return _provinces;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置数据源&代理
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 如果是第0列->省份数量
    if (component == 0) {
        return self.provinces.count;
    } else {
        // 如果是第1列->根据第0列选中的省，返回城市数量
        int selectedRow = [pickerView selectedRowInComponent:0];
        // 当前选中的省的对象
        CZProvince *p = self.provinces[selectedRow];
        
        return p.cities.count;
    }
}

#pragma mark - 代理方法
// 返回component列row行对应的字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 如果是第0列，返回省份的名称
    if (component == 0) {
        // id可以直接使用对象的get方法，但是不能使用点语法
        return [self.provinces[row] name];
    } else {
        // 根据第0列选中的省份，返回row对应的城市
        int selectedRow = [pickerView selectedRowInComponent:0];
        
        CZProvince *p = self.provinces[selectedRow];
        
        return [p cityNameWithIndex:row];
    }
}

// 选中component列&row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 只有第0列变化需要刷新第1列的内容
    if (component == 0) {
        [pickerView reloadComponent:1];
    }
    
    // 设置文本标签的内容，显示当前选择的城市！
    // 获取当前选中的城市名称
    // 1> 第0列选中的省
    int pRow = [pickerView selectedRowInComponent:0];
    // 2> 第1列选中的市
    int cRow = [pickerView selectedRowInComponent:1];
    
    NSString *cityName = [self.provinces[pRow] cityNameWithIndex:cRow];
    
    // 判断代理是否实现了协议方法
    if ([self.cityDelegate respondsToSelector:@selector(cityPicker:selectedCityName:)]) {
        [self.cityDelegate cityPicker:self selectedCityName:cityName];
    }
}

@end
