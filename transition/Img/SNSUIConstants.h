//
//  SNSUIConstants.h
//  SNSUIKit
//
//  Created by jinkai on 2018/7/25.
//  Copyright © 2018年 sohu. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// iPhone X
#define SNS_iPhoneX (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)

// Status bar height.
#define  SNS_StatusBarHeight      (SNS_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  SNS_NavigationBarHeight  44.f

// Tabbar height.
#define  SNS_TabbarHeight         (SNS_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  SNS_TabbarSafeBottomMargin         (SNS_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  SNS_StatusBarAndNavigationBarHeight  (SNS_iPhoneX ? 88.f : 64.f)

#define SNS_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

// 视频相关宏
#define kSnsVideoCacheMaxSize @"kSnsVideoCacheMaxSize" 
#define SnsVideoUploadFrom @"301"
#define SnsVideoMediaPoid @"30"
#define SnsVideoMediaChanneled @"1300030007"
#define kSnsPhotoRecorderFlashMode @"SnsCameraFlashMode"
#define kSnsVideoFisrtPlayInNonWifi @"SnsVideoFisrtPlayInNonWifi"

#define kSNSCloseCustomAlertNotification @"SNSCloseCustomAlertNotification"
