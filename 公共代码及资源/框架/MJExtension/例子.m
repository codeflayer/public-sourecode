//
//  KJStatus.m
//  08901-01（weibo -框架）navigationBar
//
//  Created by 唐开江 on 14-9-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "KJStatus.h"
#import "MJExtension.h"
#import "KJPhoto.h"
#import "NSDate+NJ.h"
@implementation KJStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [KJPhoto class]};
}


- (void)setPict_urls:(NSArray *)pict_urls
{
     
    _pic_urls = pict_urls;
//    NSLog(@"%d",_pict_urls.count);
}


//处理来源
- (NSString *)source
{
   NSString * str2 = _source;
    //开始的字符的长度
    NSInteger startIndex = [_source rangeOfString:@">"].location+1;
    //结束的字符的长度
    NSInteger endIndex = [_source rangeOfString:@"</"].location;
    NSInteger length = endIndex-startIndex;
    NSUInteger location = startIndex;
    //截取的范围
    NSRange range = NSMakeRange(location,length);
    NSString * str = [_source substringWithRange:range];
    
    NSString * newScourece = [NSString stringWithFormat:@"来自:%@",str];
    return newScourece;
}
//处理创建时间
- (NSString *)created_at
{
   //Sun Sep 07 14:30:02 +0800 2014
//    NSLog(@"%@",_created_at);
//    _created_at = @"Sun Sep 07 14:30:02 +0800 2014";
    //将创建时间转成NSDate
    NSDateFormatter *  formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier: @"en_US"];
    formatter.dateFormat =@"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate * createDate = [formatter dateFromString:_created_at];
 
   
//    NSLog(@"%@",createDate);
    
    
    /*
     1.今年发布
     
     >今天
     *1分钟内:刚刚
     *1个小时内:XX分钟前
     *其它:XX小时前
     
     >昨天
     *昨天 XX时:XX分
     
     >其它
     　＊xx月-xx日  XX时:XX分
     
     2.非今年发布
     　＊xx年xx月-xx日  XX时:XX分
     */
    //当前的date 与 返回的时间进行比较

    
    
//   NSLog(@"%@",_created_at);
    
    if([createDate isThisYear])
    {// 今年
        
        if ([createDate isToday])
        {//今天

            NSDateComponents * component =  [createDate deltaWithNow];
            NSInteger  hours = component.hour;
            NSInteger  minute= component.minute;
            NSInteger  seconds = component.second;
            
                if (hours>=1) {
                    
                    //*其它:XX小时前
                    
                    formatter.dateFormat = [NSString stringWithFormat:@"%d小时前", hours];
                    
                    return [formatter stringFromDate:createDate];
                   
                    
                }else if (minute>=1) {
                        //*1个小时内:XX分钟前
                        
                        formatter.dateFormat = [NSString stringWithFormat:@"%d分前",minute];
                       return [formatter stringFromDate:createDate];
//
            
               }else{
                
                //*1分钟内:刚刚
                
                return  [NSString stringWithFormat:@"刚刚"];
              
            }
            
         
            
        }else if( [createDate isYesterday])
        {//昨天
        
            formatter.dateFormat = @"MM月dd日 HH时mm分";
            return  [formatter stringFromDate:createDate];
            
        }else{
        //其它天
            
             formatter.dateFormat = @"MM月dd日 HH时mm分";
            return  [formatter stringFromDate:createDate];;
        }
       
        
    }
    else{
    // 其它年
           formatter.dateFormat =@"yyyy年MM月dd日 HH时mm分";
        return [formatter stringFromDate:createDate];
    }
    

}


@end
