//
//  NetBaseWL.h
//  WLNetServer
//
//  Created by leo on 2017/3/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "LRNet.h"
#import "NetWLTokenHandle.h"

#define __NETWL [[NetWL alloc] init]

@interface NetWL : LRNet

+(void)configInitInfo:(void (^)(LRNet *net))config;//
+(void)updateToken:(NSDictionary *)info;
+(void)clearToken;

-(NSString *)host;
-(NSString *)pathWithKey:(NSString *)key;

//get请求
-(id)configGetPathKey:(NSString *)key params:(NSDictionary *)params;
//post请求
-(id)configPostPathKey:(NSString *)key postParams:(NSDictionary *)params;
//post请求  部分参数需拼在请求路径里
-(id)configPostPathKey:(NSString *)key getParams:(NSDictionary *)getParams postParams:(NSDictionary *)postParams;

@end

@interface NetWLReqModel : LRRequestModel

@property (nonatomic, copy) NSDictionary *getParams;
@property (nonatomic, copy) NSDictionary *postParams;

@end

