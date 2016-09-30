//
//  CZCoreDataTools.m
//  07-纯Core Data
//
//  Created by apple on 14-10-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZCoreDataTools.h"

@implementation CZCoreDataTools

+ (instancetype)sharedCoreDataTools {
    static CZCoreDataTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

// 问题：单例我们希望被广泛使用，不能确定模型的名称，同时数据库的文件名也不确定
- (void)setupCoreDataWithModelName:(NSString *)modelName dbName:(NSString *)dbName {

    // 1. 实例化数据模型
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // 2. 实例化持久化存储调度器
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 3. 指定保存的数据库文件，以及类型
    // 数据库保存的URL
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    dbPath = [dbPath stringByAppendingPathComponent:dbName];
    NSURL *dbURL = [NSURL fileURLWithPath:dbPath];
    
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbURL options:nil error:NULL];
    
    // 4. 被管理对象的上下文
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    // 指定上下文的持久化调度
    [_managedObjectContext setPersistentStoreCoordinator:psc];
}

- (void)saveContext {
    [self.managedObjectContext save:NULL];
}


@end
