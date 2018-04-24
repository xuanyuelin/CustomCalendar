//
//  MonthlyCellItemCell.m
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/23.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "MonthlyCellItemCell.h"

@implementation MonthlyCellItemCell
{
    UILabel *lbl;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        lbl = [[UILabel alloc] initWithFrame:self.bounds];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:15.f];
        lbl.layer.cornerRadius = CGRectGetWidth(frame)/2;
        lbl.layer.masksToBounds = YES;
        lbl.numberOfLines = 0;
        [self addSubview:lbl];
    }
    return self;
}

- (void)setDayMdl:(DayModel *)dayMdl
{
    switch (dayMdl.type) {
        case CellTypeNormal:{
            lbl.textColor = [UIColor blackColor];
            lbl.backgroundColor = [UIColor whiteColor];
        }break;
        case CellTypeEmpty:{
            lbl.textColor = [UIColor whiteColor];
            lbl.backgroundColor = [UIColor whiteColor];
        }break;
        case CellTypeHighlight:{
            lbl.textColor = [UIColor whiteColor];
            lbl.backgroundColor = [UIColor redColor];
        }break;
        case CellTypeDrak:{
            lbl.textColor = [UIColor whiteColor];
            lbl.backgroundColor = [UIColor grayColor];
        }break;
        default:
            break;
    }
    if(dayMdl.detail.length > 0) {
        lbl.text = [NSString stringWithFormat:@"%ld\n%@",dayMdl.value,dayMdl.detail];
    }else {
        lbl.text = [NSString stringWithFormat:@"%ld",dayMdl.value];
    }
}
@end
