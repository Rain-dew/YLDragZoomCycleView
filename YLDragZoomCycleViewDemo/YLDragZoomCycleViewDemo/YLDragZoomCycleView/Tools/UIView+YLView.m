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
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = newFrame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
    
}

#pragma mark - Frame Origin
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = newFrame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect newFrame = self.frame;
    newFrame.origin.y = y;
    self.frame = newFrame;
}

#pragma mark - Frame Size
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}
#pragma mark - other frame

- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}
- (void)setMinX:(CGFloat)minX {
    CGRect newFrame = self.frame;
    newFrame.origin.x = minX;
    self.frame = newFrame;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX {
    CGRect newFrame = self.frame;
    newFrame.origin.x += (maxX - self.frame.size.width);
    self.frame = newFrame;

}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}


- (void)setMidX:(CGFloat)midX {
    CGRect newFrame = self.frame;
    newFrame.origin.x += (midX - self.frame.size.width/2.);
    self.frame = newFrame;

}

- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}
- (void)setMinY:(CGFloat)minY {
    CGRect newFrame = self.frame;
    newFrame.origin.y = minY;
    self.frame = newFrame;
}
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
- (void)setMaxY:(CGFloat)maxY {
    CGRect newFrame = self.frame;
    newFrame.origin.y += (maxY - self.frame.size.height);
    self.frame = newFrame;
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}
- (void)setMidY:(CGFloat)midY {
    CGRect newFrame = self.frame;
    newFrame.origin.y += (midY - self.frame.size.height/2.);
    self.frame = newFrame;
}

- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
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
