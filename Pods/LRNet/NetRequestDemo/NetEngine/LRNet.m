//
//  NetEngine.m
//  NetRequestDemo
//
//  Created by ileo on 16/3/28.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "LRNet.h"
#import "LRNetStatus.h"

@interface LRNetHandle : NSObject
+(instancetype)sharedInstance;
@property (nonatomic, strong) NSMutableArray<LRNet *> *nets;
+(void)keepNet:(LRNet *)net;
+(void)freeNet:(LRNet *)net;
@end
@implementation LRNetHandle
+(instancetype)sharedInstance{
    static id sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}
-(NSMutableArray *)nets{
    if (!_nets) {
        _nets = [NSMutableArray arrayWithCapacity:10];
    }
    return _nets;
}
+(void)keepNet:(LRNet *)net{
    if (![[LRNetHandle sharedInstance].nets containsObject:net]) {
        [[LRNetHandle sharedInstance].nets addObject:net];
    }
}
+(void)freeNet:(LRNet *)net{
    if ([[LRNetHandle sharedInstance].nets containsObject:net]) {
        [[LRNetHandle sharedInstance].nets removeObject:net];
    }
}
@end

@interface LRNet()

#pragma mark - 请求内容
@property (nonatomic, weak) id<LRNetTipsConfig> tipsConfig;
@property (nonatomic, weak) id<LRNetDelegate> delegate;

#pragma mark - 请求提示
@property (nonatomic, assign) BOOL needShowLoading;
@property (nonatomic, assign) BOOL needShowErrorTips;
@property (nonatomic, assign) BOOL needShowSuccessTips;
@property (nonatomic, assign) BOOL isQuiet;

#pragma mark - 请求时网络状态
@property (nonatomic, assign) Net_Status requestNetStatus;

#pragma mark - callback
@property (nonatomic, copy) void (^CallBack)(LRResponseModel *model);

@end

@implementation LRNet

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reRequest) name:NetStatusDidChanged object:nil];
    }
    return self;
}

-(id)resetTimeout:(NSTimeInterval)timeInterval{
    self.httpManager.requestSerializer.timeoutInterval = timeInterval;
    return self;
}

-(id)setNetDelegate:(id<LRNetDelegate>)delegate{
    self.delegate = delegate;
    return self;
}

#pragma mark - 请求提醒配置
-(id)resetTipsConfig:(id<LRNetTipsConfig>)tipsConfig{
    self.tipsConfig = tipsConfig;
    return self;
}

-(id)setLoadMode:(RequestLoad)mode{
    self.needShowLoading = (mode & RequestLoadShowLoading) == RequestLoadShowLoading;
    self.needShowErrorTips = (mode & RequestLoadShowErrorTips) == RequestLoadShowErrorTips;
    self.needShowSuccessTips = (mode & RequestLoadShowSuccessTips) == RequestLoadShowSuccessTips;
    self.isQuiet = (mode & RequestLoadNoStatusLoading) == RequestLoadNoStatusLoading;
    return self;
}

-(id)configRequest:(LRRequestModel *)request{
    self.requestModel = request;
    return self;
}

#pragma mark - 发起请求

- (void)preRequestHandle{
    if ([self.delegate respondsToSelector:@selector(requestInfoWillHandleWithEngine:)]) {
        [self.delegate requestInfoWillHandleWithEngine:self];
    }
    
    if ([self respondsToSelector:@selector(handleRequestInfoWithNetEngine:)]){
        [self handleRequestInfoWithNetEngine:self];
    }
}

- (void)request {
    
    [LRNetHandle keepNet:self];
    
    if ([self.delegate respondsToSelector:@selector(requestWillStartWithNetEngine:)]) {
        [self.delegate requestWillStartWithNetEngine:self];
    }
    
    if (!self.isQuiet) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    if (self.needShowLoading && [self.tipsConfig respondsToSelector:@selector(showLoading)]) {
        [self.tipsConfig showLoading];
    }
    
    self.requestNetStatus = [LRNetStatus sharedInstance].currentNetworkStatusTag;
    
    __weak typeof(self) wself = self;
    
    switch (self.requestModel.type) {
        case GET:
        {
            self.sessionDataTask = [self.httpManager GET:self.requestModel.path parameters:self.requestModel.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(wself) sself = wself;
                [sself requestSuccessResponseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(wself) sself = wself;
                [sself requestFailureError:error];
            }];
        }
            break;
        case POST:
        {
            self.sessionDataTask = [self.httpManager POST:self.requestModel.path parameters:self.requestModel.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(wself) sself = wself;
                [sself requestSuccessResponseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(wself) sself = wself;
                [sself requestFailureError:error];
            }];
        }
            break;
        case PUT:
        {
            self.sessionDataTask = [self.httpManager PUT:self.requestModel.path parameters:self.requestModel.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(wself) sself = wself;
                [sself requestSuccessResponseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(wself) sself = wself;
                [sself requestFailureError:error];
            }];
        }
            break;
        case DELETE:
        {
            self.sessionDataTask = [self.httpManager DELETE:self.requestModel.path parameters:self.requestModel.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(wself) sself = wself;
                [sself requestSuccessResponseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(wself) sself = wself;
                [sself requestFailureError:error];
            }];
        }
            break;
        case POST_FormData:
        {
            self.sessionDataTask = [self.httpManager POST:self.requestModel.path parameters:self.requestModel.params constructingBodyWithBlock:self.requestModel.FormData progress:self.requestModel.UploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(wself) sself = wself;
                [sself requestSuccessResponseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(wself) sself = wself;
                [sself requestFailureError:error];
            }];
        }
            break;
        case POST_Body:
        {
            NSMutableURLRequest *request = [self.httpManager.requestSerializer requestWithMethod:@"POST" URLString:self.requestModel.path parameters:self.requestModel.params error:nil];
            [request setHTTPBody:[self.requestModel.body dataUsingEncoding:NSUTF8StringEncoding]];
            
            self.sessionDataTask = [self.httpManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                __strong typeof(wself) sself = wself;
                if (responseObject) {
                    [sself requestSuccessResponseObject:responseObject];
                }else{
                    [sself requestFailureError:error];
                }
            }];
            
            [self.sessionDataTask resume];
        }
            break;
        case PUT_Body:
        {
            NSMutableURLRequest *request = [self.httpManager.requestSerializer requestWithMethod:@"PUT" URLString:self.requestModel.path parameters:self.requestModel.params error:nil];
            [request setHTTPBody:[self.requestModel.body dataUsingEncoding:NSUTF8StringEncoding]];
            
            self.sessionDataTask = [self.httpManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                __strong typeof(wself) sself = wself;
                if (responseObject) {
                    [sself requestSuccessResponseObject:responseObject];
                }else{
                    [sself requestFailureError:error];
                }
            }];
            [self.sessionDataTask resume];
        }
            break;
        case UN_REQUEST:
        {
            self.sessionDataTask = nil;
            [self requestFailureError:nil];
        }
            break;
        default:
        {
            self.sessionDataTask = nil;
            if (self.needShowLoading && [self.tipsConfig respondsToSelector:@selector(disappearLoading)]) [self.tipsConfig disappearLoading];
            if (!self.isQuiet) [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
            break;
    }
}

-(void)requestCallBack:(void (^)(LRResponseModel *))callBack{
    self.CallBack = callBack;
    [self preRequestHandle];
    [self request];
}

-(void)requestOnly{
    [self request];
}

-(void)reRequest{
    [self request];
}

-(void)requestSuccessResponseObject:(id)responseObject{
    
    if (self.needShowLoading && [self.tipsConfig respondsToSelector:@selector(disappearLoading)]) [self.tipsConfig disappearLoading];
    if (!self.isQuiet) [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    LRResponseModel *model = [[LRResponseModel alloc] init];
    model.task = self.sessionDataTask;
    model.responseObject = responseObject;
    self.responseModel = model;
    
    [self handleResponseInfoWithNetEngine:self];
    
    if ([self.delegate respondsToSelector:@selector(requestDidSuccessWithNetEngine:)]) {
        [self.delegate requestDidSuccessWithNetEngine:self];
    }
    
    if (self.CallBack) {
        self.CallBack(self.responseModel);
    }
    
    if ([self.tipsConfig respondsToSelector:@selector(showTipsWithNetEngine:)]) {
        if ((self.responseModel.success && self.needShowSuccessTips) || (!self.responseModel.success && self.needShowErrorTips)) {
            [self.tipsConfig showTipsWithNetEngine:self];
        }
    }
    
    if (self.requestNetStatus != Net_Status_None) {
        [LRNetHandle freeNet:self];
    }
}

-(void)requestFailureError:(NSError *)error{
    
    if (self.needShowLoading && [self.tipsConfig respondsToSelector:@selector(disappearLoading)]) [self.tipsConfig disappearLoading];
    if (!self.isQuiet) [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    LRResponseModel *model = [[LRResponseModel alloc] init];
    model.task = self.sessionDataTask;
    model.error = error;
    self.responseModel = model;
    
    [self handleResponseInfoWithNetEngine:self];
    
    if ([self.delegate respondsToSelector:@selector(requestDidFailureWithNetEngine:)]) {
        [self.delegate requestDidFailureWithNetEngine:self];
    }
    
    if (self.CallBack) {
        self.CallBack(self.responseModel);
    }
    
    if ([self.tipsConfig respondsToSelector:@selector(showTipsWithNetEngine:)]) {
        if (!self.responseModel.success && self.needShowErrorTips) {
            [self.tipsConfig showTipsWithNetEngine:self];
        }
    }
    
    if (self.requestNetStatus != Net_Status_None) {
        [LRNetHandle freeNet:self];
    }
    
}

-(void)handleResponseInfoWithNetEngine:(id)engine{}

#pragma mark - setter getter
-(AFHTTPSessionManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [[AFHTTPSessionManager alloc] init];
        _httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
        _httpManager.requestSerializer.timeoutInterval = 15;
    }
    return _httpManager;
}

@end

