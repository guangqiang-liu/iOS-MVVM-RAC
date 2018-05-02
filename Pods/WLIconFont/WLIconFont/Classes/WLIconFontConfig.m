//
//  WLIconFontConfig.m
//  IconFont
//
//  Created by 刘光强 on 2018/2/26.
//  Copyright © 2018年 刘光强. All rights reserved.
//

#import "WLIconFontConfig.h"

@implementation WLIconFontConfig

+ (NSDictionary *)glyphMap {
    return @{
             @"keyboard_o"  :@"\U0000e639", // 键盘
             @"add_o"       :@"\U0000e638", // 添加
             @"play_o"      :@"\U0000e637", // 播放
             @"person_s"    :@"\U0000e636", // 人物
             @"record_o"    :@"\U0000e635", // 录像
             @"card_o"      :@"\U0000e6b2", // 卡券
             @"wallet_o"    :@"\U0000e633", // 红包
             };
}

+ (NSString *)fontName {
    return @"iconfont";
}

@end
