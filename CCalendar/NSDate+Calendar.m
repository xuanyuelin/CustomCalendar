//
//  NSDate+Calendar.m
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/23.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

+ (NSInteger)yearFromDate:(NSDate *)date
{
    return [self componentsFromDate:date].year;
}

+ (NSInteger)monthFromDate:(NSDate *)date
{
    return [self componentsFromDate:date].month;
}

+ (NSInteger)dayFromDate:(NSDate *)date
{
    return [self componentsFromDate:date].day;
}

+ (NSDateComponents *)componentsFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
}

+ (NSInteger)daysAtMonthFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSInteger)firstDayWeeklyAtDate:(NSDate *)date
{
//    NSArray *weekdays = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:timeZone];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return components.weekday-1;
}

//+ (NSDate *)firstDayDateFromDate:(NSDate *)date
//{
//    NSInteger year = [self yearFromDate:date];
//    NSInteger month = [self monthFromDate:date];
//    //设置第一天
//    NSInteger day = 1;
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setYear:year];
//    [components setMonth:month];
//    [components setDay:day];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    return [calendar dateFromComponents:components];
//}
//
//+ (NSDate *)lastMonthDateFromDate:(NSDate *)date
//{
//    NSInteger year = [self yearFromDate:date];
//    NSInteger month = [self monthFromDate:date]-1;
//    NSInteger day = 1;
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setYear:year];
//    [components setMonth:month];
//    [components setDay:day];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    return [calendar dateFromComponents:components];
//}
//
//+ (NSDate *)nextMonthDateFromDate:(NSDate *)date
//{
//    NSInteger year = [self yearFromDate:date];
//    NSInteger month = [self monthFromDate:date]+1;
//    NSInteger day = 1;
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setYear:year];
//    [components setMonth:month];
//    [components setDay:day];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    return [calendar dateFromComponents:components];
//}

+ (BOOL)isTodayFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *nowDateString = [dateFormatter stringFromDate:[NSDate date]];
    return [dateString isEqualToString:nowDateString];
}

+ (NSString *)getHolidayFromDate:(NSDate *)date
{
    NSString *todayHoliday;
    //今日阳历
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString *nowdate = [dateFormatter1 stringFromDate:date];
    NSString *monthAndDay = [nowdate substringWithRange:NSMakeRange(5, 5)];
    
    //农历节日
    NSTimeInterval timeInterval_day = 60*60*24;
    NSDate *nextDay_date = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:date];
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nextDay_date];
    if ( 1 == localeComp.month && 1 == localeComp.day ) {
        return @"除夕";
    }
    NSDictionary *chineseHoliDay = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"春节", @"1-1",
                                    @"元宵", @"1-15",
                                    @"端午", @"5-5",
                                    @"七夕", @"7-7",
                                    @"中元", @"7-15",
                                    @"中秋", @"8-15",
                                    @"重阳", @"9-9",
                                    @"腊八", @"12-8",
                                    @"小年", @"12-24",
                                    nil];
    localeComp = [localeCalendar components:unitFlags fromDate:date];
    NSString *key_str = [NSString stringWithFormat:@"%ld-%ld",localeComp.month,localeComp.day];
    todayHoliday = [chineseHoliDay objectForKey:key_str];
    
    //节气节日
//    NSArray *dateArr = [nowdate componentsSeparatedByString:@"-"];
//    todayHoliday = [self getLunarSpecialDate:[dateArr[0] integerValue] Month:[dateArr[1] integerValue] Day:[dateArr[2] integerValue]];
    
    //阳历节日
    NSDictionary *lunDic = @{
                             @"01-01":@"元旦节",
                             @"02-14":@"情人节",
                             @"03-08":@"妇女节",
                             @"05-01":@"劳动节",
                             @"06-01":@"儿童节",
                             @"08-01":@"建军节",
                             @"09-10":@"教师节",
                             @"10-01":@"国庆节",
                             @"10-24":@"程序员日",
                             @"11-01":@"植树节",
                             @"11-11":@"光棍节",
                             @"12-25":@"圣诞节"
                             };
    if ([lunDic objectForKey:monthAndDay] != nil) {
        todayHoliday = [lunDic objectForKey:monthAndDay];
    }
    
    if (todayHoliday.length > 0) {
        return todayHoliday;
    }
    return nil;
}
@end
