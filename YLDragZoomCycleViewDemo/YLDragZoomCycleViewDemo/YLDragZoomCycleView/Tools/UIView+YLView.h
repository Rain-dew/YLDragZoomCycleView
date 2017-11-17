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
@property (nonatomic, assign) CGPoint yl_origin;
// 视图尺寸
@property (nonatomic, assign) CGSize yl_size;

#pragma mark - Frame Origin
// frame 原点 x 值
@property(nonatomic, assign) CGFloat yl_x;

// frame 原点 y 值
@property (nonatomic, assign) CGFloat yl_y;

#pragma mark - Frame Size
// frame 尺寸 width
@property (nonatomic, assign) CGFloat yl_width;
// frame 尺寸 height
@property (nonatomic, assign) CGFloat yl_height;

#pragma mark - other frame

//x
@property (nonatomic, assign) CGFloat yl_minX;
@property (nonatomic, assign) CGFloat yl_maxX;
@property (nonatomic, assign) CGFloat yl_midX;
@property (nonatomic, assign) CGFloat yl_centerX;
//y
@property (nonatomic, assign) CGFloat yl_minY;
@property (nonatomic, assign) CGFloat yl_maxY;
@property (nonatomic, assign) CGFloat yl_midY;
@property (nonatomic, assign) CGFloat yl_centerY;



#pragma mark - 截屏
// 当前视图内容生成的图像
@property (nonatomic, readonly, nullable)UIImage *capturedImage;

#pragma mark - 划线

- (void)addLineWithStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andLineWidth:(CGFloat)lineWidth andLineColor:(UIColor *_Nullable)lineColor;




@end
