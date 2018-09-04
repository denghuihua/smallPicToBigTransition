//
//  UIImageView+Proces.m
//  SNSUIKit
//
//  Created by wuyy on 2018/7/31.
//  Copyright © 2018年 sohu. All rights reserved.
//

#import "UIImageView+Proces.h"
#import "UIImage+Proces.h"

@implementation UIImageView (Proces)

- (void)sns_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sns_setImageWithURL:url placeholderImage:placeholder completed:nil completedUIChangeBlock:nil];
}

- (void)sns_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionWithFinishedBlock)completedBlock completedUIChangeBlock:(SDWebImageCompletionWithFinishedBlock)completedUIChangeBlock
{
    NSString *urlString = url.absoluteString;
    NSString *cacheKey = [self.layer valueForKey:@"didShowKey"];
    if (![cacheKey isEqualToString:urlString]) {
        self.image = placeholder;
    }
    
    [self.layer setValue:urlString forKey:@"willShowKey"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
        if (cacheImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([urlString isEqualToString:[self.layer valueForKey:@"willShowKey"]]){
                    self.image = cacheImage;
                    [self.layer setValue:urlString forKey:@"didShowKey"];
                }
            });
            if (completedBlock) {
                completedBlock(cacheImage,nil,SDImageCacheTypeDisk,YES,[NSURL URLWithString:urlString]);
            }
            if (completedUIChangeBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([urlString isEqualToString:[self.layer valueForKey:@"willShowKey"]]) {
                        completedUIChangeBlock(cacheImage,nil,SDImageCacheTypeDisk,YES,[NSURL URLWithString:urlString]);
                    }
                });
            }
        } else {
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([[self.layer valueForKey:@"willShowKey"] isEqualToString:[imageURL absoluteString]]) {
                            self.image = image;
                            CATransition *transition = [CATransition animation];
                            transition.duration = 0.15;
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                            transition.type = kCATransitionFade;
                            [self.layer addAnimation:transition forKey:@"contents"];
                            [self.layer setValue:urlString forKey:@"didShowKey"];
                        }
                    });
                }
                if (completedBlock) {
                    completedBlock(image,error,cacheType,finished,imageURL);
                }
                if (completedUIChangeBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([[self.layer valueForKey:@"willShowKey"] isEqualToString:[imageURL absoluteString]]) {
                            completedUIChangeBlock(image,nil,SDImageCacheTypeDisk,YES,[NSURL URLWithString:urlString]);
                        }
                    });
                }
            }];
        }
    });
}

- (void)sns_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    NSString *urlString = url.absoluteString;
    NSString *cacheKey = [self.layer valueForKey:@"didShowKey"];
    if (![cacheKey isEqualToString:urlString] && placeholder) {
        self.image = placeholder;
    }
    
    [self.layer setValue:urlString forKey:@"willShowKey"];
    CGFloat width = self.frame.size.width;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *avatar = [NSString stringWithFormat:@"%@-group",urlString];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:avatar];
        if (!cacheImage) {
            cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
            if (cacheImage) {
                cacheImage = [cacheImage imageAddCornerWithRadius:width / 2 withSize:CGSizeMake(width,width)];
            }
        }
        if (cacheImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([urlString isEqualToString:[self.layer valueForKey:@"willShowKey"]]){
                    self.image = cacheImage;
                    [self.layer setValue:urlString forKey:@"didShowKey"];
                }
            });
        } else {
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    UIImage *circleImage = [image imageAddCornerWithRadius:width/2 withSize:CGSizeMake(width,width)];
                    [[SDImageCache sharedImageCache] storeImage:circleImage forKey:[NSString stringWithFormat:@"%@-group",imageURL.absoluteString]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([[self.layer valueForKey:@"willShowKey"] isEqualToString:[imageURL absoluteString]]) {
                            self.image = circleImage;
                            CATransition *transition = [CATransition animation];
                            transition.duration = 0.15;
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                            transition.type = kCATransitionFade;
                            [self.layer addAnimation:transition forKey:@"contents"];
                            [self.layer setValue:urlString forKey:@"didShowKey"];
                        }
                    });
                }
            }];
        }
    });
}

- (UIColor *)colorWithAtPixel:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}
@end
