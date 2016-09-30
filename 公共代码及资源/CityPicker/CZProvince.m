//
//  CZProvince.m
//  02-数据联动
//
//  Created by apple on 05/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZProvince.h"

@implementation CZProvince

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)provinceWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)provinces
{
    // 1. 加载plist
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
    
    // 2. 生成省份数组
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self provinceWithDict:dict]];
    }
    return arrayM;
}

- (NSString *)cityNameWithIndex:(NSInteger)index
{
    // 判断索引是否越界
    if (index < self.cities.count) {
        return self.cities[index];
    } else {
        // 如果越界，返回空对象
        return nil;
    }
}

@end
