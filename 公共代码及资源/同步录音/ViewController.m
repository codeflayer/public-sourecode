//
//  ViewController.m
//  07-同步录音
//
//  Created by apple on 14-11-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVAudioPlayerDelegate>
/** 录音设备 */
@property (nonatomic, strong) AVAudioRecorder *recorder;
/** 监听设备 */
@property (nonatomic, strong) AVAudioRecorder *monitor;
/** 录音文件的URL */
@property (nonatomic, strong) NSURL *recordURL;
/** 监听器 URL */
@property (nonatomic, strong) NSURL *monitorURL;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置录音机
    [self setupRecorder];
    
    // 设置时钟
    [self setupTimer];
}

/** 设置时钟 */
- (void)setupTimer {
    // 开始监听录音
    [self.monitor record];
    
    // 启动时钟
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)updateTimer {
    // 检测monitor的音量，是否需要开始录音
    // 1.更新一下
    [self.monitor updateMeters];
    
    // 2. 获得0声道的音量，完全没有声音-160.0，0是最大音量
    float power = [self.monitor peakPowerForChannel:0];
    
    NSLog(@"%f", power);
    if (power > -20) {
        // 开始录音
        if (!self.recorder.isRecording) {
            NSLog(@"开始录音");
            [self.recorder record];
        }
    } else {
        // 音量小，判断是否在录音，如果在录音，停止录音
        if (self.recorder.isRecording) {
            NSLog(@"停止录音");
            [self.recorder stop];
            
            // 播放录音
            [self play];
        }
    }
}

/** 设置录音环境 */
- (void)setupRecorder {
    // 1. 音频会话
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
    
    // 2. 设置录音机
    NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithFloat: 14400.0], AVSampleRateKey,
                                    [NSNumber numberWithInt: kAudioFormatAppleIMA4], AVFormatIDKey,
                                    [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                                    nil];
    
    // 3. 实例化录音机
    NSString *recordPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"record.caf"];
    _recordURL = [NSURL fileURLWithPath:recordPath];
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:_recordURL settings:recordSettings error:NULL];
    
    // 4. 监听器
    NSString *monitorPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"monitor.caf"];
    _monitorURL = [NSURL fileURLWithPath:monitorPath];
    
    _monitor = [[AVAudioRecorder alloc] initWithURL:_monitorURL settings:recordSettings error:NULL];
    _monitor.meteringEnabled = YES;
}

#pragma mark - 播放代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // 重新启动时钟
    [self setupTimer];
}

/** 播放录音 */
- (void)play {

    // 时钟停止
    [self.timer invalidate];
    
    // 监听器也停止
    [self.monitor stop];
    // 删除监听器的录音文件
    [self.monitor deleteRecording];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordURL error:NULL];
    // 播放完成之后，继续录音，监听播放状态
    self.player.delegate = self;
    [self.player prepareToPlay];
    
    // 允许速度
    self.player.enableRate = YES;
    
    // 速度最大是2，最小是0.5
    self.player.rate = 2;
    
    [self.player play];
}

@end
