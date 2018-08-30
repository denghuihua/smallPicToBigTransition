
#import <UIKit/UIKit.h>

@interface SHIWeChatInteractiveAnimatedTransition : NSObject<UIViewControllerTransitioningDelegate>

/** 转场过渡的图片 */
- (void)setTransitionImgView:(UIImageView *)transitionImgView;

/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame;

/** 转场后的图片frame */
- (void)setTransitionAfterImgFrame:(CGRect)frame;


@property (nonatomic, assign) CGRect            beforeImageViewFrame;    //图片的frame
@property (nonatomic, assign) CGRect            currentImageViewFrame;   //当前图片的frame
@property (nonatomic, strong) UIImageView      *currentImageView;        //当前图片

@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;

@end
