//
//  LYModalWeChatInteractiveAnimatedTransition.m
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "SNSModalWeChatInteractiveAnimatedTransition.h"
#import "SNSNavWeChatInteractivePushAnimator.h"
#import "SNSNavWeChatInteractivePopAnimator.h"
#import "SNSModalWeChatPercentDrivenInteractive.h"

@interface SNSModalWeChatInteractiveAnimatedTransition ()

@property (nonatomic, strong) SNSNavWeChatInteractivePushAnimator *customPush;
@property (nonatomic, strong) SNSNavWeChatInteractivePopAnimator  *customPop;
@property (nonatomic, strong) SNSModalWeChatPercentDrivenInteractive  *percentIntractive;

@end
@implementation SNSModalWeChatInteractiveAnimatedTransition

/** 转场过渡的图片 */
- (void)setTransitionImgName:(NSString *)imgName{
    self.customPush.transitionImgName = imgName;
    self.customPop.transitionImgName = imgName;
}

/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame{
    self.customPop.transitionBeforeImgFrame = frame;
    self.customPush.transitionBeforeImgFrame = frame;
    self.percentIntractive.beforeImageViewFrame = frame;
}

/** 转场后的图片frame */
- (void)setTransitionAfterImgFrame:(CGRect)frame{
    self.customPush.transitionAfterImgFrame = frame;
    self.customPop.transitionAfterImgFrame = frame;
}

-(void)setBeforeImageViewFrame:(CGRect)beforeImageViewFrame{
    _beforeImageViewFrame = beforeImageViewFrame;
    self.percentIntractive.beforeImageViewFrame = beforeImageViewFrame;
}
- (void)setCurrentImageViewFrame:(CGRect)currentImageViewFrame{
    _currentImageViewFrame = currentImageViewFrame;
    self.percentIntractive.currentImageViewFrame = currentImageViewFrame;
}
- (void)setCurrentImageView:(UIImageView *)currentImageView{
    _currentImageView = currentImageView;
    self.percentIntractive.currentImageView = currentImageView;
}

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
- (SNSNavWeChatInteractivePushAnimator *)customPush{
    if (_customPush == nil) {
        _customPush = [[SNSNavWeChatInteractivePushAnimator alloc]init];
    }
    return _customPush;
}

- (SNSNavWeChatInteractivePopAnimator *)customPop{
    if (!_customPop) {
        _customPop = [[SNSNavWeChatInteractivePopAnimator alloc] init];
    }
    return _customPop;
}
- (SNSModalWeChatPercentDrivenInteractive *)percentIntractive{
    if (!_percentIntractive) {
        _percentIntractive = [[SNSModalWeChatPercentDrivenInteractive alloc] initWithGestureRecognizer:self.gestureRecognizer];
    }
    return _percentIntractive;
    
}

@end

