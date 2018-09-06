//
//  TLFeedTogetherViewController.m
//  sohuhy
//
//  Created by huihuadeng on 2018/9/5.
//  Copyright © 2018年 sohu. All rights reserved.
//

#import "TLFeedTogetherViewController.h"
#import "GlobalDefine.h"

#import "LYModalWeChatInteractiveAnimatedTransition.h"
@interface TLFeedTogetherViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) UIView  *containerView;

@end

@implementation TLFeedTogetherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
    
    self.view.backgroundColor = [UIColor clearColor];
//    self.transitioningDelegate = self;
    [self.view addSubview:self.containerView];
    
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    [self.containerView addGestureRecognizer:interactiveTransitionRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

//- (LYModalWeChatInteractiveAnimatedTransition *)animatedTransition {
//    if (!_animatedTransition) {
//        _animatedTransition = [[LYModalWeChatInteractiveAnimatedTransition alloc] init];
//    }
//    return _animatedTransition;
//}

- (UIView *)containerView{
    if (!_containerView) {
        CGFloat start_y = 30;
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, start_y, self.view.frame.size.width, self.view.frame.size.height - start_y)];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius  =  10;
    }
    return _containerView;
}


- (void)interactiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    
    CGFloat scale = 1 - fabs(translation.y / ScreenHeight);
    scale = scale < 0 ? 0 : scale;
    
    NSLog(@"second = %f", scale);
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:{
            
            //1. 设置代理
            self.animatedTransition = nil;
            
            self.transitioningDelegate = self.animatedTransition;
            
            self.animatedTransition.gestureRecognizer = gestureRecognizer;
            
            //3.dismiss
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
            break;
        case UIGestureRecognizerStateChanged: {
            
            _imgView.center = CGPointMake(self.transitionImgViewCenter.x + translation.x * scale, self.transitionImgViewCenter.y + translation.y);
            _imgView.transform = CGAffineTransformMakeScale(scale, scale);
            
            self.animatedTransition.beforeImageViewFrame = self.beforeImageViewFrame;
            
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            if (scale > 0.95f) {
                [UIView animateWithDuration:0.2 animations:^{
                    
                    self.imgView.center = self.transitionImgViewCenter;
                    self.imgView.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    
                    self.imgView.transform = CGAffineTransformIdentity;
                }];
            }else{
                
            }
            self.animatedTransition.currentImageView = _imgView;
            self.animatedTransition.currentImageViewFrame = _imgView.frame;
            
            self.animatedTransition.gestureRecognizer = nil;
        }
    }
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
