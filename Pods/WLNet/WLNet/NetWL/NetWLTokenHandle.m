//
//  NetWLTokenHandle.m
//  WLNetServer
//
//  Created by leo on 2018/1/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "NetWLTokenHandle.h"
#import "NetWL.h"

@implementation AIWLTokenModel
IMP_SINGLETON
@end

@implementation NetWLTokenHandle

+(void)makeValidToken{
    [NetWLTokenHandle getServerTimeSuccess:^(NSTimeInterval time) {
        if (IsValidString(AIToken.rf_token) && AIToken.token_expire_at - time < 86400) {
            [NetWLTokenHandle refreshTokenSuccess:nil];
        }
    }];
}

+(void)getServerTimeSuccess:(void (^)(NSTimeInterval time))success{
    [[__NETWL configGetPathKey:@"wl_server_time" params:nil] requestCallBack:^(LRResponseModel *model) {
        if (model.success) {
            if (success) {
                success([model.data[@"current_server_time"] doubleValue]);
            }
        }
    }];
}

+(void)refreshTokenSuccess:(void (^)(void))success{
    [[__NETWL configGetPathKey:@"wl_refresh_token" params:@{@"rf_token" : AIToken.rf_token}] requestCallBack:^(LRResponseModel *model) {
        if (model.success) {
            [AIToken fillPropertyWithDictionary:model.data];
            if (success) {
                success();
            }
        }
    }];
}

@end
