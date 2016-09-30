//
//  GCDMulticastBaseObject.m
//  01-多播代理
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GCDMulticastBaseObject.h"

@interface GCDMulticastBaseObject() {
    // 代理的工作队列
    dispatch_queue_t moduleQueue;
    // C语言中的void *和OC中的id是等价的
    // 队列标记
    void *moduleQueueTag;
}

@end

@implementation GCDMulticastBaseObject

/**
 * 标准初始化方法
 **/
- (id)init
{
    return [self initWithDispatchQueue:NULL];
}

/**
 * Designated initializer.
 * 默认的实例化方法
 *
 * 指定工作队列，给队列打上标记，方便复用，创建了多播代理对象
 **/
- (id)initWithDispatchQueue:(dispatch_queue_t)queue
{
    if ((self = [super init])) {
        if (queue) {
            moduleQueue = queue;
        } else {
            // 如果不指定队列会创建一个串行队列
            const char *moduleQueueName = [NSStringFromClass(self.class) UTF8String];
            // 创建一个串行队列
            moduleQueue = dispatch_queue_create(moduleQueueName, NULL);
        }
        
        // 队列标记
        moduleQueueTag = &moduleQueueTag;
        // 给工作队列打上标签，可以在需要的时候，再次使用同样的队列调度任务
        dispatch_queue_set_specific(moduleQueue, moduleQueueTag, moduleQueueTag, NULL);
        
        // 实例化多播代理对象
        multicastDelegate = [[GCDMulticastDelegate alloc] init];
    }
    return self;
}

/** 添加代理 */
- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    // 异步操作
    // 1. 定义要执行的块代码
    dispatch_block_t block = ^{
        // 给多播代理成员变量，添加代理，调用 GCDMulticastDelegate内部方法
        [multicastDelegate addDelegate:delegate delegateQueue:delegateQueue];
    };
    
    // 2. 使用标签获取初始化时设定的队列
    if (dispatch_get_specific(moduleQueueTag)) {
        block();
    } else {
        // 直接在异步执行
        dispatch_async(moduleQueue, block);
    }
}

/**
 删除代理，最终删除代理的方法
 
 1. 代理
 2. 代理的工作队列
 3. 是否"同步"，如果YES，如果工作队列当前正在调度代理执行耗时的操作，直接删除代理会有问题，
 因此使用同步，可以保证队列调度的任务执行完成之后，再将代理删除
 */
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue synchronously:(BOOL)synchronously
{
    // 定义块代码
    dispatch_block_t block = ^{
        // 直接调用多播代理的删除代理方法
        [multicastDelegate removeDelegate:delegate delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(moduleQueueTag)) {
        block();
    } else if (synchronously) {
        dispatch_sync(moduleQueue, block);
    } else {
        dispatch_async(moduleQueue, block);
    }
}

// 删除代理 － 同步
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    [self removeDelegate:delegate delegateQueue:delegateQueue synchronously:YES];
}

// 删除代理方法 － 同步
- (void)removeDelegate:(id)delegate
{
    [self removeDelegate:delegate delegateQueue:NULL synchronously:YES];
}

@end
