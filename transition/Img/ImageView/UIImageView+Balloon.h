//
//  UIImageView+Balloon.h
//  SNSUIKit
//
//  Created by 张天雄 on 2018/8/6.
//  Copyright © 2018年 sohu. All rights reserved.
//


/*
    根据头像type获取头像
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SNSBalloonType){
    Bal_1,
    Bal_2,
    Bal_3,
    Bal_4,
    Bal_5,
    Bal_6,
    Bal_7,
    Bal_7_1,
};

@interface UIImageView (Balloon)


/**
 根据坐标和type生成对应的头像类型

 @param type 头像type
 @param origin 坐标
 @return 生成的imageview
 */
+ (UIImageView *)balloonViewWithType:(SNSBalloonType)type andOrigin:(CGPoint)origin;


/**
 根据type返回头像，坐标默认为（0，0）

 @param type SNSBalloonType
 @return 对应的imageView；
 */
+ (UIImageView *)balloonViewWithType:(SNSBalloonType)type;


/**
 根据type返回size

 @param type SNSBalloonType
 @return balloon的size
 */
+ (CGSize)balloonViewSizeWithType:(SNSBalloonType)type;

@end
