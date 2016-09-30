//
//  CZAudioTool.m
//  01 - 音效播放
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZAudioTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation CZAudioTool

//static SystemSoundID _soundid;

//fileName  key  soundId value

static NSMutableDictionary *_allSondId;

static NSMutableDictionary *_allAudioPlayer;


+(void)initialize
{
    //初始化  字典 用来存储 文件名对应的soundId
    _allSondId = [NSMutableDictionary dictionary];
    
    _allAudioPlayer = [NSMutableDictionary dictionary];
}

+ (void)playSoundWithFileName:(NSString *)fileName
{
    //1.fileName要做key 不能为空
    if (fileName == nil) {
        return;
    }

    //2.从字典当中取 soundId  用来播放
    SystemSoundID soundId = [_allSondId[fileName] unsignedLongValue];
    
    //如果取不到  就创建一个新的 并且添加到字典当中
    if (!soundId) { //创建 soundid
        //1.音效文件的路径
        NSURL *url = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
        
        //2.如果调用方 传进来的文件名  不存在 也直接返回
        if (!url)
        {
            return;
        }
        //3.创建soundid
        //SystemSoundID soundid = 0;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        
        //4.加到字典当中
        _allSondId[fileName] = @(soundId);
        
    }
    
    
    //3.播放音效
    AudioServicesPlaySystemSound(soundId);
}

+ (void)disposesoundWithFileName:(NSString *)fileName
{
    
    //1.fileName要做key 不能为空
    if (fileName == nil) {
        return;
    }
    //2.从字典当中取 soundId  用来播放
    SystemSoundID soundId = [_allSondId[fileName] unsignedLongValue];
    

    //3.如果字典中有 就删除音效文件
    if (soundId) {
       AudioServicesDisposeSystemSoundID(soundId);
       //把音效文件从字典中移除
       
        [_allSondId removeObjectForKey:fileName];
    }
    
}



//播放音乐
+ (void)playMusicWithFileName:(NSString *)fileName
{
//    NSURL *url = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
//    
//    
//    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
//    
//    [player prepareToPlay];
//    
//    [player play];
    
    
    
    
    //1.fileName要做key 不能为空
    if (fileName == nil) {
        return;
    }
    
    //2.从字典当中取 soundId  用来播放
    AVAudioPlayer *player  = _allAudioPlayer[fileName];
    
    
    //如果取不到  就创建一个新的 并且添加到字典当中
    if (player == nil) { //创建 AVAudioPlayer
        //1.音乐文件的路径
        NSURL *url = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
        
        //2.如果调用方 传进来的文件名  不存在 也直接返回
        if (!url)
        {
            return;
        }
        //3.创建AVAudioPlayer
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
        
        //4.加到字典当中
        _allAudioPlayer[fileName] = player;
        
    }
    
    
    //3.播放音乐

    //准备播放的缓冲
    [player prepareToPlay];

    //播放
    [player play];
}

//停止音乐
+ (void)stopMusicWithFileName:(NSString *)fileName
{
    //1.fileName要做key 不能为空
    if (fileName == nil) {
        return;
    }
    
    //2.从字典当中取 soundId  用来播放
    AVAudioPlayer *player  = _allAudioPlayer[fileName];
    
    if (player) {
        
        [player stop];
        
        [_allAudioPlayer removeObjectForKey:fileName];
    }
    
}

//暂停音乐
+ (void)pauseMusicWithFileName:(NSString *)fileName
{
    //1.fileName要做key 不能为空
    if (fileName == nil) {
        return;
    }
    
    //2.从字典当中取 soundId  用来播放
    AVAudioPlayer *player  = _allAudioPlayer[fileName];
    
    if (player) {
        
        [player pause];
    }
    
}



@end
