//
//  NSObject+WLComponent.h
//  WalletBase
//
//  Created by leo on 2017/4/5.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WLComponent)

-(instancetype)initWithComponentInfo:(id)componentInfo;

@property (nonatomic, strong) id componentInfo;

@end
