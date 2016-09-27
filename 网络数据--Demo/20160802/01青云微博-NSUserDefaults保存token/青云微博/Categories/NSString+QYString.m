//
//  NSString+QYString.m
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSString+QYString.h"

@implementation NSString (QYString)

+ (instancetype)descriptionWithString:(NSString *)strDate {
    // 1, 获取当前的时间
    NSDate *dateNow = [NSDate date];
    
    // 2, 获得发布时间
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    NSDate *datePunlish = [formatter dateFromString:strDate];
    //NSDate *datePunlish = [NSDate dateWithTimeIntervalSinceNow:-100];
    
    // 3, 计算两个时间的时间差
    NSTimeInterval interval =[dateNow timeIntervalSinceDate:datePunlish];
    
    // 4, 根据时间差的结果进行分类, 刚刚(1分钟内), 几分钟前, 几个小时之前, 几天前.....
    NSLog(@"---------%f", interval);
    NSString *strDateDes = nil;
    if (interval <= 60) { // 一分钟内
        strDateDes = @"刚刚";
    } else if (interval <= 60 * 60) { // 一个小时内
        strDateDes = [NSString stringWithFormat:@"%ld分钟前", (NSInteger)interval / 60 + 1];
    } else if (interval <= 60 * 60 * 24) { // 几个小时之前
        strDateDes = [NSString stringWithFormat:@"%ld小时前", (NSInteger)interval / (60 * 60) + 1];
    } else { // 几天前
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        strDateDes = [formatter stringFromDate:datePunlish];
    }
    
    return strDateDes;
}

@end
