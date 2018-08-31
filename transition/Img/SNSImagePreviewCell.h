//
//  SNSImagePreviewCell.h
//  Img
//
//  Created by huihuadeng on 2018/8/31.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^Hander)(id);

@interface SNSImagePreviewCell : UICollectionViewCell

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic,copy) Hander tapHander;

@end
