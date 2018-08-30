//
//  ViewController.m
//  Img
//
//  Created by huihuadeng on 2018/8/30.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "ViewController.h"
#import "SHIWeChatInteractiveAnimatedTransition.h"
#import "ImageViewController.h"

#import "GlobalDefine.h"
@interface ViewController ()
@property (nonatomic, strong) SHIWeChatInteractiveAnimatedTransition *originAnimatedTransition;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0904.JPG"]];
    [self.view addSubview:self.imgView];
    self.imgView.frame = CGRectMake(100, 100, 100, 100);
    
    self.imgView.contentMode = UIViewContentModeScaleToFill;
    self.imgView.clipsToBounds = YES;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(20, 20, 44, 44);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction:(UIButton *)btn{

    CGRect imgBeforeFrame = CGRectMake(100, 100, 100, 100);
    [self.originAnimatedTransition setTransitionImgView:self.imgView];
    [self.originAnimatedTransition setTransitionBeforeImgFrame:imgBeforeFrame];
    // 100 100 250 250
    CGRect imgAfterFrame = CGRectMake(0, 0,250, 250);
//    CGRect imgAfterFrame = CGRectMake(0, 0,ScreenWidth, ScreenHeight);
    [self.originAnimatedTransition setTransitionAfterImgFrame:imgAfterFrame];
    
    ImageViewController *imgVC = [[ImageViewController alloc] init];
    imgVC.transitioningDelegate = self.originAnimatedTransition;
    [self presentViewController:imgVC animated:YES completion:^{
        
    }];
}

- (SHIWeChatInteractiveAnimatedTransition *)originAnimatedTransition {
    if (!_originAnimatedTransition) {
        _originAnimatedTransition = [[SHIWeChatInteractiveAnimatedTransition alloc] init];
    }
    return _originAnimatedTransition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
