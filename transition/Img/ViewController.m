//
//  ViewController.m
//  Img
//
//  Created by huihuadeng on 2018/8/30.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "ViewController.h"
#import "SNSModalWeChatInteractiveAnimatedTransition.h"
#import "SNSImagePreviewViewController.h"
#import "UIImageView+Proces.h"
#import "SNSUIConstants.h"
@interface ViewController ()
@property (nonatomic, strong) SNSModalWeChatInteractiveAnimatedTransition *animatedTransition;
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
    
//    NSArray *bigImageUrlArr = @[@"https://c1c2133e2cc13.cdn.sohucs.com/s_big/pic/20180830/410913555139796224.jpg",@"https://c1c2133e2cc13.cdn.sohucs.com/s_big/pic/20180830/410913558868532480.jpg",@"https://c1c2133e2cc13.cdn.sohucs.com/s_big/pic/20180830/410913560000994560.jpg",@"https://c1c2133e2cc13.cdn.sohucs.com/s_big/pic/20180830/410913560114240768.jpg"];
//    
//    NSArray *smallImgUrl = @[@"https://c1c2133e2cc13.cdn.sohucs.com/s_v4_4a/pic/20180830/410913555139796224.jpg",@"https://c1c2133e2cc13.cdn.sohucs.com/s_v4_4ab/pic/20180830/410913558868532480.jpg",@"https://c1c2133e2cc13.cdn.sohucs.com/s_v4_4ab/pic/20180830/410913560000994560.jpg",@"https://c1c2133e2cc13.cdn.sohucs.com/s_v4_4ab/pic/20180830/410913560114240768.jpg"];
    
    NSArray *bigImageUrlArr = @[@"https://c1c2133e2cc13.cdn.sohucs.com/s_big/pic/20180828/410132112834829312"];
    
    NSArray *smallImgUrl = @[@"https://c1c2133e2cc13.cdn.sohucs.com/s_mini/pic/20180828/410132112834829312"];

    
    
    for (int i  = 0; i < 1; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView sns_setImageWithURL:[NSURL URLWithString:[smallImgUrl objectAtIndex:i]] placeholderImage:nil];
        [self.view addSubview:imgView];
        
        if (i == 0) {
            self.imageView = imgView;
        }
        
        CGFloat x = i%3 * (width + x_space)  + 50;
        CGFloat y = i/3 *(height + y_space)  + 100; 
        imgView.frame = CGRectMake(0, y, ScreenWidth,  200);
        imgView.tag = 10 + i;
        
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES; 
        
//        float rate = imgView.frame.size.height/imgView.frame.size.width;
//        float rate2 = 924/694;
//        if (rate2 > rate) {
//            imgView.layer.contentsRect = CGRectMake(0, 0, 1, rate/rate2);
//        }
        
        SNSImagePreviewModel *model = [[SNSImagePreviewModel alloc] init];
        model.smallImgFrame = imgView.frame;
        model.smallImgUrl = [smallImgUrl objectAtIndex:i];
        model.bigImgUrl = [bigImageUrlArr objectAtIndex:i];
        switch (i) {
            case 0:
            {
                //tw th 696 924 w 1080 h 9246   
                model.imageSize = CGSizeMake(440, 440); 
                model.clipImageSize = CGSizeMake(694, 924);
            }
                break;
            case 1:
            {
                model.imageSize = CGSizeMake(2890, 1920);
            }
                break;
            case 2:
            {
                model.imageSize = CGSizeMake(1080, 1618);
            }
            case 3:
            {
                model.imageSize = CGSizeMake(1920, 2877);
            }
                break;
            default:
                break;
        }
        [self.imgDataArr addObject:model];
        
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imgView addGestureRecognizer:tap];
        
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGes{
    
    UIView *view = tapGes.view;
    NSInteger currentSelectIndex = view.tag - 10;
    SNSImagePreviewModel *item = [self.imgDataArr objectAtIndex:currentSelectIndex];
    self.animatedTransition = nil;
    
    //判断动画需要的图片  高/宽 > 3 长图动画选用小图 
    
    
    //1. 传入必要的3个参数
    [self.animatedTransition setTransitionImgViewContentRect:view.layer.contentsRect];
    if (item.imageSize.height / item.imageSize.width  > 3) {
        [self.animatedTransition setTransitionImgUrl:item.smallImgUrl];
        CGRect afterRect = [self getScaleBigFrameWithSize:item.clipImageSize];
        [self.animatedTransition setTransitionAfterImgFrame:CGRectMake(0, 0, afterRect.size.width, afterRect.size.height)];
    }
    
    [self.animatedTransition setTransitionSmallImgUrl:item.smallImgUrl];
    [self.animatedTransition setTransitionBeforeImgFrame:item.smallImgFrame];
    
    
    SNSImagePreviewViewController *second = [[SNSImagePreviewViewController alloc] init];
    [second setImageDataArr:self.imgDataArr currentSelectIndex:view.tag - 10];

    //2.设置代理
    second.transitioningDelegate = self.animatedTransition;
    //3.push跳转
    [self presentViewController:second animated:YES completion:nil];
}


- (CGRect)getScaleBigFrameWithSize:(CGSize)size
{
    if (size.height/size.width > ScreenHeight/ScreenWidth) {
        return CGRectMake(0, 0, ScreenWidth, ScreenWidth * size.height/size.width);
    }
    
    float scaleX = ScreenWidth/size.width;
    float scaleY = ScreenHeight/size.height;
    if (scaleX > scaleY){
        float imgViewWidth = size.width * scaleY;
        return (CGRect){(ScreenWidth/2) - (imgViewWidth/2),0,imgViewWidth,ScreenHeight};
    } else {
        float imgViewHeight = size.height * scaleX;
        return (CGRect){0,(ScreenHeight/2) - (imgViewHeight/2),ScreenWidth,imgViewHeight};
    }
}

- (SNSModalWeChatInteractiveAnimatedTransition *)animatedTransition {
    if (!_animatedTransition) {
        _animatedTransition = [[SNSModalWeChatInteractiveAnimatedTransition alloc] init];
    }
    return _animatedTransition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
