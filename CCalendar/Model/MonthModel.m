//
//  MonthModel.m
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/24.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "MonthModel.h"
#import "NSDate+Calendar.h"

@implementation MonthModel

- (void)setYear:(NSInteger)year
{
    _year = year;
    self.yearString = [NSString stringWithFormat:@"%ld年",year];
}
- (void)setMonth:(NSInteger)month
{
    _month = month;
    self.monthString = [NSString stringWithFormat:@"%ld月",month];
}
- (void)setDay:(NSInteger)day
{
    self.dayString = [NSString stringWithFormat:@"%ld日",day];
}
- (void)createDays
{
    NSMutableArray *days = [[NSMutableArray alloc] init];
    for(int i=0; i<self.firstDayIndex; i++) {
        DayModel *dayMdl = [[DayModel alloc] init];
        [dayMdl setType:CellTypeEmpty];
        [dayMdl setValue:0];
        [days addObject:dayMdl];
    }
    for(int i=0; i<self.daysAtMonth; i++) {
        DayModel *dayMdl = [[DayModel alloc] init];
        [dayMdl setType:CellTypeNormal];
        [dayMdl setValue:i+1];
        [days addObject:dayMdl];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setYear:self.year];
        [components setMonth:self.month];
        [components setDay:i+1];
        NSDate *curDate = [[NSCalendar currentCalendar] dateFromComponents:components];
        NSString *holiday = [NSDate getHolidayFromDate:curDate];
        if(holiday) {
            [dayMdl setType:CellTypeDrak];
            [dayMdl setDetail:holiday];
        }
        BOOL isToday = [NSDate isTodayFromDate:curDate];
        if(isToday) {
            [dayMdl setType:CellTypeHighlight];
        }
    }
    self.days = days;
}
@end
