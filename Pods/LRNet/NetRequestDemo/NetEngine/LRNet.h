//
//  NetEngine.h
//  NetRequestDemo
//
//  Created by ileo on 16/3/28.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRNetModel.h"

typedef NS_ENUM(NSInteger, RequestLoad){
    RequestLoadNone            = 0,       //默认显示状态栏加载
    RequestLoadShowLoading     = 1 << 0,  //显示加载动画
    RequestLoadShowErrorTips   = 1 << 1,  //显示错误提示
    RequestLoadShowSuccessTips = 1 << 2,  //显示成功提示
    RequestLoadNoStatusLoading = 1 << 3   //不显示状态栏加载
};

#define __SELF [[[self class] alloc] init]

/**
 *  请求配置  －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
 */
@protocol LRNetConfig <NSObject>

@required

/**
 *  返回数据处理
 */
-(void)handleResponseInfoWithNetEngine:(id)engine;

@optional
/**
 *  请求数据处理
 */
-(void)handleRequestInfoWithNetEngine:(id)engine;

@end

/**
 *  请求过程相关tips操作   －－－－－－－－－－－－－－－－－－－－－－－－－
 */
@protocol LRNetTipsConfig <NSObject>

@optional

/**
 *  加载动画显示，没实现的话就没有任何提示
 */
-(void)showLoading;

/**
 *  加载动画消失，没实现的话就没有任何提示
 */
-(void)disappearLoading;

/**
 *  显示提示信息，没实现的话就没有任何提示
 */
-(void)showTipsWithNetEngine:(id)engine;

@end

/**
 *  请求回调  －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
 */
@protocol LRNetDelegate <NSObject>

@optional
/**
 *  请求数据处理前调用
 */
-(void)requestInfoWillHandleWithEngine:(id)engine;

/**
 *  请求开始时调用
 */
-(void)requestWillStartWithNetEngine:(id)engine;

/**
 *  请求成功时调用
 */
-(void)requestDidSuccessWithNetEngine:(id)engine;

/**
 *  请求失败时调用
 */
-(void)requestDidFailureWithNetEngine:(id)engine;

@end

@interface LRNet : NSObject <LRNetConfig>

@property (nonatomic, strong) LRResponseModel *responseModel;
@property (nonatomic, strong) LRRequestModel *requestModel;

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;//当发起请求后有值

/**
 *  设置超时时间
 */
-(id)resetTimeout:(NSTimeInterval)timeInterval;

/**
 *  设置回调
 */
-(id)setNetDelegate:(id<LRNetDelegate>)delegate;

#pragma mark - 请求提醒配置
/**
 *  配置定制 NetTipsConfig
 */
-(id)resetTipsConfig:(id<LRNetTipsConfig>)tipsConfig;

/**
 *  配置加载过程
 */
-(id)setLoadMode:(RequestLoad)mode;

/**
 *  配置请求参数
 */
-(id)configRequest:(LRRequestModel *)request;

#pragma mark - 发起请求
/**
 *  配置callback 发送请求
 */
-(void)requestCallBack:(void (^)(LRResponseModel *responseModel))callBack;

/**
 *  重新发起请求
 */
-(void)reRequest;

/**
 *  发起请求 
 */
-(void)requestOnly;


@end
