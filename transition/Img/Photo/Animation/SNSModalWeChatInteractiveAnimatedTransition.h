//
//  LYModalWeChatInteractiveAnimatedTransition.h
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNSModalWeChatInteractiveAnimatedTransition : NSObject<UIViewControllerTransitioningDelegate>


- (void)setTransitionImgViewContentRect:(CGRect)contentRect;

/** 转场过渡的图片 */
- (void)setTransitionImgUrl:(NSString *)imgUrl;
- (void)setTransitionSmallImgUrl:(NSString *)imgUrl;

/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame;

/** 转场后的图片frame */
- (void)setTransitionAfterImgFrame:(CGRect)frame;
- (void)setTransitionAfterSmallImgFrame:(CGRect)frame;

@property (nonatomic, assign) CGRect            beforeImageViewFrame;    //图片的frame
@property (nonatomic, assign) CGRect            currentImageViewFrame;   //当前图片的frame
@property (nonatomic, strong) UIImageView      *currentImageView;        //当前图片

@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;

@end
