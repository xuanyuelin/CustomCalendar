//
//  MonthlyCellHeadView.m
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/23.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "MonthlyCellHeadView.h"

@implementation MonthlyCellHeadView
{
    UILabel *monthYearLbl;
    UIView *sepline;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        CGFloat wid = frame.size.width;
        CGFloat hei = frame.size.height;
        monthYearLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, wid-10, hei-1)];
        monthYearLbl.textColor = [UIColor lightGrayColor];
        monthYearLbl.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:monthYearLbl];
        sepline = [[UIView alloc] initWithFrame:CGRectMake(0, hei-1, wid, 1)];
        sepline.backgroundColor = [UIColor grayColor];
        [self addSubview:sepline];
    }
    return self;
}

- (void)setMonthYearString:(NSString *)monthYearString
{
    monthYearLbl.text = monthYearString;
}

@end
