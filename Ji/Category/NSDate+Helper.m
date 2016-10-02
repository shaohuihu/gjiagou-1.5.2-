//
//  NSDate+Helper.m
//  BillsTool
//
//  Created by guoyalun on 10/9/13.
//  Copyright (c) 2013 郭亚伦. All rights reserved.
//

#import "NSDate+Helper.h"


@implementation NSDate (Helper)

+ (NSInteger)dayOfMonth:(NSInteger)month ofYear:(NSInteger)year
{
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        default:
            if ((year%4==0 && year%100!=0) || (year%400 == 0)) {
                return 29;
            }
            return 28;
    }

}
- (NSString *)formate:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterString;
	[formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
	NSString *str = [formatter stringFromDate:self];
    return str;
}

- (NSDate *)BJDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: self];
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;
}

- (NSTimeInterval)timeIntervalFromMidNightDuranOneDay
{
    
    NSInteger hours = [[self formate:@"HH"] integerValue];
    NSInteger mins = [[self formate:@"mm"] integerValue];
    
    return hours*60*60+mins*60;
}


- (NSInteger)daysOfWeek
{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    int weekday = [weekdayComponents weekday];
       //获得的weekday对应周日为1 周六为7，
    int result = 0;
    result = weekday-1;
    if(result==0){
        result = 7;
    }
    return result;
}

- (NSString *)friendlyTime{
    time_t current_time = time(NULL);
    
//    static NSDateFormatter *dateFormatter =nil;
//    if (dateFormatter == nil) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        dateFormatter.timeZone = [NSTimeZone systemTimeZone];
//    }
//    
//    NSDate *date = [dateFormatter dateFromString:self];
    
    time_t this_time = [self timeIntervalSince1970];
    
    time_t delta = current_time - this_time;
    
    if (delta <= 0) {
        return @"刚刚";
    }
    else if (delta <60)
        return [NSString stringWithFormat:@"%ld秒前", delta];
    else if (delta <3600)
        return [NSString stringWithFormat:@"%ld分钟前", delta /60];
    else {
        struct tm tm_now, tm_in;
        localtime_r(&current_time, &tm_now);
        localtime_r(&this_time, &tm_in);
        NSString *format = nil;
        
        if (tm_now.tm_year == tm_in.tm_year) {
            if (tm_now.tm_yday == tm_in.tm_yday)
                format = @"今天 %-H:%M";
            else
                format = @"%-m月%-d日 %-H:%M";
        }
        else
            format = @"%Y年%-m月%-d日 %-H:%M";
        
        char buf[256] = {0};
        strftime(buf, sizeof(buf), [format UTF8String], &tm_in);
        return [NSString stringWithUTF8String:buf];
    }

}


@end
