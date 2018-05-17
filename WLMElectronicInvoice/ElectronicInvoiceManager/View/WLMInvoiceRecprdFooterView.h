//
//  WLMInvoiceRecprdFooterView.h
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/11.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol invoiceRecordFilterDelegate <NSObject>
@optional
- (void)didRecordFilterButton:(UIButton *)button;
@end

@interface WLMInvoiceRecprdFooterView : UIView

-(instancetype)initWithFootView;

@property(nonatomic, weak) id <invoiceRecordFilterDelegate> delegate;

@end
