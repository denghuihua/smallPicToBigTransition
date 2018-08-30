
#import "SHIWeChatInteractiveAnimatedTransition.h"
#import "SHIWeChatInteractivePushAnimator.h"
#import "SHIWeChatInteractivePopAnimator.h"
#import "SHIWeChatPercentDrivenInteractive.h"

@interface SHIWeChatInteractiveAnimatedTransition ()

@property (nonatomic, strong) SHIWeChatInteractivePushAnimator *customPush;
@property (nonatomic, strong) SHIWeChatInteractivePopAnimator  *customPop;
@property (nonatomic, strong) SHIWeChatPercentDrivenInteractive  *percentIntractive;

@end
@implementation SHIWeChatInteractiveAnimatedTransition

/** 转场过渡的图片 */
- (void)setTransitionImgView:(UIImageView *)transitionImgView{
    self.customPush.transitionImgView = transitionImgView;
    self.customPop.transitionImgView = transitionImgView;
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
- (SHIWeChatInteractivePushAnimator *)customPush{
    if (_customPush == nil) {
        _customPush = [[SHIWeChatInteractivePushAnimator alloc]init];
    }
    return _customPush;
}

- (SHIWeChatInteractivePopAnimator *)customPop{
    if (!_customPop) {
        _customPop = [[SHIWeChatInteractivePopAnimator alloc] init];
    }
    return _customPop;
}

- (SHIWeChatPercentDrivenInteractive *)percentIntractive{
    if (!_percentIntractive) {
        _percentIntractive = [[SHIWeChatPercentDrivenInteractive alloc] initWithGestureRecognizer:self.gestureRecognizer];
    }
    return _percentIntractive;
}

@end

