//
//  NetBaseWL.m
//  WLNetServer
//
//  Created by leo on 2017/3/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "NetWL.h"
#import "WalletBase.h"
#import "NSString+Encode.h"
#import "NSString+Encrypt.h"
#import "JsonExtend.h"
#import "WLDeviceInfo.h"
#import "WLNetServer.h"
#import "WLConst.h"

@interface NetWL ()

@end

static NSString *sign_key = @"ilwHaGnQtdFxU1cK";

@implementation NetWL

- (instancetype)init{
    self = [super init];
    if (self) {
        if (WLConfigInit) {
            WLConfigInit(self);
        }
    }
    return self;
}

void (^WLConfigInit)(LRNet *net);

+(void)configInitInfo:(void (^)(LRNet *))config{
    WLConfigInit = config;
    [NetWLTokenHandle makeValidToken];
}

+(void)updateToken:(NSDictionary *)info{
    [AIToken fillPropertyWithDictionary:info];
}

+(void)clearToken{
    [AIToken clearUserDefault];
}

-(NSString *)host{
    return [WLNetServer wlHost];
}

-(NSString *)pathWithKey:(NSString *)key{
    return [WLConst netPathWithKey:key];
}

-(id)configGetPathKey:(NSString *)key params:(NSDictionary *)params{
    self.tagObject_copy = key;
    return [self configGetPath:[self pathWithKey:key] params:params];
}

-(id)configPostPathKey:(NSString *)key postParams:(NSDictionary *)params{
    self.tagObject_copy = key;
    return [self configPostPath:[self pathWithKey:key] postParams:params];
}

-(id)configPostPathKey:(NSString *)key getParams:(NSDictionary *)getParams postParams:(NSDictionary *)postParams{
    self.tagObject_copy = key;
    return [self configPostPath:[self pathWithKey:key] getParams:getParams postParams:postParams];
}

-(id)configGetPath:(NSString *)path params:(NSDictionary *)params{
    NetWLReqModel *model = [[NetWLReqModel alloc] init];
    model.path = [NSString stringWithFormat:@"%@%@",self.host,path];
    model.getParams = params;
    model.type = GET;
    self.requestModel = model;
    return self;
}

-(id)configPostPath:(NSString *)path postParams:(NSDictionary *)params{
    NetWLReqModel *model = [[NetWLReqModel alloc] init];
    model.path = [NSString stringWithFormat:@"%@%@",self.host,path];
    model.postParams = params;
    model.type = POST;
    self.requestModel = model;
    return self;
}

-(id)configPostPath:(NSString *)path getParams:(NSDictionary *)getParams postParams:(NSDictionary *)postParams{
    NetWLReqModel *model = [[NetWLReqModel alloc] init];
    model.path = [NSString stringWithFormat:@"%@%@",self.host,path];
    model.getParams = getParams;
    model.postParams = postParams;
    model.type = POST;
    self.requestModel = model;
    return self;
}

-(void)handleRequestInfoWithNetEngine:(NetWL *)engine{
    [WLNetServer validNet:self];

    NetWLReqModel *model = (NetWLReqModel *)engine.requestModel;
    
    NSMutableDictionary *getParams = [NSMutableDictionary dictionaryWithDictionary:model.getParams];
    [engine.httpManager.requestSerializer setValue:@"application/vnd.resthub.v2+json" forHTTPHeaderField:@"Accept-Resthub-Spec"];
    
    NSString *caller = SafeString([WLConst appConfigWithKey:@"app_caller"]);
    
    [engine.httpManager.requestSerializer setValue:[NSString stringWithFormat:@"%@/iOS (OS/%@ APP/%@)",caller,[WLDeviceInfo systemVersion],__APP_V] forHTTPHeaderField:@"Uni-Source"];
    
    [getParams addEntriesFromDictionary:@{@"_platform" : @"app",
                                          @"_os" : @"ios",
                                          @"_sysVersion" : SafeString([WLDeviceInfo systemVersion]),
                                          @"_model" : SafeString([WLDeviceInfo machine]),
                                          @"_appVersion" : __APP_V,
                                          @"_openUDID" : SafeString([WLDeviceInfo udid]),
                                          @"_cUDID" : SafeString([WLDeviceInfo idfa]),
                                          @"_appChannel" : @"appstore",
                                          @"_caller" : caller
                                          }];
    getParams[@"_ac_token"] = SafeString(AIToken.ac_token);
    
#ifdef DEBUG
    getParams[@"__intern__show-error-mesg"] = @"1";
#endif
    
    NSString *query = AFQueryStringFromParameters(getParams);
    NSString *path = model.path;
    //拼接路径
    path = [NSString stringWithFormat:@"%@%@%@",path,[path containsString:@"?"] ? @"&" : @"?", query];
    //得到query
    query = [path componentsSeparatedByString:@"?"][1];
    //得到get签名
    NSString *sign = [[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@&",query] encodeWithMD5],sign_key] encodeWithMD5];
    
    if (model.type == POST) {
        NSDictionary *postDic = model.postParams;
        model.params = postDic;
        //得到post签名
        sign = [[NSString stringWithFormat:@"%@%@",sign,[[NSString stringWithFormat:@"%@%@",[AFQueryStringFromParameters(postDic) encodeWithMD5],sign_key] encodeWithMD5]] encodeWithMD5];
    }
    //最终路径
    model.path = [NSString stringWithFormat:@"%@&_sign=%@",path,sign];
}

-(void)handleResponseInfoWithNetEngine:(NetWL *)engine{
    [WLNetServer invalidNet:self];

    LRResponseModel *model = engine.responseModel;
    model.message = @"网络连接失败了，稍后再试吧";
    if (model.responseObject) {
        NSDictionary *json;
        //是否需要解密
        
        if ([model.allHeaderFields[@"Content-Encrypt"] isEqualToString:@"AES/QBSH"]){
            NSString *encrypt = [[NSString alloc] initWithData:model.responseObject encoding:NSUTF8StringEncoding];
            NSString *str = [encrypt decryptAES_NetWL];
            if (str) {
                json = [NSDictionary dictionaryWithJsonValue:str];
            }
        }else{
            json = [NSJSONSerialization JSONObjectWithData:model.responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        if (json) {
            NSString *status = [NSString stringWithFormat:@"%@",json[@"status"]];
            model.success = [status hasPrefix:@"2"];
            model.data = json[@"result"];
            model.message = json[@"message"];
            model.code = status;
            model.responseObject = json;
        }
    }
    
    if ([model.code isEqualToString:[WLConst netErrorWithKey:@"wl_err_token_timeout"]]) {//token过期
        model.message = @"";//不显示提示
        [NetWLTokenHandle refreshTokenSuccess:^{
            [engine reRequest];
        }];
    }
    
}

@end


@implementation NetWLReqModel
@end


