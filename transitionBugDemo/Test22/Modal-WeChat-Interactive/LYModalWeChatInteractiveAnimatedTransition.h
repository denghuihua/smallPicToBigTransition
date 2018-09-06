//
//  LYModalWeChatInteractiveAnimatedTransition.h
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYModalWeChatInteractiveAnimatedTransition : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;

@end
