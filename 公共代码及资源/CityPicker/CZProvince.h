//
//  CZProvince.h
//  02-数据联动
//
//  Created by apple on 05/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZProvince : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *cities;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provinceWithDict:(NSDictionary *)dict;

/** 返回所有省份的数组 */
+ (NSArray *)provinces;

/** 根据索引取出所在的城市名称 */
- (NSString *)cityNameWithIndex:(NSInteger)index;

@end
