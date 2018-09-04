//
//  UIImage+Proces.h
//  SNSUIKit
//
//  Created by wuyy on 2018/7/31.
//  Copyright © 2018年 sohu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Proces)

#pragma mark - Alpha 相关
/**
 图片是否有Alpha通道
 */
- (BOOL)hasAlphaChannel;

/**
 获取具有Alpha通道的图片，若当前图片具有，直接返回；若没有，给它添加Alpha通道
 */
- (UIImage *)imageOfAlphaChannel;

/**
 设置图片的Alpha
 */
- (UIImage *)imageWithApplyImageAlpha:(CGFloat)alpha;

#pragma mark - Size 相关
/**
 重置图片尺寸
 */
- (UIImage *)rescaleImageToSize:(CGSize)size;

/**
 判断是不是长图
 */
- (BOOL)isLongImage;

/**
 判断是不是超宽图
 */
- (BOOL)isUltraWideImage;


#pragma mark - 图片压缩 相关
- (UIImage *)compressImage;


#pragma mark - Color 相关
/**
 给图片添加背景色
 */
- (UIImage *)imageWithAddBackGroundColor:(UIColor *)color;

/**
 颜色转图片
 @param color 自定义的颜色
 @param size 默认 (1,1)， 可自定义
 */
+ (UIImage *)imageFromColor:(UIColor *)color withImageSize:(CGSize)size;
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 给图片添加圆环
 @param borderWidth 圆环宽度
 @param borderColor 圆环颜色
 */
- (UIImage *)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 给图片填充颜色，这个方法不会改变图片的Alpha通道
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

#pragma mark - 拍照 相关
/**
 图片方向问题，一般拍摄时会用
 */
- (UIImage *)fixOrientation;

/**
 裁剪图片
 */
- (UIImage *)croppedImage:(CGRect)bounds;

/**
 调整图片
 */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

#pragma mark - 其他
/**
 高性能给图片添加圆角
 */
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius withSize:(CGSize)size;

/**
 根据URL生成二维码，生产的图片是正方形
 @param url 扫码后链接
 @param minSide 图片边长
 */
+ (UIImage *)imageQRcodeWithUrl:(NSString *)url withImageMinSide:(CGFloat)minSide;

/**
 旋转图片，顺时针
 @param degrees 旋转角度（eg:顺时针旋转40°的话就传40）
 */
- (UIImage *)rotatedByDegrees:(CGFloat)degrees;

/**
 高斯模糊效果
 @param blur 模糊度 0 ~ 1
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;

/**
 黑白图
 */
- (UIImage*)grayImage;

/**
 获取启动图
 */
+ (UIImage *)launchImage;

@end
