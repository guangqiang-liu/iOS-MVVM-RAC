//
//  NetWLTokenHandle.h
//  WLNetServer
//
//  Created by leo on 2018/1/15.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalletBase.h"
#import "LRAIModel.h"

@interface AIWLTokenModel : LRAIModel

DEF_SINGLETON
@property (nonatomic, copy) NSString *ac_token;
@property (nonatomic, copy) NSString *rf_token;
@property (nonatomic, assign) NSTimeInterval token_expire_at;

@end

#define AIToken [AIWLTokenModel sharedInstance]

@interface NetWLTokenHandle : NSObject

+(void)makeValidToken;
+(void)refreshTokenSuccess:(void (^)(void))success;

@end
