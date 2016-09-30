//
//  CZCoreDataTools.h
//  02-CoreData多线程演练
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CZCoreDataTools : NSObject

+ (instancetype)sharedCoreDataTools;

/** 主线程的上下文（子－做少量数据操作） */
@property (nonatomic, strong) NSManagedObjectContext *mainThreadContext;
/** 后台线程的上下文（父－做大量数据操作） */
@property (nonatomic, strong) NSManagedObjectContext *backgroundContext;

/** 设置 多线程 Core Data Stack */
- (void)setupCoreDataWithModelName:(NSString *)modelName dbName:(NSString *)dbName;

/** 保存上下文 */
- (void)saveContextWithCompletion:(void (^)())completion;

@end
