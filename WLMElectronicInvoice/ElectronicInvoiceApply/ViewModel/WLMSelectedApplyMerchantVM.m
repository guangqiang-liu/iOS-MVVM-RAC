//
//  WLMSelectedApplyMerchantVM.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMSelectedApplyMerchantVM.h"
#import "WLMSelectedApplyMerchantModel.h"

@interface WLMSelectedApplyMerchantVM()

@property (nonatomic, strong, readwrite) RACCommand *merchantListCmd;
@property (nonatomic, strong, readwrite) WLMEInvoiceIntroduceVM *introduceViewModel;
@property (nonatomic, copy, readwrite) NSArray *dataArray;

@end

@implementation WLMSelectedApplyMerchantVM

- (instancetype)initWithService:(id<WLBViewModelServiceImpProtocol>)service params:(NSDictionary *)params {
    self = [super initWithService:service params:params];
    if (self) {
        
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.introduceViewModel = [[WLMEInvoiceIntroduceVM alloc] initWithService:self.service params:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 10; i ++) {
            WLMSelectedApplyMerchantModel *model = [[WLMSelectedApplyMerchantModel alloc] init];
            model.merchantName = @"上海小南国(南京店)";
            model.merchantAddress = @"上海市-上海市-黄浦区";
            model.merchantState = WLMerchantStateOpening;
            [tempArr addObject:model];
        }
        self.dataArray = tempArr;
    });
    
    _merchantListCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSDictionary *dic = @{};
            NSArray *dataArr = dic[@"data"];
            [subscriber sendNext:dataArr];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                // 信号被取消后的处理，这里可以cancle task
                NSLog(@"信号被取消了！");
            }];
        }];
    }];
}

@end
