# YLDragZoomCycleViewDemo
一个可以下拉放大的轮播图
### 如何使用？
```Objective-C
   //创建轮播图
   self.dragView = [[YLDragZoomCycleView alloc] initWithFrame:CGRectMake(0, 0, self.view.yl_width, kHeaderHeight) andAutoScroll:YES scrollInterval:2];
    self.dragView.delegate = self;
    self.dragView.dataSource = [self getimageSource];
    [self.tableView addSubview:self.dragView];
    
```
同时你必须实现滚动试图的代理方法，并且调用几个函数。格式如下
```Objective-C
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //告诉dragView表格滑动了
    CGFloat offset = scrollView.contentOffset.y + kHeaderHeight;
    [self.dragView dragViewWithOffset:offset];
    
}
//正在拖拽的时候停止自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.dragView stopScroll];
}
//停止滑动开启自动滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.dragView startScroll];
}
```
### 效果图
![image](https://github.com/Rain-dew/YLDragZoomCycleView/blob/master/YLDragZoomCycleViewDemo/YLDragZoomCycleViewDemo/yscroll.gif)
