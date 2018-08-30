
#import <UIKit/UIKit.h>

@interface SHIWeChatPercentDrivenInteractive : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer;

@property (nonatomic, assign) CGRect            beforeImageViewFrame;   //图片的frame
@property (nonatomic, assign) CGRect            currentImageViewFrame;   //当前图片的frame
@property (nonatomic, strong) UIImageView      *currentImageView;        //当前图片

@end
