//
//  ViewController.m
//  Img
//
//  Created by huihuadeng on 2018/8/30.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "ViewController.h"
#import "LYModalWeChatInteractiveAnimatedTransition.h"
#import "SNSImagePreviewViewController.h"

#import "GlobalDefine.h"
@interface ViewController ()
@property (nonatomic, strong) LYModalWeChatInteractiveAnimatedTransition *animatedTransition;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imgDataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imgDataArr = [[NSMutableArray alloc] init];
    
    CGFloat width = 100;
    CGFloat height  = 100;
    CGFloat x_space = 5;
    CGFloat y_space = 5;
    
    for (int i  = 0; i < 9; i++) {
        NSString *imgNameStr = [NSString stringWithFormat:@"%d.jpg",i];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgNameStr]];
        [self.view addSubview:imgView];
        
        if (i == 0) {
            self.imageView = imgView;
        }
        
        CGFloat x = i%3 * (width + x_space)  + 50;
        CGFloat y = i/3 *(height + y_space)  + 100; 
        imgView.frame = CGRectMake(x, y, width, height);
        imgView.tag = 10 + i;
        
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.clipsToBounds = YES; 
        
        SNSImagePreviewModel *model = [[SNSImagePreviewModel alloc] init];
        model.imgName = imgNameStr;
        model.smallImgFrame = imgView.frame;
        [self.imgDataArr addObject:model];
        
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imgView addGestureRecognizer:tap];
        
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGes{
    
    UIView *view = tapGes.view;
    
    self.animatedTransition = nil;
    
    //1. 传入必要的3个参数
    [self.animatedTransition setTransitionImgView:self.imageView];
    [self.animatedTransition setTransitionBeforeImgFrame:self.imageView.frame];
    [self.animatedTransition setTransitionAfterImgFrame:[self backScreenImageViewRectWithImage:self.imageView.image]];
    
    
    SNSImagePreviewViewController *second = [[SNSImagePreviewViewController alloc] init];
    [second setImageDataArr:self.imgDataArr currentSelectIndex:view.tag - 10];
    second.beforeImageViewFrame = self.imageView.frame;
    //2.设置代理
    second.transitioningDelegate = self.animatedTransition;
    //3.push跳转
    [self presentViewController:second animated:YES completion:nil];
}

//返回imageView在window上全屏显示时的frame
- (CGRect)backScreenImageViewRectWithImage:(UIImage *)image{
    
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = kScreenWidth;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (kScreenHeight - newSize.height) * 0.5;
    
    if (imageY < 0) {
        imageY = 0;
    }
    CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
    
    return rect;
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
