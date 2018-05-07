//
//  WLForm.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WLFormSectionViewModel, WLFormItemViewModel;

static NSString *const kLeftKey = @"kLeftKey";          // 标记左侧内容
static NSString *const kRightKey = @"kRightKey";        // 标记右侧内容
static NSString *const kFlagKey = @"kFlagKey";          // 用于标记是否有箭头
static NSString *const kDisableKey = @"kDisableKey";    // 用于标记是否禁用 textField
static NSString *const kPlaceholder = @"kPlaceholder";  // 标记textField placeholder

@interface WLForm : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<WLFormSectionViewModel *> *sectionArray;
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) void(^disableBlock)(WLForm *form);

- (void)addSection:(WLFormSectionViewModel *)section;

- (void)removeSection:(WLFormSectionViewModel *)section;

- (void)reformResRet:(id)res;

- (id)fetchRequestParams;

- (NSDictionary *)validateItems;

- (WLFormItemViewModel *)itemWithIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathWithItem:(WLFormItemViewModel *) item;

@end
