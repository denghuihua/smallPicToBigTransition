//
//  ImageViewController.h
//  Img
//
//  Created by huihuadeng on 2018/8/30.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSImagePreviewModel.h"

@interface SNSImagePreviewViewController : UIViewController
@property (nonatomic, assign) CGRect            beforeImageViewFrame;   //图片的frame

- (void)setImageDataArr:(NSArray<SNSImagePreviewModel *> *)imgArr currentSelectIndex:(NSInteger)tapIndex;

@end
