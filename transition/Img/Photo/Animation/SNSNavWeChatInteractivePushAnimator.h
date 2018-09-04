//
//  LYNavWeChatInteractivePushAnimator.h
//  LYCustomTransitionDemo
//
//  Created by liyang on 2017/2/23.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNSNavWeChatInteractivePushAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, copy) NSString *transitionImgUrl;
@property (nonatomic, copy) NSString *transitionSmallImgUrl;

@property (nonatomic, assign) CGRect imgViewContentRect;  //转场视图显示 范围

@property (nonatomic, assign) CGRect transitionBeforeImgFrame;  //转场前图片的frame

@property (nonatomic, assign) CGRect transitionAfterImgFrame;   //转场后图片的frame
@property (nonatomic, assign) CGRect transitionAfterSmallImgFrame;   //转场后小图片的frame  网速不好，大图没有下载下来的情况
@end
