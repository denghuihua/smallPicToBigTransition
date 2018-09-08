//
//  ViewController.m
//  Test22
//
//  Created by huihuadeng on 2018/9/5.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "ViewController.h"
#import "TLFeedTogetherViewController.h"
#import "LYModalWeChatInteractiveAnimatedTransition.h"

@interface ViewController ()
@property (nonatomic, strong) LYModalWeChatInteractiveAnimatedTransition *animatedTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@" viewcontroller viewWillAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@" viewcontroller viewWillDisappear");
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    NSLog(@"viewcontroller  dealloc");
}
/*
 typedef NS_ENUM(NSInteger, UIModalPresentationStyle) {
 UIModalPresentationFullScreen = 0,
 UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
 UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
 UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
 UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
 UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
 UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
 UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
 UIModalPresentationBlurOverFullScreen __TVOS_AVAILABLE(11_0) __IOS_PROHIBITED __WATCHOS_PROHIBITED,
 UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
 };

 */
- (void)buttonAction:(UIButton *)button{
    
    self.animatedTransition = nil;
    
    TLFeedTogetherViewController *second = [[TLFeedTogetherViewController alloc] init];
    //2.设置代理
    
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 ;
    
    
    second.transitioningDelegate = self.animatedTransition;
    //3.push跳转
    NSLog(@"present before");
    [self presentViewController:second animated:YES completion:nil];  
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


@end
