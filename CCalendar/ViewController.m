//
//  ViewController.m
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/23.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "ViewController.h"
#import "WeeklyHeadView.h"
#import "NSDate+Calendar.h"
#import "MonthlyCell.h"
#import "MonthModel.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *collectView;
@property (strong,nonatomic) UICollectionViewFlowLayout *layout;
@property (strong,nonatomic) UIView *headView;

@end

@implementation ViewController
{
    NSArray *weeklyDays;
    NSMutableArray<MonthModel *> *calendarData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"自定义日历";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    [self initVariable];
    [self.view addSubview:self.collectView];
    [self.view addSubview:self.headView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initVariable
{
    weeklyDays = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
    calendarData = [NSMutableArray array];
    NSInteger year = [NSDate yearFromDate:[NSDate date]];
//    NSInteger month = [NSDate monthFromDate:[NSDate date]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setDay:1];
    for(int i=0; i<12; i++) {
//        NSInteger curMonth = (month+i)%12;
        [components setMonth:i+1];
        NSDate *curDate = [calendar dateFromComponents:components];
        NSInteger daysAtMonth = [NSDate daysAtMonthFromDate:curDate];
        NSInteger firstDayInd = [NSDate firstDayWeeklyAtDate:curDate];
        MonthModel *monthMdl =  [[MonthModel alloc] init];
        [monthMdl setYear:year];
        [monthMdl setMonth:i+1];
        [monthMdl setDaysAtMonth:daysAtMonth];
        [monthMdl setFirstDayIndex:firstDayInd];
        [monthMdl createDays];
        [calendarData addObject:monthMdl];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSInteger month = [NSDate monthFromDate:[NSDate date]];
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:month-1 inSection:0];
    [self.collectView layoutIfNeeded];
    [self.collectView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

- (UIView *)headView
{
    if(_headView == nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
        CGFloat wid = CGRectGetWidth(self.headView.frame);
        CGFloat hei = CGRectGetHeight(self.headView.frame);
        NSInteger cout = weeklyDays.count;
        CGFloat itemWid = floor(wid/cout);
        for(int i=0; i<cout; i++) {
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(itemWid*i, 0, itemWid, hei)];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = [UIColor redColor];
            lbl.text = weeklyDays[i];
            lbl.font = [UIFont systemFontOfSize:15.f];
            [_headView addSubview:lbl];
        }
    }
    return _headView;
}

- (UICollectionViewFlowLayout *)layout
{
    if(_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH, 500);
//        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
        _layout.minimumLineSpacing = 0.f;
        _layout.minimumInteritemSpacing = 0.f;
//        _layout.sectionHeadersPinToVisibleBounds = YES;
    }
    return _layout;
}

- (UICollectionView *)collectView
{
    if(_collectView  == nil) {
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40) collectionViewLayout:self.layout];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.backgroundColor = [UIColor whiteColor];
        [_collectView registerClass:[WeeklyHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WeeklyHeadView"];
        [_collectView registerClass:[MonthlyCell class] forCellWithReuseIdentifier:@"MonthlyCell"];
    }
    return _collectView;
}

#pragma mark -
#pragma mark - UICollectionView delegate && dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return calendarData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthlyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonthlyCell" forIndexPath:indexPath];
    [cell setMonthMdl:calendarData[indexPath.item]];
    return cell;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        WeeklyHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WeeklyHeadView" forIndexPath:indexPath];
//        [headView setData:weeklyDays];
//        return headView;
//    }
//    return nil;
//}


@end
