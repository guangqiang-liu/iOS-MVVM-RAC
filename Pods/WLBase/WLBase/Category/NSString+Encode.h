//
//  NSString+Encode.h
//  carcareIOS
//
//  Created by ileo on 16/7/25.
//  Copyright © 2016年 chezheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encode)

//md5加密
-(NSString *)encodeWithMD5;

//URI编码
-(NSString *)encodeWithURIComponent;


@end
