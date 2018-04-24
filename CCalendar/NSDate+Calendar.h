//
//  NSDate+Calendar.h
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/23.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

+ (NSInteger)yearFromDate:(NSDate *)date;
+ (NSInteger)monthFromDate:(NSDate *)date;
+ (NSInteger)dayFromDate:(NSDate *)date;
+ (NSInteger)daysAtMonthFromDate:(NSDate *)date;
/**
 从周日、一、二、三、四、五、六顺序算起
 获取当前日期星期几
 @param date 当前日期
 @return 周日到周六之间的下表索引
 */
+ (NSInteger)firstDayWeeklyAtDate:(NSDate *)date;

//+ (NSDate *)firstDayDateFromDate:(NSDate *)date;
//+ (NSDate *)lastMonthDateFromDate:(NSDate *)date;
//+ (NSDate *)nextMonthDateFromDate:(NSDate *)date;

+ (BOOL)isTodayFromDate:(NSDate *)date;
+ (NSString *)getHolidayFromDate:(NSDate *)date;

@end
