//
//  LYModalWeChatInteractiveAnimatedTransition.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "LYModalWeChatInteractiveAnimatedTransition.h"
#import "LYNavWeChatInteractivePushAnimator.h"
#import "LYNavWeChatInteractivePopAnimator.h"
#import "LYModalWeChatPercentDrivenInteractive.h"

@interface LYModalWeChatInteractiveAnimatedTransition ()

@property (nonatomic, strong) LYNavWeChatInteractivePushAnimator *customPush;
@property (nonatomic, strong) LYNavWeChatInteractivePopAnimator  *customPop;
@property (nonatomic, strong) LYModalWeChatPercentDrivenInteractive  *percentIntractive;

@end
@implementation LYModalWeChatInteractiveAnimatedTransition

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
    return self.customPush;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
    return self.customPop;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (self.gestureRecognizer)
        return self.percentIntractive;
    else
        return nil;
}

- (void)setGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer{
    _gestureRecognizer = gestureRecognizer;
}
- (LYNavWeChatInteractivePushAnimator *)customPush{
    if (_customPush == nil) {
        _customPush = [[LYNavWeChatInteractivePushAnimator alloc]init];
    }
    return _customPush;
}

- (LYNavWeChatInteractivePopAnimator *)customPop{
    if (!_customPop) {
        _customPop = [[LYNavWeChatInteractivePopAnimator alloc] init];
    }
    return _customPop;
}
- (LYModalWeChatPercentDrivenInteractive *)percentIntractive{
    if (!_percentIntractive) {
        _percentIntractive = [[LYModalWeChatPercentDrivenInteractive alloc] initWithGestureRecognizer:self.gestureRecognizer];
    }
    return _percentIntractive;
    
}

@end

