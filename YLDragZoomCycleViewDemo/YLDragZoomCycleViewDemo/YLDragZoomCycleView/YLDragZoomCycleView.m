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
@property(nonatomic, strong) NSArray *dataSource;//数据源
@property(nonatomic, strong) UICollectionViewFlowLayout *layout;//布局
@property(nonatomic,   weak) NSTimer *timer;//定时器
@property(nonatomic, assign) CGFloat initHeight;//初始高度
@property(nonatomic, assign) CGFloat interval;
@property(nonatomic, assign) BOOL autoScroll;

@end

@implementation YLDragZoomCycleView
#define kCellID @"kCycleCell"
#define kPageControH 30

#pragma mark -- lazy init

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)dataSource autoScroll:(BOOL)isAuto scrollInterval:(CGFloat)interval {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = dataSource;
        self.initHeight = self.height;
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
        self.layout.itemSize = _collectionView.bounds.size;
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView.showsVerticalScrollIndicator = 0;
        _collectionView.showsHorizontalScrollIndicator = 0;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[YLZoomCycleViewCell class] forCellWithReuseIdentifier:kCellID];
        NSIndexPath *path = [NSIndexPath indexPathForItem:self.dataSource.count * 500 inSection:0];
        [_collectionView scrollToItemAtIndexPath:path atScrollPosition:0 animated:NO];
        [self startScroll];

    }
    return _collectionView;

}

- (UIPageControl *)pageControl {

    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 80, kPageControH)];
        _pageControl.centerX = self.centerX;
        _pageControl.y = self.maxY - kPageControH;
        _pageControl.numberOfPages = self.dataSource.count;
        [_pageControl setValue:[UIImage imageNamed:@"pageCurrent"] forKey:@"_currentPageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"pageOther"] forKey:@"_pageImage"];
    }
    return _pageControl;
}


#pragma mark -- 滚动偏移量

- (void)dragViewWithOffset:(CGFloat)offset {
  
    
    if (offset < 0) {
        
        NSDictionary *dic = @{@"offset" : [NSString stringWithFormat:@"%f",offset]};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSize" object:nil userInfo:dic];
        //更新layout
        CGSize size = self.layout.itemSize;
        size.height = self.initHeight - offset ;
        self.layout.itemSize = size;
        //更新self
        self.height = self.initHeight;
        self.y = 0;
        self.height = self.initHeight - offset;

    }else {
        self.y = 0;
        CGFloat minOffset = self.height;
        self.y = minOffset > offset ? - offset : - minOffset;

    }
    
    self.collectionView.height = self.height;
    self.pageControl.y = self.height - kPageControH;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count * 10000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLZoomCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.imageURL = self.dataSource[indexPath.item % self.dataSource.count];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    int current = (offset.x / (bounds.size.width));
    [self.pageControl setCurrentPage:current % self.dataSource.count];
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
    NSUInteger page = self.collectionView.contentOffset.x / self.width + 1;
    NSIndexPath *path = [NSIndexPath indexPathForItem:page inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:0 animated:YES];
}

- (void)dealloc {
    [self stopScroll];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeSize" object:nil];
    NSLog(@"YLDragZoomCyleView销毁了");
}



@end
