//
//  secondViewController.m
//  YLDragZoomCycleViewDemo
//
//  Created by 张雨露 on 2017/5/27.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import "YLSecondViewController.h"
#import "UIView+YLView.h"
#import "YLDragZoomCycleView.h"
#import "GKFadeNavigationController.h"
@interface YLSecondViewController ()<UITableViewDelegate, UITableViewDataSource,GKFadeNavigationControllerDelegate,YLDroagViewDelegate>
@property(nonatomic, strong) YLDragZoomCycleView *dragView;
@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic) GKFadeNavigationControllerNavigationBarVisibility navigationBarVisibility;
@end

@implementation YLSecondViewController

#pragma mark -- macro

#define kHeaderHeight 200
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f

#pragma mark -- lazy init
- (UITableView *)tableView {
    if (!_tableView) {
        
        //判断数据个数，来确定tableView的高度
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark -- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Raindew";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];

}

#pragma mark -- set UI
- (void)setupUI {
    
    //添加表格
    [self.view addSubview:self.tableView];
    //下面这行代码必须在这里设置。否则会影响导航栏颜色的更换。不能放在懒加载
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);

    //创建轮播图
    self.dragView = [[YLDragZoomCycleView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderHeight) andDataSource:[self getimageSource] autoScroll:YES scrollInterval:2];
    self.dragView.delegate = self;
    [self.view addSubview:self.dragView];
    
    //设置导航栏自动隐藏  下面的代码请放在方法的最后  否则影响导航栏判断
    GKFadeNavigationController *navigationController = (GKFadeNavigationController *)self.navigationController;
    [navigationController setNeedsNavigationBarVisibilityUpdateAnimated:NO];
    self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityHidden;

}

- (void)didSelectedItem:(NSInteger)item {
    
    NSLog(@"选择了第%ld张图片",item+1);
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行\t上下滑动试试~",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scrollOffsetY = kHeaderHeight-scrollView.contentOffset.y;
    // Show or hide the navigaiton bar
    if (scrollOffsetY-kHeaderHeight < kGKHeaderVisibleThreshold) {//或者<64
        self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityVisible;
    } else {
        self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityHidden;
    }
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


#pragma mark - Accessors

- (void)setNavigationBarVisibility:(GKFadeNavigationControllerNavigationBarVisibility)navigationBarVisibility {
    
    if (_navigationBarVisibility != navigationBarVisibility) {
        // Set the value
        _navigationBarVisibility = navigationBarVisibility;
        
        // Play the change
        GKFadeNavigationController *navigationController = (GKFadeNavigationController *)self.navigationController;
        if (navigationController.topViewController) {
            [navigationController setNeedsNavigationBarVisibilityUpdateAnimated:YES];
        }
    }
}

#pragma mark <GKFadeNavigationControllerDelegate>

- (GKFadeNavigationControllerNavigationBarVisibility)preferredNavigationBarVisibility {
    return self.navigationBarVisibility;
}

- (void)dealloc {
    NSLog(@"Raindew控制器销毁了");
}

- (NSArray *)getimageSource {

    return @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880401999&di=ba4990f6e6d89d66dcea9832ea01c217&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F78%2Fd%2F250.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880450952&di=e0386e70958b230adec0a063a871bb0d&imgtype=0&src=http%3A%2F%2Fwww.qihualu.net.cn%2FVimages%2Fbd1938384.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880489400&di=1805f04fa8b90a7145bee610af129fa1&imgtype=0&src=http%3A%2F%2Fwww.bz55.com%2Fuploads%2Fallimg%2F100722%2F0933553a9-2.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880548256&di=66722048d74180758bff742f9855caf4&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F162%2F48%2F9TZ0JJK73519.jpg"];

}

@end
