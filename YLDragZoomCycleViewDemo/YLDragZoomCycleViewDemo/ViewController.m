//
//  ViewController.m
//  YLDragZoomCycleViewDemo
//
//  Created by 张雨露 on 2017/5/26.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import "ViewController.h"
#import "YLSecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点击空白";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    YLSecondViewController *vc = [[YLSecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
