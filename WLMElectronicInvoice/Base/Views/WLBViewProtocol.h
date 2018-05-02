//
//  WLBViewProtocol.h
//  WLMScanOrder
//
//  Created by 刘光强 on 2018/4/12.
//  Copyright © 2018年 WLM. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WLBViewProtocol <NSObject>

@optional

@property (nonatomic, strong, readonly) WLBViewModel *viewModel;

- (instancetype)initWithViewModel:(WLBViewModel *)viewModel;

- (void)renderViews;
- (void)bindViewModel;

@end
