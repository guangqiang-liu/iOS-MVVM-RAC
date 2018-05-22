//
//  NSObject+WLComponent.m
//  WalletBase
//
//  Created by leo on 2017/4/5.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import "NSObject+WLComponent.h"
#import <objc/runtime.h>

@implementation NSObject (WLComponent)

-(instancetype)initWithComponentInfo:(id)componentInfo{
    self = [self init];
    if (self) {
        self.componentInfo = componentInfo;
    }
    return self;
}

static char kComponentInfo;

-(void)setComponentInfo:(id)componentInfo{
    objc_setAssociatedObject(self, &kComponentInfo, componentInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)componentInfo{
    return objc_getAssociatedObject(self, &kComponentInfo);
}

@end
