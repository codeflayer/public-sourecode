//
//  NSObject+Empty.h
//  wanghongmeimeida
//
//  Created by Jason T on 16/5/2.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Empty)



/**判断某个类是否有某个属性*/
+ (BOOL) getVariableWithClass:(Class) myClass varName:(NSString *)name;

/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)getAllPropertiesAndVaules;

@end
