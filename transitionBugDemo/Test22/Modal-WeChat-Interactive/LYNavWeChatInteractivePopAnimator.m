//
//  LYNavWeChatInteractivePopAnimator.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYNavWeChatInteractivePopAnimator.h"
#import "GlobalDefine.h"

@implementation LYNavWeChatInteractivePopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC  此处不能这样 
    /* 链接 https://stackoverflow.com/questions/25588617/ios-8-screen-blank-after-dismissing-view-controller-with-custom-presentation
     view controllers to your containerView in the (void)animateTransition:(id )transitionContext method of your animation controller. Since you are using a custom modal presentation, the presenting view controller is still shown beneath the presented view controller. Now since it's still visible you don't need to add it to the container view. Instead only add the presented view controller to the containerView. Should look something like this inside of your animateTransition: method
     */
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *toView = toViewController.view;
//    [containerView addSubview:toView];

    
    //有渐变的黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8;
    [containerView addSubview:bgView];
    
    //    FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor clearColor];
//    [containerView addSubview:fromView];
    
    fromView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
      
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        
        fromView.frame = CGRectMake(0, kScreenHeight , kScreenWidth, kScreenHeight); 
        bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [bgView removeFromSuperview];
        
        //设置transitionContext通知系统动画执行完毕
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end




