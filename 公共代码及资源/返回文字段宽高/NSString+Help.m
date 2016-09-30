//
//  NSString+Help.m
//  03-QQ聊天
//
//  Created by apple on 14-7-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+Help.h"

@implementation NSString (Help)

// 计算文字尺寸
// 传一个文字，字体，最大的size
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

@end
