//
//  GCDMulticastBaseObject.h
//  01-多播代理
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDMulticastDelegate.h"

@interface GCDMulticastBaseObject : NSObject {
    // 多播代理
    id multicastDelegate;
}

- (id)init;
- (id)initWithDispatchQueue:(dispatch_queue_t)queue;

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate;

@end
