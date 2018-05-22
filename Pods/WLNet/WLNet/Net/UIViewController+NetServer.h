//
//  UIViewController+NetServer.h
//  WLNetServer
//
//  Created by leo on 2017/12/27.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLNetServer.h"

@interface UIViewController (NetServer)

+(void)configNetServer;

-(void)addNet:(LRNet *)net;
-(void)removeNet:(LRNet *)net;
-(void)cancelAllNet;

@end


