//
//  UIView+YLView.h
// /\   /\        | |
// \ \_/ / _   _  | |     _   _
//  \_ _/ | | | | | |    | | | |
//   / \  | |_| | | |__/\| |_| |
//   \_/   \__,_| |_|__,/ \__,_|
//
//  Created by 张雨露 on 2017/5/26.
//  Copyright © 2017年 Raindew. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (YLView)

#pragma mark - Frame
// 视图原点
@property (nonatomic, assign) CGPoint origin;
// 视图尺寸
@property (nonatomic, assign) CGSize size;

#pragma mark - Frame Origin
// frame 原点 x 值
@property(nonatomic, assign) CGFloat x;

// frame 原点 y 值
@property (nonatomic, assign) CGFloat y;

#pragma mark - Frame Size
// frame 尺寸 width
@property (nonatomic, assign) CGFloat width;
// frame 尺寸 height
@property (nonatomic, assign) CGFloat height;

#pragma mark - other frame

//x
@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat midX;
@property (nonatomic, assign) CGFloat centerX;
//y
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat midY;
@property (nonatomic, assign) CGFloat centerY;



#pragma mark - 截屏
// 当前视图内容生成的图像
@property (nonatomic, readonly, nullable)UIImage *capturedImage;

#pragma mark - 划线

- (void)addLineWithStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andLineWidth:(CGFloat)lineWidth andLineColor:(UIColor *_Nullable)lineColor;




@end
