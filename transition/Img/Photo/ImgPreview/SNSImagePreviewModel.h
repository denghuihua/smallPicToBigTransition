//
//  SNSImagePreviewModel.h
//  Img
//
//  Created by huihuadeng on 2018/8/31.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SNSImagePreviewModel : NSObject

@property(nonatomic, copy) NSString *bigImgUrl;
@property(nonatomic, copy) NSString *originSmallImgUrl;//原图缩略图
@property(nonatomic, copy) NSString *smallImgUrl;
@property(nonatomic, assign)CGRect smallImgFrame;
@property(nonatomic, assign)CGSize imageSize;
@property(nonatomic, assign)CGSize clipImageSize; //原图剪裁后的小图 宽 高

@end
