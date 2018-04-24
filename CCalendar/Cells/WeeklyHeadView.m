//
//  WeeklyHeadView.m
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/23.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "WeeklyHeadView.h"

@implementation WeeklyHeadView

- (void)setData:(NSArray *)data
{
    CGFloat wid = CGRectGetWidth(self.frame);
    CGFloat hei = CGRectGetHeight(self.frame);
    NSInteger cout = data.count;
    CGFloat itemWid = floor(wid/cout);
    for(int i=0; i<cout; i++) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(itemWid*i, 0, itemWid, hei)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor redColor];
        lbl.text = data[i];
        lbl.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:lbl];
    }
}

@end
