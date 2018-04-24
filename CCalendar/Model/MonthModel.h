//
//  MonthModel.h
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/24.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayModel.h"

@interface MonthModel : NSObject

@property (copy,nonatomic) NSString *yearString;
@property (copy,nonatomic) NSString *monthString;
@property (copy,nonatomic) NSString *dayString;
@property (assign,nonatomic) NSInteger daysAtMonth;
@property (assign,nonatomic) NSInteger firstDayIndex;
@property (strong,nonatomic) NSArray<DayModel *> *days;
@property (assign,nonatomic) NSInteger year;
@property (assign,nonatomic) NSInteger month;

//- (void)setYear:(NSInteger)year;
//- (void)setMonth:(NSInteger)month;
//- (void)setDay:(NSInteger)day;
//必须先设置daysAtMonth，firstDayIndex后再调用该方法
- (void)createDays;

@end
