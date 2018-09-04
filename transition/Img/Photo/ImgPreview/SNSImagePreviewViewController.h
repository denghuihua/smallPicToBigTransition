//
//  ImageViewController.h
//  Img
//
//  Created by huihuadeng on 2018/8/30.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSImagePreviewModel.h"

/*
 不支持 本地相册图片 缓存策略  
 
 最大放大限制 未实现
 */
@interface SNSImagePreviewViewController : UIViewController

- (void)setImageDataArr:(NSArray<SNSImagePreviewModel *> *)imgArr currentSelectIndex:(NSInteger)tapIndex;

@end
