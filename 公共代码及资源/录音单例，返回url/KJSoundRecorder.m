//
//  KJSoundRecorder.m
//  1103-01(xmpp项目)
//
//  Created by 唐开江 on 14/11/8.
//  Copyright (c) 2014年 aili. All rights reserved.
//

#import "KJSoundRecorder.h"
#import <AVFoundation/AVFoundation.h>
@interface KJSoundRecorder()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSURL *recordURL;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) void (^playCompletion) ();
@end
@implementation KJSoundRecorder


//创建单例对象
+ (instancetype)sharedRecorder
{
    static KJSoundRecorder *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        // 1. 设置音频会话的分类（如果不设置，模拟器正常，真机无法录音）
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
        
        // 2. 录音设置字典(点联机文档，搜索AVAudioRecorder就可以查询到完成的设置代码)
        // 在即时通讯系统中，目前语音的使用率越来越高，要求压缩要高，用户对音质要求不高
        NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        [NSNumber numberWithFloat: 8000.0], AVSampleRateKey,                    // 采样率，数值越大，文件越大
                                        [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,     // 文件个数
                                        [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,                     // 声道
                                        [NSNumber numberWithInt: AVAudioQualityLow], AVEncoderAudioQualityKey,  // 音质
                                        nil];
        
        // 3. 实例化录音机
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"record.caf"];
        _recordURL = [NSURL fileURLWithPath:path];
        _recorder = [[AVAudioRecorder alloc] initWithURL:_recordURL settings:recordSettings error:NULL];
        
        // 4. 为了保证录音机启动速度，准备录音
        [_recorder prepareToRecord];
    }
    return self;

}


//开始录音
- (void)startRecorded
{

    [self.recorder record];
}

/** 停止录音 */
- (void)stopRecordSuccess:(void (^)(NSURL *url, NSTimeInterval time))success faild:(void (^)())faild
{
    // 如果录音时间过短，会提示用户
    // 取出当前录音时间
    NSTimeInterval time = self.recorder.currentTime;
    
    // 停止录音
    [self.recorder stop];
    
    // 判断录音时间
    if (time < 1.0) {
        // 提示用户
        if (faild) {
            faild();
        }
    } else {
        // 录音成功
        if (success) {
            success(self.recordURL, time);
        }
    }

}

#pragma mark - 播放
/** 完成播放代理方法 */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (self.playCompletion) {
        self.playCompletion();
    }
}

- (void)playData:(NSData *)data completion:(void (^)())completion {
    
    // 判断是否正在播放
    if (self.player.isPlaying) {
        [self.player stop];
    }
    
    // 记录块代码
    self.playCompletion = completion;
    
    // 需要监听播放器的播放状态
    self.player = [[AVAudioPlayer alloc] initWithData:data error:NULL];
    
    self.player.delegate = self;
    
    [self.player play];
}
@end
