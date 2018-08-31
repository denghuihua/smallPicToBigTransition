//
//  SNSImagePreviewCell.m
//  Img
//
//  Created by huihuadeng on 2018/8/31.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "SNSImagePreviewCell.h"
#import "GlobalDefine.h"

@interface SNSImagePreviewCell()<UIScrollViewDelegate>

@end

@implementation SNSImagePreviewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self baseConfig];    
    }
    return self;
}

- (void)baseConfig{
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.imgView addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    if (self.imgView.image) {
        CGFloat height = self.imgView.image.size.height/self.imgView.image.size.width*kScreenWidth;
        CGFloat y = (kScreenHeight-BOTTOM_SAFE_AREA - height - (kAPP_STATUSBAR_HEIGHT-20)) * 0.5;
        y = y > 0 ? y : 0;
        self.imgView.frame = CGRectMake(0, y, kScreenWidth, height);
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, height);
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGes{
    if (self.tapHander) {
        self.tapHander(tapGes);
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 3.;
        _scrollView.minimumZoomScale = 1.;
        _scrollView.zoomScale = 1.;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-BOTTOM_SAFE_AREA);
    }
    return _scrollView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

@end
