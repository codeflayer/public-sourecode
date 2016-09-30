//
//  NSObject+Empty.m
//  wanghongmeimeida
//
//  Created by Jason T on 16/5/2.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "NSObject+Empty.h"

@implementation NSObject (Empty)




+ (BOOL) getVariableWithClass:(Class) myClass varName:(NSString *)name{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}


/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

@end


//            #import <objc/runtime.h>
//
//            @implementation NSObject (XXOOProperty)
//
//            /* 获取对象的所有属性和属性内容 */
//            - (NSDictionary *)getAllPropertiesAndVaules
//            {
//                NSMutableDictionary *props = [NSMutableDictionarydictionary];
//                unsigned int outCount, i;
//                objc_property_t *properties =class_copyPropertyList([selfclass], &outCount);
//                for (i = 0; i<outCount; i++)
//                {
//                    objc_property_t property = properties[i];
//                    const char* char_f =property_getName(property);
//                    NSString *propertyName = [NSStringstringWithUTF8String:char_f];
//                    id propertyValue = [selfvalueForKey:(NSString *)propertyName];
//                    if (propertyValue) [props setObject:propertyValue forKey:propertyName];
//                }
//                free(properties);
//                return props;
//            }


//            /* 获取对象的所有属性 */
//            - (NSArray *)getAllProperties
//            {
//                u_int count;
//                
//                objc_property_t *properties  =class_copyPropertyList([selfclass], &count);
//                
//                NSMutableArray *propertiesArray = [NSMutableArrayarrayWithCapacity:count];
//                
//                for (int i = 0; i < count ; i++)
//                {
//                    const char* propertyName =property_getName(properties[i]);
//                    [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
//                }
//                
//                free(properties);
//                
//                return propertiesArray;
//            }



//            /* 获取对象的所有方法 */
//            -(void)getAllMethods
//            {
//                unsigned int mothCout_f =0;
//                Method* mothList_f = class_copyMethodList([selfclass],&mothCout_f);
//                for(int i=0;i<mothCout_f;i++)
//                {
//                    Method temp_f = mothList_f[i];
//                    IMP imp_f = method_getImplementation(temp_f);
//                    SEL name_f = method_getName(temp_f);
//                    const char* name_s =sel_getName(method_getName(temp_f));
//                    int arguments = method_getNumberOfArguments(temp_f);
//                    const char* encoding =method_getTypeEncoding(temp_f);
//                    NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSStringstringWithUTF8String:name_s],
//                          arguments,
//                          [NSString stringWithUTF8String:encoding]);
//                }
//                free(mothList_f);
//            }
//
//            */
//            @end



