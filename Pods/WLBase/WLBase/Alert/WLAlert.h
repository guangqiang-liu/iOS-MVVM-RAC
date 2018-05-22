//
//  AlertMgr.h
//  WalletMerchant
//
//  Created by leo on 2017/2/17.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Toast_Status){
    Toast_Normal,
    Toast_Success,
    Toast_Fail
};

@protocol WLAlertAnimation <NSObject>

@optional
+(UIView *)waitingAnimation;
+(UIView *)toastViewWithTips:(NSString *)tips status:(Toast_Status)status;

@end


@interface WLAlert : NSObject

+(void)configAnimation:(Class<WLAlertAnimation>)animation;

//加载动画
+(void)showWaiting;
+(void)dismissWaiting;

//弹出提示框  tips可以是NSString:单个提示 NSArray:可换行提示，每个元素一行
+(void)showToastTextTips:(NSString *)tips;
+(void)showToastTextTips:(NSString *)tips time:(NSInteger)time;
+(void)showToastTextTips:(NSString *)tips status:(Toast_Status)status time:(NSInteger)time;

//弹出定制View
+(void)showCustomView:(UIView *)view;//有透明背景
+(void)showOnlyCustomView:(UIView *)view;//仅仅显示定制View
+(void)dismissCustomView;




@end
