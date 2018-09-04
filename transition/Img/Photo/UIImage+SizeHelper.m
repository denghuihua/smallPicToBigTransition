//
//  UIImage+SizeHelper.m
//  sohuhy
//
//  Created by huihuadeng on 2018/9/3.
//  Copyright © 2018年 sohu. All rights reserved.
//

#import "UIImage+SizeHelper.h"
#import "SNSUIConstants.h"

@implementation UIImage (SizeHelper)

+ (CGRect)scaleBigFrameWithSize:(CGSize)size
{
    if (size.height/size.width > ScreenHeight/ScreenWidth) {
        return CGRectMake(0, 0, ScreenWidth, ScreenWidth * size.height/size.width);
    }
    
    float scaleX = ScreenWidth/size.width;
    float scaleY = ScreenHeight/size.height;
    if (scaleX > scaleY){
        float imgViewWidth = size.width * scaleY;
        return (CGRect){(ScreenWidth/2) - (imgViewWidth/2),0,imgViewWidth,ScreenHeight};
    } else {
        float imgViewHeight = size.height * scaleX;
        return (CGRect){0,(ScreenHeight/2) - (imgViewHeight/2),ScreenWidth,imgViewHeight};
    }
}

@end
