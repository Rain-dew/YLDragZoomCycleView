///Users/raindew/Desktop/yscroll.gif
//  YLDragView.h
//  YLDragZoomCycleViewDemo
//
//  Created by 张雨露 on 2017/5/26.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLDroagViewDelegate <NSObject>
@optional
/*
 *  点击了第几个item?
 */
- (void)didSelectedItem:(NSInteger)item;

@end

@interface YLDragZoomCycleView : UIView

/*   页面控制器  可在外部以此控件。直接修改其外观设置
 */
@property(nonatomic, strong) UIPageControl *pageControl;
/*
 * 图片数据源
 */
@property(nonatomic, strong) NSArray <NSString *>*dataSource;

@property(nonatomic, assign) id<YLDroagViewDelegate> delegate;

/*  初始化方法
 *  isAuto : 是否自动滚动
 *  interval ： 滚动间隔时间  不自动 填0即可
 */
- (instancetype)initWithFrame:(CGRect)frame andAutoScroll:(BOOL)isAuto scrollInterval:(CGFloat)interval;

/*  停止滚动
 *  建议在外部代理方法 scrollViewWillBeginDragging 中调用一次
 */
- (void)stopScroll;
/*  开启滚动
 *  建议在外部代理方法 scrollViewDidEndDragging: willDecelerate: 中调用一次(如果上面个方法在外部调用了，这里必须调用)
 */
- (void)startScroll;

@end
