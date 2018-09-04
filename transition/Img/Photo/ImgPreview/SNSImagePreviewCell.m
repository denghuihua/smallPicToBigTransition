//
//  SNSImagePreviewCell.m
//  Img
//
//  Created by huihuadeng on 2018/8/31.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "SNSImagePreviewCell.h"
#import "SNSUIConstants.h"
#import "SNSImagePreviewModel.h"

#define kSNSPhotoPanCloseGuideViewHasShowed @"kSNSPhotoPanCloseGuideViewHasShowed"

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
    
    self.scrollView.frame = self.bounds;
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapAction:)];
    oneTap.numberOfTapsRequired = 1;
    [self.imgView addGestureRecognizer:oneTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.imgView addGestureRecognizer:doubleTap];
    
    [oneTap requireGestureRecognizerToFail:doubleTap];
}

- (void)oneTapAction:(UITapGestureRecognizer *)tapGes{
    if (self.oneTapHander) {
        self.oneTapHander(tapGes);
    }
}

- (void)doubleTapAction:(UITapGestureRecognizer *)tapGes{
    if(self.scrollView.zoomScale <= 1.0f){
        [self.scrollView zoomToRect:[self frameWithW:1 h:1 center:[tapGes locationInView:tapGes.view]] animated:YES];
    } else {
        [self.scrollView setZoomScale:1.0f animated:YES];
    }
}

- (CGRect)frameWithW:(CGFloat)w h:(CGFloat)h center:(CGPoint)center{
    CGFloat x = center.x - w *.5f;
    CGFloat y = center.y - h * .5f;
    CGRect frame = (CGRect){CGPointMake(x, y),CGSizeMake(w, h)};
    return frame;
}

- (void)adjustZoomScale
{
    if (!self.imgView) {
        return;
    }
    
    CGSize imgSize = self.imgView.image.size;
    
    //判断首先缩放的值
    float scaleX = self.imgView.superview.frame.size.width/imgSize.width;
    float scaleY = self.imgView.superview.frame.size.height/imgSize.height;
    
    if (scaleX > scaleY)
    {
        float imgViewWidth = imgSize.width * scaleY;
        self.imgView.frame = (CGRect){self.imgView.superview.frame.size.width/2 - imgViewWidth/2,0,imgViewWidth,self.imgView.superview.frame.size.height};
        float x = self.frame.size.width/self.imgView.frame.size.width;
        self.scrollView.maximumZoomScale = MAX(x, 1.8);
        self.scrollView.maximumZoomScale = MIN(self.scrollView.maximumZoomScale, 3);
    }
    else
    {
        float imgViewHeight = imgSize.height * scaleX;
        self.imgView.frame = (CGRect){0,self.imgView.superview.frame.size.height/2 - imgViewHeight/2,self.imgView.superview.frame.size.width,imgViewHeight};
        float y = self.frame.size.height/self.imgView.frame.size.height;
        self.scrollView.maximumZoomScale = MAX(y, 1.8);
        self.scrollView.maximumZoomScale = MIN(self.scrollView.maximumZoomScale, 3);
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = self.imgView.frame;
    CGSize contentSize = scrollView.contentSize;

    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);

    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        centerPoint.x = boundsSize.width/2;
    }

    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        centerPoint.y = boundsSize.height/2;
    }

    self.imgView.center = centerPoint;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:YES];
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 3.;
        _scrollView.minimumZoomScale = 1.;
        _scrollView.zoomScale = 1.;
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight- SNS_TabbarHeight);
        _scrollView.backgroundColor = [UIColor clearColor];
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } 
    }
    return _scrollView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
        _imgView.backgroundColor = [UIColor clearColor];
        
    }
    return _imgView;
}

#pragma mark - not important needRewrite
//- (void)showExitFullscreenGuideViewIfNeeded{
//    NSString *photoPanCloseGuideViewHasShowed = [[NSUserDefaults standardUserDefaults] objectForKey:kSNSPhotoPanCloseGuideViewHasShowed];
//    if (photoPanCloseGuideViewHasShowed){
//        return;
//    }
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 36)/2,-88, 36, 176)];
//    imageView.tag = 1111;
//    imageView.image = [[UIImage snsImageNamed:@"ss_bubble"] rotatedByDegrees:-90];
//
//    imageView.alpha = 0;
//    [self addSubview:imageView];
//
//    NSString *text = @"下滑关闭图片";
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 36, 26, 110)];
//    textLabel.text = text;
//    textLabel.textColor = IsNight? [UIColor colorWithHex:0xcacaca] : [UIColor whiteColor];
//    textLabel.numberOfLines = 0;
//    textLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    textLabel.textAlignment = NSTextAlignmentCenter;
//    textLabel.font = [UIFont systemFontOfSize:14];
//    [imageView addSubview:textLabel];
//
//    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 146, 16, 16)];
//    arrowImageView.image = [[UIImage snsImageNamed:@"ss_arrow"] rotatedByDegrees:-90];
//    [imageView addSubview:arrowImageView];
//
//    [UIView animateWithDuration:.5 animations:^{
//        imageView.frame = CGRectMake((self.width - 36)/2,0, 36, 176);
//        imageView.alpha = 1;
//    }];
//
//    [UIView animateWithDuration:.32 delay:.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        arrowImageView.top = 149;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:.32 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            arrowImageView.top = 146;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:.32 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                arrowImageView.top = 149;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:.32 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                    arrowImageView.top = 146;
//                } completion:^(BOOL finished) {
//                    [UIView animateWithDuration:.32 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                        arrowImageView.top = 149;
//                    } completion:^(BOOL finished) {
//
//                        [UIView animateWithDuration:.32 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                            arrowImageView.top = 146;
//                        } completion:^(BOOL finished) {
//
//                            [UIView animateWithDuration:1 delay:1.33 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                                imageView.alpha = 0;
//                            } completion:^(BOOL finished) {
//                                [imageView removeFromSuperview];
//                            }];
//
//                        }];
//                    }];
//                }];
//            }];
//        }];
//    }];
//
//    [[NSUserDefaults standardUserDefaults] setObject:@"1"
//                                              forKey:kSNSPhotoPanCloseGuideViewHasShowed];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

@end
