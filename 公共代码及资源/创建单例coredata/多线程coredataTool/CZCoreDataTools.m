//
//  CZCoreDataTools.m
//  02-CoreData多线程演练
//
//  Created by apple on 14-11-7.
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

/** 设置 多线程 Core Data Stack */
- (void)setupCoreDataWithModelName:(NSString *)modelName dbName:(NSString *)dbName {
    
    // 实例化模型
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    
    // 实例化持久化存储调度
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 添加持久话存储文件 SQLite 文件
    NSURL *dbURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
    dbURL = [dbURL URLByAppendingPathComponent:dbName];
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbURL options:nil error:NULL];
    
    // 管理对象的上下文
    /**
     NSConfinementConcurrencyType		= 0x00,    这个选项已经作废，不建议在新的代码中使用，如果不指定参数，会使用这个选项
     NSPrivateQueueConcurrencyType	= 0x01,    后台(私有)队列
     NSMainQueueConcurrencyType			= 0x02     主队列并发类型（主线程的上下文）
     */
    _backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    // 设置后台上下文的持久化调度，真正和数据库打交道
    // persistentStoreCoordinator不是线程安全的，做多线程同样是要保证只有一个线程来同一时间修改数据库
    _backgroundContext.persistentStoreCoordinator = psc;
    
    _mainThreadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    // 设置主线程上下文的父上下文
    _mainThreadContext.parentContext = _backgroundContext;
}

/** 保存上下文 */
- (void)saveContextWithCompletion:(void (^)())completion {
    // 1. 判断上下文的内容是否有变化
    if (self.mainThreadContext.hasChanges || self.backgroundContext.hasChanges) {
        NSLog(@"主线程上下文保存 -> %@", [NSThread currentThread]);
        
        // 2. 首先让主线程上下文（子）做一次保存操作
        // 保存之后，"对象图"的修改状态会自动传递给父上下文，对象图会合并
        [self.mainThreadContext save:NULL];
        
        // 3. 将后台上下文的内容保存到磁盘
        /**
         在Core Data中要异步执行操作，只有一个方法 performBlock
         *** 没有 performBlock 就不会在后台线程调用
         */
        [self.backgroundContext performBlock:^{
            // 在后台保存
            NSLog(@"后台线程上下文保存 -> %@", [NSThread currentThread]);
            [self.backgroundContext save:NULL];
            
            // 通常数据保存完成后，会需要回调，通知调用放操作完成
            // 回调方法需要在主线程上执行
            // *** 没有 performBlock 就不会回到主线程调用
            [self.mainThreadContext performBlock:^{
                NSLog(@"主线程回调 -> %@", [NSThread currentThread]);
                
                if (completion) {
                    completion();
                }
            }];
        }];
    }
}

@end
