//
//  ImageViewController.m
//  Img
//
//  Created by huihuadeng on 2018/8/30.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "SNSImagePreviewViewController.h"
#import "SNSModalWeChatInteractiveAnimatedTransition.h"
#import "GlobalDefine.h"
#import "SNSImagePreviewCell.h"

static NSString *CellIdentifier = @"SNSImagePreviewCell";

@interface SNSImagePreviewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) SNSModalWeChatInteractiveAnimatedTransition *animatedTransition;
@property (nonatomic, assign) CGPoint transitionImgViewCenter;

@property (nonatomic, strong) UICollectionView *imgCollectionView;
@property (nonatomic, strong) NSMutableArray *imgDataArr;
@property (nonatomic, assign) NSInteger currentPreviewIndex;

@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation SNSImagePreviewViewController

- (void)setImageDataArr:(NSArray<SNSImagePreviewModel *> *)imgArr currentSelectIndex:(NSInteger)tapIndex{
    self.imgDataArr = [NSMutableArray arrayWithArray:imgArr];
    self.currentPreviewIndex = tapIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.imgCollectionView];
    self.imgCollectionView.frame = self.view.bounds;
    
    [self.view addSubview:self.pageControl];
    
    [self.imgCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPreviewIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    self.pageControl.currentPage = self.currentPreviewIndex;
    
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
}

- (void)interactiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    SNSImagePreviewCell *cell = (SNSImagePreviewCell *)[self.imgCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPreviewIndex inSection:0]];
    UIImageView *currentPreviewImageView = cell.imgView;
    SNSImagePreviewModel *model = [self.imgDataArr objectAtIndex:self.currentPreviewIndex];
    
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
            self.transitionImgViewCenter = currentPreviewImageView.center;
            self.transitioningDelegate = self.animatedTransition;
            
            self.animatedTransition.gestureRecognizer = gestureRecognizer;
            
            //3.dismiss
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
            break;
        case UIGestureRecognizerStateChanged: {
            
            currentPreviewImageView.center = CGPointMake(self.transitionImgViewCenter.x + translation.x * scale, self.transitionImgViewCenter.y + translation.y);
            currentPreviewImageView.transform = CGAffineTransformMakeScale(scale, scale);
            
            self.animatedTransition.beforeImageViewFrame = model.smallImgFrame;
            
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            if (scale > 0.95f) {
                [UIView animateWithDuration:0.2 animations:^{
                    
                    currentPreviewImageView.center = self.transitionImgViewCenter;
                    currentPreviewImageView.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    
                    currentPreviewImageView.transform = CGAffineTransformIdentity;
                }];
            }else{
                
            }
            self.animatedTransition.currentImageView = currentPreviewImageView;
            self.animatedTransition.currentImageViewFrame = currentPreviewImageView.frame;
            
            self.animatedTransition.gestureRecognizer = nil;
        }
    }
}


- (void)backToSmallView:(NSInteger)index{
    //找到当前imageView
    SNSImagePreviewCell *cell = (SNSImagePreviewCell *)[self.imgCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPreviewIndex inSection:0]];
    SNSImagePreviewModel *item = [self.imgDataArr objectAtIndex:self.currentPreviewIndex];
    self.animatedTransition = nil;
    
    //1. 传入必要的3个参数
    [self.animatedTransition setTransitionImgName:item.imgName];
    [self.animatedTransition setTransitionBeforeImgFrame:item.smallImgFrame];
    [self.animatedTransition setTransitionAfterImgFrame:cell.imgView.frame];
    
    //2.设置代理
    self.transitioningDelegate = self.animatedTransition;
    
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
    cell.oneTapHander  = ^(UITapGestureRecognizer *tapGes){
        __strong SNSImagePreviewViewController *strongSelf = weakSelf;
        [strongSelf backToSmallView:indexPath.item];
    };
    
    SNSImagePreviewModel *imgModel = [self.imgDataArr objectAtIndex:indexPath.item];
    cell.imgView.image = [UIImage imageNamed:imgModel.imgName];
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPreviewIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = self.currentPreviewIndex;

}

#pragma mark - getter

- (SNSModalWeChatInteractiveAnimatedTransition *)animatedTransition{
    if (!_animatedTransition) {
        _animatedTransition = [[SNSModalWeChatInteractiveAnimatedTransition alloc] init];
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
        _imgCollectionView.backgroundColor = [UIColor blackColor];
    }
    return _imgCollectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 60, kScreenWidth, 44)];
        _pageControl.numberOfPages = self.imgDataArr.count;
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    }
    return _pageControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
