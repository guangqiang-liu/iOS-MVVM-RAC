//
//  WLMSelectedApplyMerchantModel.h
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/17.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WLMerchantState) {
    WLMerchantStateNotOpen, // 未开通
    WLMerchantStateOpening, // 开通中
    WLMerchantStateTesting, // 测试上线中
    WLMerchantStateOpened // 已开通
};

@interface WLMSelectedApplyMerchantModel : WLBaseModel

@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, copy) NSString *merchantAddress;
@property (nonatomic, assign) WLMerchantState merchantState;
@end
