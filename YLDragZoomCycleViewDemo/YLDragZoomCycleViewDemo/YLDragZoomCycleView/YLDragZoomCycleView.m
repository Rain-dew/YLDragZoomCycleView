//
//  YLDragView.m
//  YLDragZoomCycleViewDemo
//
//  Created by 张雨露 on 2017/5/26.
//  Copyright © 2017年 Raindew. All rights reserved.
//

#import "YLDragZoomCycleView.h"
#import "YLZoomCycleViewCell.h"
#import "UIView+YLView.h"
#import "HWWeakTimer.h"
@interface YLDragZoomCycleView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *layout;//布局
@property(nonatomic,   weak) NSTimer *timer;//定时器
@property(nonatomic, assign) CGFloat interval;
@property(nonatomic, assign) BOOL autoScroll;
@property(nonatomic,  weak) NSArray *images;

@end

@implementation YLDragZoomCycleView
#define kCellID @"kCycleCell"
#define kPageControH 30

#pragma mark -- lazy init

- (instancetype)initWithFrame:(CGRect)frame andAutoScroll:(BOOL)isAuto scrollInterval:(CGFloat)interval {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.autoScroll = isAuto;
        self.interval = interval;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        self.layout.minimumLineSpacing = 0;
        self.layout.minimumInteritemSpacing = 0;
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView.showsVerticalScrollIndicator = 0;
        _collectionView.showsHorizontalScrollIndicator = 0;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[YLZoomCycleViewCell class] forCellWithReuseIdentifier:kCellID];
        [self startScroll];

    }
    return _collectionView;

}

- (UIPageControl *)pageControl {

    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl setValue:[UIImage imageNamed:@"pageCurrent"] forKey:@"_currentPageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"pageOther"] forKey:@"_pageImage"];
    }
    return _pageControl;
}
- (void)setDataSource:(NSArray<NSString *> *)dataSource {
    _dataSource = dataSource;
    self.images = dataSource;
    self.pageControl.numberOfPages = self.images.count;
    if (dataSource.count > 0) {
        [self.collectionView reloadData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layout.itemSize = self.yl_size;
    self.collectionView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.yl_height - kPageControH, self.yl_width, kPageControH);
    self.pageControl.yl_centerX = self.yl_centerX;
    //自动滚动到中间位置-->伪无限
    NSIndexPath *path = [NSIndexPath indexPathForItem:self.images.count * 500 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count * 10000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLZoomCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.imageURL = self.images[indexPath.item % self.images.count];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedItem:)]) {
        [self.delegate didSelectedItem:indexPath.item % self.images.count];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    int current = (offset.x / (scrollView.yl_width));
    int pageIndex = current % self.images.count;
    [self.pageControl setCurrentPage:pageIndex];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startScroll];
}

#pragma mark -- 停止/继续 滚动
//停止定时器
- (void)stopScroll {
    [self.timer invalidate];
    self.timer = nil;
}
//开启定时器
- (void)startScroll {
    if (self.autoScroll) {
        if (!self.timer) {
            [self addTimer];
        }
    }
}

//添加定时器
- (void)addTimer {
    self.timer = [HWWeakTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//下一页
- (void)nextPage {
    NSUInteger page = self.collectionView.contentOffset.x / self.yl_width + 1;
    NSIndexPath *path = [NSIndexPath indexPathForItem:page inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:0 animated:YES];
}

- (void)dealloc {
    [self stopScroll];
    NSLog(@"YLDragZoomCyleView销毁了");
}



@end
