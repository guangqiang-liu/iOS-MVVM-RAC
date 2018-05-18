//
//  WLMPackageSelectVM.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMPackageSelectVM.h"

@interface WLMPackageSelectVM()

@property (nonatomic, strong, readwrite) RACCommand *submitCmd;
@end

@implementation WLMPackageSelectVM

- (void)initialize {
    [super initialize];
    
    self.submitCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
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
