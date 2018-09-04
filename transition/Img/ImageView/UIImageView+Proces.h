//
//  UIImageView+Proces.h
//  SNSUIKit
//
//  Created by wuyy on 2018/7/31.
//  Copyright © 2018年 sohu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+Proces.h"

@interface UIImageView (Proces)

/**
 网络请求图片
 */
- (void)sns_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)sns_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionWithFinishedBlock)completedBlock completedUIChangeBlock:(SDWebImageCompletionWithFinishedBlock)completedUIChangeBlock;

- (void)sns_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

/**
 获取view上某个点的色值
 */
- (UIColor *)colorWithAtPixel:(CGPoint)point;


@end
