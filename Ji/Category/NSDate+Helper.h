//
//  NSDate+Helper.h
//  BillsTool
//
//  Created by guoyalun on 10/9/13.
//  Copyright (c) 2013 郭亚伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)
- (NSString *)formate:(NSString *)formatter;
-(NSDate *)BJDate;
- (NSTimeInterval)timeIntervalFromMidNightDuranOneDay;
- (NSInteger)daysOfWeek;
- (NSString *)friendlyTime;
@end
