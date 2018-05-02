//
//  WLBaseView.h
//  WLBaseView_Example
//
//  Created by 刘光强 on 2018/3/15.
//  Copyright © 2018年 guangqiang-liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLBaseView : UIView

/**
 *  缩进边界
 */
@property (nonatomic) UIEdgeInsets viewEdgeInsets;

/**
 * 子类使用的模型对象
 */
@property (nonatomic, strong) id cellModel;

+ (instancetype) loadXib;

-(void)renderViews;

@end
