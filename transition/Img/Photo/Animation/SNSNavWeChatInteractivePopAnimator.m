//
//  LYNavWeChatInteractivePopAnimator.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "SNSNavWeChatInteractivePopAnimator.h"
#import "UIImageView+Proces.h"
#define animationTime .25
@implementation SNSNavWeChatInteractivePopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return animationTime;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象)
    UIView *imgBgWhiteView = [[UIView alloc] initWithFrame:self.transitionBeforeImgFrame];
    imgBgWhiteView.backgroundColor = toView.backgroundColor;
    [containerView addSubview:imgBgWhiteView];
    
    //有渐变的黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 1;
    [containerView addSubview:bgView];
    
//    FromVC
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIView *fromView = fromViewController.view;
//    fromView.backgroundColor = [UIColor clearColor];
//    [containerView addSubview:fromView];
    
    //过渡的图片
    UIImageView *transitionImgView = [[UIImageView alloc] init];
    [transitionImgView sns_setImageWithURL:[NSURL URLWithString:self.transitionImgUrl] placeholderImage:nil];
//    UIImageView *transitionImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.transitionImgName]];
    transitionImgView.frame = self.transitionAfterImgFrame;
    transitionImgView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImgView.clipsToBounds = YES;
    [transitionContext.containerView addSubview:transitionImgView];
    
//    if (!transitionImgView.image || self.transitionAfterImgFrame.size.height / self.transitionAfterImgFrame.size.width > 3) {
//        [transitionImgView sns_setImageWithURL:[NSURL URLWithString:self.transitionSmallImgUrl] placeholderImage:nil];
//    }
    //[self transitionDuration:transitionContext]
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
        transitionImgView.layer.contentsRect = self.imgViewContentRect;
        transitionImgView.frame = self.transitionBeforeImgFrame;
        bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        
        [imgBgWhiteView removeFromSuperview];
        [bgView removeFromSuperview];
        [transitionImgView removeFromSuperview];
        
//        [fromView removeFromSuperview];
        
        //设置transitionContext通知系统动画执行完毕
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}

@end




