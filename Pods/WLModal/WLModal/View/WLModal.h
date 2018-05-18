//
//  WLModal.h
//  WLModalComponent
//
//  Created by 刘光强 on 2018/5/8.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLModal : UIView

// 提示视图
@property (nonatomic, strong) UIView *dialogView;
// 提示视图的子视图（自定义）
@property (nonatomic, strong) UIView *containerView;
// 按钮标题数组
@property (nonatomic, copy) NSArray *buttonTitles;
// 按钮点击事件
@property (nonatomic, copy) void (^onButtonTouchUpInside)(WLModal *alertView, NSInteger buttonIndex);

- (id)init;

- (void)show;

- (void)close;

- (void)addContentView:(UIView *)view;

// 设置按钮点击事件
- (void)setOnButtonTouchUpInside:(void (^)(WLModal *alertView, NSInteger buttonIndex))onButtonTouchUpInside;

// 设备旋转，横向/竖向改变
- (void)deviceOrientationDidChange:(NSNotification *)notification;

- (void)dealloc;
@end
