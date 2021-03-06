//
//  LYModalWeChatPercentDrivenInteractive.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYModalWeChatPercentDrivenInteractive.h"
#import "GlobalDefine.h"

@interface LYModalWeChatPercentDrivenInteractive ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *fromView;
@property(nonatomic, strong) UIView *blackBgView;

@end

@implementation LYModalWeChatPercentDrivenInteractive
{
    BOOL _isFirst;
}

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    self = [super init];
    if (self)
    {
        _isFirst = YES;
        _gestureRecognizer = gestureRecognizer;
        
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}


- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
    
    CGPoint translation = [gesture translationInView:gesture.view];
    
    CGFloat scale = 1 - fabs(translation.y / kScreenHeight);
    scale = scale < 0 ? 0 : scale;
    return scale;
}

- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat scrale = [self percentForGesture:gestureRecognizer];
    NSLog(@"interactive %f",scrale);
    
    if (_isFirst) {
        [self beginInterPercent];
        _isFirst = NO;
    }
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            
            
            break;
        case UIGestureRecognizerStateChanged:
            
            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            [self updateInterPercent:[self percentForGesture:gestureRecognizer]];
            
            break;
        case UIGestureRecognizerStateEnded:
            
            if (scrale > 0.55f){
                
                [self cancelInteractiveTransition];
                [self interPercentCancel];
            }
            else{
                [self finishInteractiveTransition];
                [self interPercentFinish:scrale];
            }
            break;
        default:
            [self cancelInteractiveTransition];
            [self interPercentCancel];
            break;
    }
}

- (void)beginInterPercent{
    //    NSLog(@"开始");
    
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    //有渐变的黑色背景
    _blackBgView = [[UIView alloc] initWithFrame:containerView.bounds];
    _blackBgView.backgroundColor = [UIColor blackColor];
    _blackBgView.alpha = 0.8;
    [containerView addSubview:_blackBgView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:fromView];
    
}
- (void)updateInterPercent:(CGFloat)scale{
    //    NSLog(@"变化");
    
    _blackBgView.alpha = 0.8 * scale * scale * scale;
}

- (void)interPercentCancel{
    //    NSLog(@"取消");
    
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    [containerView addSubview:fromView];
    
    [_blackBgView removeFromSuperview];
    _blackBgView = nil;
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}
//完成
- (void)interPercentFinish:(CGFloat)scale{
    //    NSLog(@"完成");
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
    
        self.blackBgView.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        NSLog(@"panGesture animation finished");
        
        [self.blackBgView removeFromSuperview];
        self.blackBgView = nil;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    //    [super startInteractiveTransition:transitionContext];
}

@end
