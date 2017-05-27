///Users/raindew/Desktop/yscroll.gif
//  YLDragView.h
//  YLDragZoomCycleViewDemo
//
//  Created by 张雨露 on 2017/5/26.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLDragZoomCycleView : UIView

/*   页面控制器  可在外部以此控件。直接修改其外观设置
 */
@property(nonatomic, strong) UIPageControl *pageControl;

/*  初始化方法
 *  dataSource:储存图片链接数组
 *  isAuto : 是否自动滚动
 *  interval ： 滚动间隔时间
 */
- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)dataSource autoScroll:(BOOL)isAuto scrollInterval:(CGFloat)interval;
/*  外部scrollViewDidScroll 中调用
 *  offset:滑动偏移数据
 */
- (void)dragViewWithOffset:(CGFloat)offset;

/*  停止滚动
 *  建议在外部代理方法 scrollViewWillBeginDragging 中调用一次
 */
- (void)stopScroll;
/*  开启滚动
 *  建议在外部代理方法 scrollViewDidEndDragging: willDecelerate: 中调用一次(如果上面个方法在外部调用了，这里必须调用)
 */
- (void)startScroll;



@end
