//
//  WLBViewControllerProtocol.h
//  WLMScanOrder
//
//  Created by 刘光强 on 2018/4/13.
//  Copyright © 2018年 WLM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLBViewModel;

@protocol WLBViewControllerProtocol <NSObject>

@optional
@property (nonatomic, strong, readonly) WLBViewModel *viewModel;

- (instancetype)initWithViewModel:(WLBViewModel *)viewModel;

- (void)bindViewModel;

- (void)renderViews;

@end
