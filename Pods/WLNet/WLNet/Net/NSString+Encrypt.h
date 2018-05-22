//
//  NSString+Encrypt.h
//  WLNetServer
//
//  Created by leo on 2017/6/14.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

#pragma mark - NetWL
//  AES/CBC/PKCS5Padding  资料来源： http://www.jianshu.com/p/df828a57cb8f
-(NSString *)encryptAES_NetWL;//aes加密
-(NSString *)decryptAES_NetWL;//aes解密

#pragma mark - NetPS
//  DESede/ECB/PKCS5Padding
-(NSString *)encrypt3DES_NetPS;//des加密
-(NSString *)decrypt3DES_NetPS;//des解密

@end
