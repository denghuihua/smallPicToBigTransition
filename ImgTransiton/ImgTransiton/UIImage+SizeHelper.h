//
//  UIImage+SizeHelper.h
//  sohuhy
//
//  Created by huihuadeng on 2018/9/3.
//  Copyright © 2018年 sohu. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#import <UIKit/UIKit.h>

@interface UIImage (SizeHelper)
+ (CGRect)scaleBigFrameWithSize:(CGSize)size;
@end
