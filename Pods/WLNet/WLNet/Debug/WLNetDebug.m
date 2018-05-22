//
//  WLNetDebug.m
//  WLNetServer
//
//  Created by 于云飞 on 17/3/30.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "WLNetDebug.h"
#import <CoreMotion/CoreMotion.h>
#import "WalletBase.h"
#import "WLNetHostViewController.h"
#import "WLNetServer.h"

@interface WLNetDebug ()

@property (nonatomic, strong) CMMotionManager *motionManager;
DEF_SINGLETON

@end

@implementation WLNetDebug

IMP_SINGLETON

+(void)debug {
    [[WLNetDebug sharedInstance] startAccelerometer];
    NSString *host = NSUserDefaultsGet(URL_HOST_SELECTED);
    if (IsValidString(host)) {
        NSAssert([WLNetServer wlHost], @"未设置host");
        [WLNetServer setCustomWLHost:host];
    }
}

- (CMMotionManager *)motionManager {
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = .1;//加速仪更新频率，以秒为单位
    }
    return _motionManager;
}

-(void)startAccelerometer
{
    //以push的方式更新并在block中接收加速度
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if (error) {
                                                     NSLog(@"motion error:%@",error);
                                                 }
                                             }];
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    //综合3个方向的加速度
    double accelerameter =sqrt( pow( acceleration.x , 2 ) + pow( acceleration.y , 2 )
                               + pow( acceleration.z , 2) );
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    if (accelerameter>2.3f) {  
        //立即停止更新加速仪（很重要！）  
        [self.motionManager stopAccelerometerUpdates];
        
        dispatch_async(dispatch_get_main_queue(), ^{  
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            UIViewController *presentedVC = [UIViewController currentViewController];
            __weak typeof(self) weakSelf = self;
            if (![presentedVC isKindOfClass:[WLNetHostViewController class]]) {
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[WLNetHostViewController new]];
                [presentedVC presentViewController:navi animated:YES completion:^{[weakSelf startAccelerometer];} willDismissCallback:^(BOOL success, id info) {
                    [weakSelf startAccelerometer];
                } didDismissCallback:^(BOOL success, id info) {
                }];
            }
        });
    }      
}

@end
