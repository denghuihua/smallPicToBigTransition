//
//  ImageViewController.m
//  Img
//
//  Created by huihuadeng on 2018/8/30.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "SNSImagePreviewViewController.h"
#import "LYModalWeChatInteractiveAnimatedTransition.h"
#import "GlobalDefine.h"
#import "SNSImagePreviewCell.h"

static NSString *CellIdentifier = @"SNSImagePreviewCell";

@interface SNSImagePreviewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) LYModalWeChatInteractiveAnimatedTransition *animatedTransition;
@property (nonatomic, assign) CGPoint transitionImgViewCenter;

@property (nonatomic, strong) UICollectionView *imgCollectionView;
@property (nonatomic, strong) NSMutableArray *imgDataArr;

@property (nonatomic, assign) NSInteger currentPreviewIndex;


@end

@implementation SNSImagePreviewViewController

- (void)setImageDataArr:(NSArray<SNSImagePreviewModel *> *)imgArr currentSelectIndex:(NSInteger)tapIndex{
    self.imgDataArr = [NSMutableArray arrayWithArray:imgArr];
    self.currentPreviewIndex = tapIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImage *image = [UIImage imageNamed:@"0.jpg"];
//    CGSize size = [self backImageSize:image];
//    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kScreenHeight - size.height) * 0.5, size.width, size.height)];
//    self.imgView.image = image;
//    self.imgView.userInteractionEnabled = YES;
//    [self.view addSubview:self.imgView];
    [self.view addSubview:self.imgCollectionView];
    self.imgCollectionView.frame = self.view.bounds;
    [self.imgCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    
    self.transitionImgViewCenter = self.imgView.center;
    self.beforeImageViewFrame = CGRectMake(50, 100, 100, 100);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(20, 20, 44, 44);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
    
}

- (void)interactiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    
    CGFloat scale = 1 - fabs(translation.y / kScreenHeight);
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

//待会修改
- (void)btnAction:(UIButton *)btn{
      
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backToSmallView:(NSInteger)index{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGSize)backImageSize:(UIImage *)image{
    
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = kScreenWidth;
    newSize.height = newSize.width / size.width * size.height;
    
    return newSize;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SNSImagePreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //tap回调
    __weak SNSImagePreviewViewController *weakSelf = self;
    cell.tapHander = ^(UITapGestureRecognizer *tapGes){
        __strong SNSImagePreviewViewController *strongSelf = weakSelf;
        [strongSelf backToSmallView:indexPath.item];
    };
    
    SNSImagePreviewModel *imgModel = [self.imgDataArr objectAtIndex:indexPath.item];
    cell.imgView.image = [UIImage imageNamed:imgModel.imgName];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - getter

- (LYModalWeChatInteractiveAnimatedTransition *)animatedTransition{
    if (!_animatedTransition) {
        _animatedTransition = [[LYModalWeChatInteractiveAnimatedTransition alloc] init];
    }
    return _animatedTransition;
}

- (UICollectionView *)imgCollectionView {
    if (!_imgCollectionView) {
        
        UICollectionViewFlowLayout *listFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat padding = 0;
        listFlowLayout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
        CGFloat lineSpace = 0;
        CGFloat itmeSpace = 0;
        listFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        listFlowLayout.minimumInteritemSpacing = itmeSpace;
        listFlowLayout.minimumLineSpacing = lineSpace;
        
       
        listFlowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-BOTTOM_SAFE_AREA-(kAPP_STATUSBAR_HEIGHT-20));
        _imgCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:listFlowLayout];
        _imgCollectionView.dataSource = self;
        _imgCollectionView.delegate = self;
        _imgCollectionView.allowsSelection = YES;
        _imgCollectionView.pagingEnabled = YES;
        _imgCollectionView.alwaysBounceHorizontal = YES;
        [_imgCollectionView registerClass:[SNSImagePreviewCell class] forCellWithReuseIdentifier:CellIdentifier];
        _imgCollectionView.backgroundColor = [UIColor blackColor];
        if (@available(iOS 11.0, *)) {
            _imgCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _imgCollectionView.backgroundColor = [UIColor redColor];
    }
    return _imgCollectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
