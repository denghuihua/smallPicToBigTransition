//
//  SNSColorConfig.h
//  SNSUIKit
//
//  Created by mojue on 2018/7/25.
//  Copyright © 2018 sohu. All rights reserved.
//

#ifndef SNSColorConfig_h
#define SNSColorConfig_h

#define UIColorFromRGB(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0f \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0f \
alpha:alphaValue]

#define SNSColorAplha(color, alpha) [color colorWithAlphaComponent:alpha]

// 宏定义直接获取 UIColor
#define Color_Ylw_1  UIColorFromRGB(0xFDD536, 1.0f)
#define Color_Ylw_2  UIColorFromRGB(0xFFBC2F, 1.0f)

#define Color_Red_1  UIColorFromRGB(0xEE2F10, 1.0f)
#define Color_Red_2  UIColorFromRGB(0xED5D49, 1.0f)

#define Color_Blu_1  UIColorFromRGB(0x3D5699, 1.0f)
#define Color_Blu_2  UIColorFromRGB(0x3B87F9, 1.0f)

#define Color_Blk_1  UIColorFromRGB(0x000000, 1.0f)
#define Color_Blk_2  UIColorFromRGB(0x454545, 1.0f)
#define Color_Blk_3  UIColorFromRGB(0x737781, 1.0f)
#define Color_Blk_4  UIColorFromRGB(0x929292, 1.0f)
#define Color_Blk_5  UIColorFromRGB(0xB1B1B1, 1.0f)
#define Color_Blk_6  UIColorFromRGB(0xDADADA, 1.0f)
#define Color_Blk_7  UIColorFromRGB(0xE4E4E4, 1.0f)
#define Color_Blk_8  UIColorFromRGB(0xE7E8E9, 1.0f)
#define Color_Blk_9  UIColorFromRGB(0xF1F1F1, 1.0f)
#define Color_Blk_10 UIColorFromRGB(0xF2F2F2, 1.0f)
#define Color_Blk_11 UIColorFromRGB(0xF9F9F9, 1.0f)
#define Color_Blk_12 UIColorFromRGB(0xFFFFFF, 1.0f)


#endif /* SNSColorConfig_h */
