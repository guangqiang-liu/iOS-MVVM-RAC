//
//  LRRModuleMacro.h
//  LRRouter
//
//  Created by leo on 2017/8/21.
//  Copyright © 2017年 leospace. All rights reserved.
//

#ifndef LRRModuleMacro_h
#define LRRModuleMacro_h

// 数据有效性

#define LRRIsValidString(str) (str && ![str isKindOfClass:[NSNull class]] && ![str isEqualToString:@"<null>"] && ![str isEqualToString:@""])
#define LRRSafeString(str) (LRRIsValidString(str)?str:@"")
#define LRRIsValidArray(arr) ([arr isKindOfClass:[NSArray class]])
#define LRRSafeArray(arr) (LRRIsValidArray(arr)?arr:@[])



// 字典key

#define kLRRModulePath @"kLRRModulePath"
#define kLRRModuleClass @"kLRRModuleClass"
#define kLRRModuleClassMethods @"kLRRModuleClassMethods"


#endif /* LRRModuleMacro_h */
