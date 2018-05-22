//
//  UIViewController+NetServer.m
//  WLNetServer
//
//  Created by leo on 2017/12/27.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "UIViewController+NetServer.h"
#import <objc/runtime.h>
#import "NSObject+Method.h"
#import "WLNetServer.h"

@interface UIViewController ()

@property (nonatomic, copy) NSArray<LRNet *> *wlNets;

@end

@implementation UIViewController (NetServer)

+(void)configNetServer{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController configSimple];
        [UIViewController exchangeSEL:@selector(viewDidDisappearForever) withSEL:@selector(NetServer_viewDidDisappearForever)];
    });
}

-(void)NetServer_viewDidDisappearForever{
    [self cancelAllNet];
    [self NetServer_viewDidDisappearForever];
}

static char kWLNets;

-(void)setWlNets:(NSArray<LRNet *> *)wlNets{
    objc_setAssociatedObject(self, &kWLNets, wlNets, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSArray<LRNet *> *)wlNets{
    return objc_getAssociatedObject(self, &kWLNets);
}

-(void)addNet:(LRNet *)net{
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.wlNets];
    [tmp addObject:net];
    self.wlNets = [tmp copy];
}

-(void)removeNet:(LRNet *)net{
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.wlNets];
    [tmp removeObject:net];
    self.wlNets = [tmp copy];
}

-(void)cancelAllNet{
    [self.wlNets enumerateObjectsUsingBlock:^(LRNet * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.sessionDataTask cancel];
    }];
    self.wlNets = @[];
}

@end



