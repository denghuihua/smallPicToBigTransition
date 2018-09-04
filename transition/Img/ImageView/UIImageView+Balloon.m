//
//  UIImageView+Balloon.m
//  SNSUIKit
//
//  Created by 张天雄 on 2018/8/6.
//  Copyright © 2018年 sohu. All rights reserved.
//

#import "UIImageView+Balloon.h"
#import "SNSColorConfig.h"

@implementation UIImageView (Balloon)

+(UIImageView *)balloonViewWithType:(SNSBalloonType)type andOrigin:(CGPoint)origin {
    UIImageView *imgView = [[UIImageView alloc] init];
    CGFloat width = 0;
    switch (type) {
        case Bal_1:
            width = 20;
            break;
        case Bal_2:
            width = 24;
            break;
        case Bal_3:
            width = 34;
            break;
        case Bal_4:
            width = 40;
            break;
        case Bal_5:
            width = 46;
            break;
        case Bal_6:
            width = 54;
        case Bal_7:
        case Bal_7_1:
            width = 68;
            break;
    }
    imgView.frame = CGRectMake(origin.x, origin.y, width, width);
    imgView.layer.cornerRadius = width/2.;
    imgView.clipsToBounds = YES;
    if (type == Bal_7_1) {
        imgView.layer.borderColor = Color_Blk_12.CGColor;
        imgView.layer.borderWidth = 2.;
    }
    return imgView;
}

+ (UIImageView *)balloonViewWithType:(SNSBalloonType)type {
    return [UIImageView balloonViewWithType:type andOrigin:CGPointMake(0, 0)];
}

+ (CGSize)balloonViewSizeWithType:(SNSBalloonType)type {
    CGFloat width;
    switch (type) {
        case Bal_1:
            width = 20;
            break;
        case Bal_2:
            width = 24;
            break;
        case Bal_3:
            width = 34;
            break;
        case Bal_4:
            width = 40;
            break;
        case Bal_5:
            width = 46;
            break;
        case Bal_6:
            width = 54;
        case Bal_7:
        case Bal_7_1:
            width = 68;
            break;
    }
    return CGSizeMake(width, width);
}



@end
