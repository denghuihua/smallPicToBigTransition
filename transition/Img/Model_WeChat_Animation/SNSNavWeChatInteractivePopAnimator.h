//
//  LYNavWeChatInteractivePopAnimator.h
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNSNavWeChatInteractivePopAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, copy) NSString *transitionImgName;

@property (nonatomic, assign) CGRect transitionBeforeImgFrame;  //转场前图片的frame

@property (nonatomic, assign) CGRect transitionAfterImgFrame;   //转场后图片的frame

@end
