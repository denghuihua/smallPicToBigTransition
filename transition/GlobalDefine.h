//
//  GlobalDefine.h
//  MDM3
//
//  Created by betty on 14-7-30.
//  Copyright (c) 2014年 pekall.com. All rights reserved.
//
#ifndef GloablDefine_h
#define GloablDefine_h

/********************************************************/

#define AppStoreURLHttps ([[[UIDevice currentDevice]systemVersion] floatValue] >= 11.0 ? @"https://itunes.apple.com/cn/app/sou-hu-mo-ke/id1079319250?mt=8" : @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1079319250&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")
#define AppStoreURLItms @"itms-apps://itunes.apple.com/cn/app/sou-hu-mo-ke-you-zhi-tu-wen/id1079319250?mt=8"

#define IPHONE_4_AND_4S_DEVICE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE_5_DEVICE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPad_DEVICE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IPHONE_6_PLUS_DEVICE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE_6_DEVICE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS_7 [[[UIDevice currentDevice]systemVersion]floatValue] >= 7 && [[[UIDevice currentDevice]systemVersion]floatValue] < 8.0
#define IOS_8 [[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0&& [[[UIDevice currentDevice]systemVersion]floatValue] < 9.0
#define IOS_9 [[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0&& [[[UIDevice currentDevice]systemVersion]floatValue] < 10.0
#define IOS_10 [[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0&& [[[UIDevice currentDevice]systemVersion]floatValue] < 11.0
#define IOS_11 [[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0&& [[[UIDevice currentDevice]systemVersion]floatValue] < 12.0
#define IOS_6 ([[[UIDevice currentDevice]systemVersion]floatValue] < 6.0)

#define iOS_(version) ([[UIDevice currentDevice].systemVersion compare:@"(version)" options:NSNumericSearch] != NSOrderedAscending)

#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//kAPP_STATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height，包含热点栏（如有）高度，标准高度为20pt，当有个人热点连接时，高度为40pt。
//iOS11添加安全区域概念
//#define SAFE_AREA_INSETS ({[[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0 ? [UIApplication sharedApplication].keyWindow.safeAreaInsets : UIEdgeInsetsZero;})
#define SAFE_AREA_INSETS ({\
    UIEdgeInsets edgeInsets;\
    if (@available(iOS 11.0, *)) {\
        edgeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;\
    } else {\
        edgeInsets = UIEdgeInsetsZero;\
    }\
    (edgeInsets);\
})
#define TOP_SAFE_AREA (SAFE_AREA_INSETS.top)
#define TOP_ACTIVE_SAFE_AREA (MAX(TOP_SAFE_AREA-20, 0))
#define BOTTOM_SAFE_AREA SAFE_AREA_INSETS.bottom

//APP_STATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height，包含热点栏（如有）高度，标准高度为20pt，当有个人热点连接时，高度为40pt。
//SYSTEM_VERSION ≥ 7.0，UIViewController.view.bounds.height包含标准系统状态栏高度和导航栏高度，但不包含热点栏（如果有）。
// 标准系统状态栏高度
#define SYS_STATUSBAR_HEIGHT                (20+TOP_ACTIVE_SAFE_AREA)
// 热点栏高度
#define HOTSPOT_STATUSBAR_HEIGHT            20
// 导航栏（UINavigationController.UINavigationBar）高度
#define NAVIGATIONBAR_HEIGHT                44
// kAPP_STATUSBAR_HEIGHT=SYS_STATUSBAR_HEIGHT+[HOTSPOT_STATUSBAR_HEIGHT]
#define kAPP_STATUSBAR_HEIGHT                (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
// 根据kAPP_STATUSBAR_HEIGHT判断是否存在热点栏
#define IS_HOTSPOT_CONNECTED                (kAPP_STATUSBAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)
// 无热点栏时，标准系统状态栏高度+导航栏高度(iPhone X状态栏变为44)
#define NORMAL_STATUS_AND_NAV_BAR_HEIGHT    (SYS_STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT)
// 实时系统状态栏高度+导航栏高度，如有热点栏，其高度包含在kAPP_STATUSBAR_HEIGHT中。
#define STATUS_AND_NAV_BAR_HEIGHT                    (kAPP_STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT)


#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define kScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define TouchHeightDefault                  44
#define TouchHeightSmall                    32

#define ViewWidth(v)                        v.frame.size.width
//#define BaseViewHeight                      self.view.frame.size.height

#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y

#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height

#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)

#define printRect(rect)                        NSLog(@" %f;y:%f;width:%f;height:%f;",RectX(rect),RectY(rect),RectWidth(rect),RectHeight(rect))
#define printViewFrame(v)                        NSLog(@" view:%@--x:%f;y:%f;width:%f;height:%f;",v,ViewX(v),ViewY(v),ViewWidth(v),ViewHeight(v))


#define APPCurrentVersion  [[[UIDevice currentDevice] systemVersion] floatValue]
#define print_isMainThread NSLog(@"isMainThead---->%d",[NSThread isMainThread]);
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf) __strong __typeof(&*self)strongSelf = self;

#define PROPERTY_STRONG @property (nonatomic,strong)
#define PROPERTY_WEAK @property (nonatomic,weak)
#define PROPERTY_ASSIGN @property (nonatomic,assign)

#define FileExistAtPath(path) [[NSFileManager defaultManager] fileExistsAtPath:path]
#define APPDelagate (AppDelegate *) [UIApplication sharedApplication].delegate

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

//#ifndef dispatch_main_sync_safe
//#define dispatch_main_sync_safe(block)\
//if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
//block();\
//} else {\
//dispatch_sync(dispatch_get_main_queue(), block);\
//}
//#endif

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#endif /** GloablDefine_h **/
