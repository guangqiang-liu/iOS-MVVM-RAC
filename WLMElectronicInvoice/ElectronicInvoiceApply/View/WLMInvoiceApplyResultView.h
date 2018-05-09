//
//  WLMInvoiceApplyResultView.h
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/9.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ResultBlock)(void);

@interface WLMInvoiceApplyResultView : UIView

@property (nonatomic, copy) ResultBlock resultBlock;
@end
