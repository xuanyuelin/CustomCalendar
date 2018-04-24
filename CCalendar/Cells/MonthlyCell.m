//
//  MonthlyCell.m
//  CCalendar
//
//  Created by 小二黑挖土 on 2018/4/23.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "MonthlyCell.h"
#import "Masonry.h"
#import "MonthlyCellHeadView.h"
#import "MonthlyCellItemCell.h"

@interface MonthlyCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *collectView;

@end

@implementation MonthlyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat length = floor(frame.size.width/7);
        layout.itemSize = CGSizeMake(length, length);
        layout.headerReferenceSize = CGSizeMake(frame.size.width, 40);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [_collectView registerClass:[MonthlyCellItemCell class] forCellWithReuseIdentifier:@"MonthlyCellItemCell"];
        [_collectView registerClass:[MonthlyCellHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonthlyCellHeadView"];
        _collectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectView];
        //添加自适应约束
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)setMonthMdl:(MonthModel *)monthMdl
{
    //cell复用时刷新数据源
    _monthMdl = monthMdl;
    [self.collectView reloadData];
    CGFloat collectViewHeight = _collectView.collectionViewLayout.collectionViewContentSize.height;
    [_collectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(collectViewHeight);
    }];
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat collectViewHeight = _collectView.collectionViewLayout.collectionViewContentSize.height;
//    [_collectView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(collectViewHeight);
//    }];
//}
//
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    CGSize size = [self systemLayoutSizeFittingSize:layoutAttributes.size];
//    CGRect frame = layoutAttributes.frame;
//    frame.size.height = size.height;
//    layoutAttributes.frame = frame;
//    return layoutAttributes;
//}

#pragma mark -
#pragma mark - UICollectionView delegate && dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.monthMdl.days.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthlyCellItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonthlyCellItemCell" forIndexPath:indexPath];
    [cell setDayMdl:self.monthMdl.days[indexPath.item]];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MonthlyCellHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonthlyCellHeadView" forIndexPath:indexPath];
        [headView setMonthYearString:[NSString stringWithFormat:@"%@%@",self.monthMdl.yearString,self.monthMdl.monthString]];
        return headView;
    }
    return nil;
}

@end
