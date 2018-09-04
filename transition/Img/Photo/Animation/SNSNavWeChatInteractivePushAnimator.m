//
//  LYNavWeChatInteractivePushAnimator.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//
#define animationTime .25

#import "SNSNavWeChatInteractivePushAnimator.h"
#import "UIImageView+Proces.h"

@implementation SNSNavWeChatInteractivePushAnimator

//把大图去掉
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return animationTime;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    [containerView addSubview:fromView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    toView.hidden = YES;
    
    //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象 [可以换种颜色看看效果])
    UIView *imgBgWhiteView = [[UIView alloc] initWithFrame:self.transitionBeforeImgFrame];
    imgBgWhiteView.backgroundColor = fromView.backgroundColor;
    [containerView addSubview:imgBgWhiteView];
    
    //有渐变的黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0;
    [containerView addSubview:bgView];
    
    //过渡的图片
    UIImageView *transitionImgView = [[UIImageView alloc] init];
    CGRect endFrame = CGRectZero;
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.transitionImgUrl];
//    if (!cacheImage) {
//        [transitionImgView sns_setImageWithURL:[NSURL URLWithString:self.transitionSmallImgUrl] placeholderImage:nil];
//        endFrame = self.transitionAfterSmallImgFrame;
//    }else
//    {
        [transitionImgView sns_setImageWithURL:[NSURL URLWithString:self.transitionImgUrl] placeholderImage:nil];
        endFrame = self.transitionAfterImgFrame;
//    }
    
    transitionImgView.frame = self.transitionBeforeImgFrame;
    transitionImgView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImgView.clipsToBounds = YES;
    transitionImgView.layer.contentsRect = self.imgViewContentRect;
    [transitionContext.containerView addSubview:transitionImgView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        if (transitionImgView.layer.contentsRect.size.height != 1) {
            CGRect newRect  = transitionImgView.layer.contentsRect;
            newRect.size.height = 1;
            transitionImgView.layer.contentsRect = newRect;
        }
        
        transitionImgView.frame = endFrame;
        bgView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        toView.hidden = NO;
        
        [imgBgWhiteView removeFromSuperview];
        [bgView removeFromSuperview];
        [transitionImgView removeFromSuperview];
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        //设置transitionContext通知系统动画执行完毕
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}

@end


