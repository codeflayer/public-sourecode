//
//  KJSoundRecorder.h
//  1103-01(xmpp项目)
//
//  Created by 唐开江 on 14/11/8.
//  Copyright (c) 2014年 aili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJSoundRecorder : NSObject

//创建单例对象
+ (instancetype)sharedRecorder;
//开始录音
- (void)startRecorded;

/** 停止录音 */
- (void)stopRecordSuccess:(void (^)(NSURL *url, NSTimeInterval time))success faild:(void (^)())faild;
/** 播放音频数据 */
- (void)playData:(NSData *)data completion:(void (^)())completion;


@end
