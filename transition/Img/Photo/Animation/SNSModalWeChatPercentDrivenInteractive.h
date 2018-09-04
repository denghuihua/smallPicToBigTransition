//
//  LYModalWeChatPercentDrivenInteractive.h
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//
/*
  图片动画： 需要sever提供 原图 的清晰度低一点的图，用于网络不好的情况下，展示
  
  完整模糊图展示之后  加载原图（优化）
 
  花式排版的裁剪图
 */


#import <UIKit/UIKit.h>

@interface SNSModalWeChatPercentDrivenInteractive : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer;

@property (nonatomic, assign) CGRect            beforeImageViewFrame;   //图片的frame
@property (nonatomic, assign) CGRect            currentImageViewFrame;   //当前图片的frame
@property (nonatomic, strong) UIImageView      *currentImageView;        //当前图片

@end
