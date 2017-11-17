//
//  YLZoomCycleViewCell.m
//  YLDragZoomCycleViewDemo
//
//  Created by 张雨露 on 2017/5/26.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import "YLZoomCycleViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+YLView.h"

@interface YLZoomCycleViewCell ()
@end

@implementation YLZoomCycleViewCell
#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
#pragma mark -- set methed

- (void)setImageURL:(NSString *)imageURL {

    NSURL *dataUrl = [NSURL URLWithString:imageURL];
    [self.imageView sd_setImageWithURL:dataUrl placeholderImage:[UIImage imageNamed:@"pageOther.png"]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
