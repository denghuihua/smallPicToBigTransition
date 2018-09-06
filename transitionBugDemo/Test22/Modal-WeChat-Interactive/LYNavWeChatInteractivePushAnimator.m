//
//  LYNavWeChatInteractivePushAnimator.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYNavWeChatInteractivePushAnimator.h"
#import "GlobalDefine.h"

@implementation LYNavWeChatInteractivePushAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    [containerView addSubview:fromView];
    
    //渐变背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [containerView addSubview:bgView];
    bgView.alpha = 0;
    bgView.backgroundColor = [UIColor blackColor];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    toView.frame = CGRectMake(0, kScreenHeight , kScreenWidth, kScreenHeight);     
   
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        bgView.alpha = 0.6;
        toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end


