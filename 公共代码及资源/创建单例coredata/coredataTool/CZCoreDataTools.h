//
//  CZCoreDataTools.h
//  07-纯Core Data
//
//  Created by apple on 14-10-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CZCoreDataTools : NSObject

+ (instancetype)sharedCoreDataTools;

/**
 *  使用模型名称&数据库名称初始化Core Data Stack
 */
- (void)setupCoreDataWithModelName:(NSString *)modelName dbName:(NSString *)dbName;

/**
 *  被管理对象的上下文
 */
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

/**
 *  保存上下文
 */
- (void)saveContext;

@end
