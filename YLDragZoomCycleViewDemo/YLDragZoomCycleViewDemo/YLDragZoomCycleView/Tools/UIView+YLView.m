//
//  UIView+YLView.m
// /\   /\        | |
// \ \_/ / _   _  | |     _   _
//  \_ _/ | | | | | |    | | | |
//   / \  | |_| | | |__/\| |_| |
//   \_/   \__,_| |_|__,/ \__,_|
//
//  Created by 张雨露 on 2017/5/26.
//  Copyright © 2017年 Raindew. All rights reserved.
//

#import "UIView+YLView.h"

@implementation UIView (YLView)
#pragma mark - Frame
- (CGPoint)yl_origin {
    return self.frame.origin;
}

- (void)setYl_origin:(CGPoint)yl_origin {
    CGRect newFrame = self.frame;
    newFrame.origin = yl_origin;
    self.frame = newFrame;
}
- (CGSize)yl_size {
    return self.frame.size;
}

- (void)setYl_size:(CGSize)yl_size {
    CGRect newFrame = self.frame;
    newFrame.size = yl_size;
    self.frame = newFrame;
    
}

#pragma mark - Frame Origin
- (CGFloat)yl_x {
    return self.frame.origin.x;
}
- (void)setYl_x:(CGFloat)yl_x {
    CGRect newFrame = self.frame;
    newFrame.origin.x = yl_x;
    self.frame = newFrame;
}

- (CGFloat)yl_y {
    return self.frame.origin.y;
}
- (void)setYl_y:(CGFloat)yl_y {
    CGRect newFrame = self.frame;
    newFrame.origin.y = yl_y;
    self.frame = newFrame;
}

#pragma mark - Frame Size
- (CGFloat)yl_width {
    return self.frame.size.width;
}
- (void)setYl_width:(CGFloat)yl_width {
    CGRect newFrame = self.frame;
    newFrame.size.width = yl_width;
    self.frame = newFrame;
}

- (CGFloat)yl_height {
    return self.frame.size.height;
}
- (void)setYl_height:(CGFloat)yl_height {
    CGRect newFrame = self.frame;
    newFrame.size.height = yl_height;
    self.frame = newFrame;
}

#pragma mark - other frame

- (CGFloat)yl_minX {
    return CGRectGetMinX(self.frame);
}
- (void)setYl_minX:(CGFloat)yl_minX {
    CGRect newFrame = self.frame;
    newFrame.origin.x = yl_minX;
    self.frame = newFrame;
}

- (CGFloat)yl_maxX {
    return CGRectGetMaxX(self.frame);
}
- (void)setYl_maxX:(CGFloat)yl_maxX {
    CGRect newFrame = self.frame;
    newFrame.origin.x += (yl_maxX - self.frame.size.width);
    self.frame = newFrame;
}

- (CGFloat)yl_midX {
    return CGRectGetMidX(self.frame);
}

- (void)setYl_midX:(CGFloat)yl_midX {
    CGRect newFrame = self.frame;
    newFrame.origin.x += (yl_midX - self.frame.size.width/2.);
    self.frame = newFrame;

}

- (CGFloat)yl_minY {
    return CGRectGetMinY(self.frame);
}
- (void)setYl_minY:(CGFloat)yl_minY {
    CGRect newFrame = self.frame;
    newFrame.origin.y = yl_minY;
    self.frame = newFrame;
}
- (CGFloat)yl_maxY {
    return CGRectGetMaxY(self.frame);
}
- (void)setYl_maxY:(CGFloat)yl_maxY {
    CGRect newFrame = self.frame;
    newFrame.origin.y += (yl_maxY - self.frame.size.height);
    self.frame = newFrame;
}

- (CGFloat)yl_midY {
    return CGRectGetMidY(self.frame);
}
- (void)setYl_midY:(CGFloat)yl_midY {
    CGRect newFrame = self.frame;
    newFrame.origin.y += (yl_midY - self.frame.size.height/2.);
    self.frame = newFrame;
}

- (CGFloat)yl_centerX {
    return self.center.x;
}
- (void)setYl_centerX:(CGFloat)yl_centerX {
    CGPoint center = self.center;
    center.x = yl_centerX;
    self.center = center;
}


- (CGFloat)yl_centerY {
    return self.center.y;
}

- (void)setYl_centerY:(CGFloat)yl_centerY {
    CGPoint center = self.center;
    center.y = yl_centerY;
    self.center = center;
}


#pragma mark - 截屏
- (UIImage *)capturedImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    UIImage *result = nil;
    if ([self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES]) {
        result = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return result;
}
#pragma mark - 划线

- (void)addLineWithStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andLineWidth:(CGFloat)lineWidth andLineColor:(UIColor *)lineColor {

    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.frame];
    [self addSubview:imageView];
    
    NSMutableArray *colors = [self changeUIColorToRGB:lineColor];
    CGFloat r = [colors.firstObject floatValue];
    CGFloat g = [colors[1] floatValue];
    CGFloat b = [colors.lastObject floatValue];

    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapButt);  //边缘样式
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), r, g, b, 1.0);  //颜色
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 100, 100);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 200, 100);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
- (NSMutableArray *)changeUIColorToRGB:(UIColor *)color {
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    //获取红色值
    float r = [[RGBArr objectAtIndex:1] floatValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%f",r];
    [RGBStrValueArr addObject:RGBStr];
    //获取绿色值
    float g = [[RGBArr objectAtIndex:2] floatValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%f",g];
    [RGBStrValueArr addObject:RGBStr];
    //获取蓝色值
    if (RGBArr.count >= 4) {
        float b = [[RGBArr objectAtIndex:3] floatValue] * 255;
        RGBStr = [NSString stringWithFormat:@"%f",b];
        [RGBStrValueArr addObject:RGBStr];
    }else {
        if (r == 255 && g == 255) {
            return [@[@"1.0",@"1.0",@"1.0"] mutableCopy];
        }else {
            return [@[@"0.0",@"0.0",@"0.0"] mutableCopy];
        }
    }
    //返回保存RGB值的数组
    
    return RGBStrValueArr;
}
@end
