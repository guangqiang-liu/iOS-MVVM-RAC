//
//  WLMFillTaxationInfoVM.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMFillTaxationInfoVM.h"

@interface WLMFillTaxationInfoVM()

@property (nonatomic, strong, readwrite) WLMMoreTaxationInfoVM *moreInfoViewModel;
@property (nonatomic, strong, readwrite) RACCommand *submitFormCmd;

@end

@implementation WLMFillTaxationInfoVM

- (instancetype)initWithService:(id<WLBViewModelServiceImpProtocol>)service params:(NSDictionary *)params {
    self = [super initWithService:service params:params];
    if (self) {
    }
    return self;
}

- (void)initialize {
    [super initialize];
    self.moreInfoViewModel = [[WLMMoreTaxationInfoVM alloc] initWithService:self.service params:nil];
    
    self.submitFormCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSDictionary *dic = @{@"data":@"xx"};
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
