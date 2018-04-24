//
//  DayModel.h
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/24.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CellType) {
    CellTypeNormal,
    CellTypeHighlight,
    CellTypeDrak,
    CellTypeEmpty,
};

@interface DayModel : NSObject

@property (assign,nonatomic) CellType type;
@property (assign,nonatomic) NSInteger value;
@property (copy,nonatomic) NSString *detail;

@end
