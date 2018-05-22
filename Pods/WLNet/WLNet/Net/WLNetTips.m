//
//  WLNetTips.m
//  WLNetServer
//
//  Created by leo on 2017/6/7.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "WLNetTips.h"
#import "WLAlert.h"


@implementation WLNetTips
IMP_SINGLETON
-(void)showLoading{
    [WLAlert showWaiting];
}

-(void)disappearLoading{
    [WLAlert dismissWaiting];
}

-(void)showTipsWithNetEngine:(LRNet *)engine{
    NSString *tip = engine.responseModel.message;
    if (IsValidString(tip)) {
        [WLAlert showToastTextTips:tip];
    }
}

@end
