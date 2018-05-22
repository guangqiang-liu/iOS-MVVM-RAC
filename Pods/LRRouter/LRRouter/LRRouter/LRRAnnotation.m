//
//  LRRAnnotation.m
//  LRRouter
//
//  Created by leo on 2017/8/18.
//  Copyright © 2017年 leospace. All rights reserved.
//

#import "LRRAnnotation.h"
#import <dlfcn.h>
#include <mach-o/getsect.h>

static NSArray<NSString *>* LRRReadConfig(char *section)
{
    NSMutableArray *configs = [NSMutableArray array];
    
    Dl_info info;
    dladdr(LRRReadConfig, &info);
    
#ifndef __LP64__
    // const struct mach_header *mhp = _dyld_get_image_header(0); // both works as below line
    const struct mach_header *mhp = (struct mach_header*)info.dli_fbase;
    unsigned long size = 0;
    // 找到之前存储的数据段(Module找BeehiveMods段 和 Service找BeehiveServices段)的一片内存
    uint32_t *memory = (uint32_t*)getsectiondata(mhp, "__DATA", section, & size);
#else /* defined(__LP64__) */
    const struct mach_header_64 *mhp = (struct mach_header_64*)info.dli_fbase;
    unsigned long size = 0;
    uint64_t *memory = (uint64_t*)getsectiondata(mhp, "__DATA", section, & size);
#endif /* defined(__LP64__) */
    
    // 把特殊段里面的数据都转换成字符串存入数组中
    for(int idx = 0; idx < size/sizeof(void*); ++idx){
        char *string = (char*)memory[idx];
        
        NSString *str = [NSString stringWithUTF8String:string];
        if(!str)continue;
        
        if(str) [configs addObject:str];
    }
    
    return configs;
}

@implementation LRRAnnotation

NSString *modules;

+(NSArray<NSString *> *)annotationModules{
    NSArray *arr = LRRReadConfig(LRRModuleSectName);
    if (arr.count > 0) {
        return arr;
    }else{
        return [modules componentsSeparatedByString:@","];
    }
}

+(void)addModule:(Class)module{
    if (modules) {
        modules = [modules stringByAppendingFormat:@",%@",NSStringFromClass(module)];
    }else{
        modules = NSStringFromClass(module);
    }
}

@end
