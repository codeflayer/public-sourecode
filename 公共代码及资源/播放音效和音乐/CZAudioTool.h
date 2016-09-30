//
//  CZAudioTool.h
//  01 - 音效播放
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZAudioTool : NSObject

//播放音效
+ (void)playSoundWithFileName:(NSString *)fileName;

//销毁音效
+ (void)disposesoundWithFileName:(NSString *)fileName;


//播放音效
+ (void)playMusicWithFileName:(NSString *)fileName;

//停止音效
+ (void)stopMusicWithFileName:(NSString *)fileName;

//暂停音效
+ (void)pauseMusicWithFileName:(NSString *)fileName;
@end
