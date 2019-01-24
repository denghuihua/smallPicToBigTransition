//
//  ViewController.m
//  ImgTransiton
//
//  Created by huihuadeng on 2019/1/24.
//  Copyright © 2019年 huihuadeng. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+SizeHelper.h"
@interface ViewController ()

@property(nonatomic, strong) UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.imgView];
    self.imgView.frame = [UIImage scaleBigFrameWithSize:self.imgView.image.size];
    //平移手势
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    interactiveTransitionRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
    
}

- (void)interactiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    NSLog(@"interactiveTransitionRecognizerActionvelocity:%@",NSStringFromCGPoint(velocity));
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    NSLog(@"interactiveTransitionRecognizerActionTranslation:%@",NSStringFromCGPoint(translation));
   
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //手势发生在哪个view上
        UIView *piece = self.imgView;
        //获得当前手势在view上的位置。
        CGPoint locationInView = [gestureRecognizer locationInView:self.imgView];
        
        piece.layer.anchorPoint =CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        //根据在view上的位置设置锚点。
        //防止设置完锚点过后，view的位置发生变化，相当于把view的位置重新定位到原来的位置上。
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        piece.layer.position = locationInSuperview;
        NSLog(@"开始center:%@",NSStringFromCGPoint(piece.layer.position));
        
    }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat scale = 1 - fabs(translation.y / ScreenHeight);
        CGAffineTransform t = CGAffineTransformTranslate(CGAffineTransformIdentity, translation.x, translation.y);
        CGAffineTransform scaleTransform = CGAffineTransformScale(t, scale, scale);
        self.imgView.transform = scaleTransform;
    }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        //锚点复位
        CGRect frame = self.imgView.frame;
        CGPoint center = CGPointMake(frame.origin.x + frame.size.width/2 , frame.origin.y + frame.size.height/2);
        self.imgView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.imgView.layer.position = center;
    }
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
        //UIViewContentModeScaleAspectFill contentMode 配合 clipsToBounds 使用，才能真正实现 一边适应frame 宽，一边实现剪切的作用
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.image = [UIImage imageNamed:@"IMG_0091.JPG"];
    }
    return _imgView;
}
@end
