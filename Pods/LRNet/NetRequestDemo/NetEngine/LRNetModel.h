//
//  NetModel.h
//  NetRequestDemo
//
//  Created by leo on 2017/1/13.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "LRNetStatus.h"

typedef NS_ENUM(NSInteger, RESPONSE_TYPE){
    RESPONSE_SUCCESS,//返回成功
    RESPONSE_FAIL,//返回失败
    RESPONSE_LINK_FAIL//请求失败
};

@interface LRResponseModel : NSObject

@property (nonatomic, assign) BOOL success;//是否成功
@property (nonatomic, copy) NSString *message;//返回信息
@property (nonatomic, copy) NSString *code;//返回状态码
@property (nonatomic, copy) NSDictionary *data;//返回业务数据
@property (nonatomic, assign) RESPONSE_TYPE response;//返回结果类型

@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id responseObject;

@property (nonatomic, readonly) NSInteger statusCode;
@property (nonatomic, readonly) NSDictionary *allHeaderFields;

@end

typedef NS_ENUM(NSInteger, REQUEST_TYPE){
    POST,//post请求
    POST_FormData,//post表单请求
    POST_Body,//post body请求
    GET,//Get请求
    UN_REQUEST,//不发起网络请求，直接返回请求失败
    PUT,//put请求
    PUT_Body,//put body请求
    DELETE,//delete请求
};

@interface LRRequestModel : NSObject

@property (nonatomic, assign) REQUEST_TYPE type;//请求方法
@property (nonatomic, copy) NSString *path;//最终请求路径
@property (nonatomic, copy) NSDictionary *params;//最终请求参数

@property (nonatomic, copy) void (^FormData)(id<AFMultipartFormData> formData);
@property (nonatomic, copy) void (^UploadProgress)(NSProgress *uploadProgress);
@property (nonatomic, copy) NSString *body;

@property (nonatomic, assign) Net_Status netStatus;//请求网络状态

-(void)addParams:(NSDictionary *)params;

@end

