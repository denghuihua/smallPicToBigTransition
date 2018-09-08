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
@property(nonatomic, assign) CGPoint  containerViewCenter;
@property (nonatomic, strong) LYModalWeChatInteractiveAnimatedTransition *animatedTransition;
@end

@implementation TLFeedTogetherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
    
   
//    self.transitioningDelegate = self;
    [self.view addSubview:self.containerView];
    
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    [self.containerView addGestureRecognizer:interactiveTransitionRecognizer];
    
    self.containerViewCenter = self.containerView.center;
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
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGFloat scale = 1 - fabs(translation.y / kScreenHeight);
    scale = scale < 0 ? 0 : scale;
    
    NSLog(@"second = %f====translation:%f", scale,translation.y);
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
            
            self.containerView.center = CGPointMake(self.containerViewCenter.x , self.containerViewCenter.y + translation.y);
            NSLog(@"containerViewCenter:%@",NSStringFromCGPoint(self.containerViewCenter));
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            if (scale > 0.55f) {
                [UIView animateWithDuration:0.2 animations:^{
                    
                     self.containerView.center =  self.containerViewCenter;

                } completion:^(BOOL finished) {
                    
                }];
            }else{
                
            }

            self.animatedTransition.gestureRecognizer = nil;
        }
    }
}


- (LYModalWeChatInteractiveAnimatedTransition *)animatedTransition {
    if (!_animatedTransition) {
        _animatedTransition = [[LYModalWeChatInteractiveAnimatedTransition alloc] init];
    }
    return _animatedTransition;
}


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
