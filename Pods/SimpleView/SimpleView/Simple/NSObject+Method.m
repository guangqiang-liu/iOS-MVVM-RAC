//
//  NSObject+Method.m
//  SimpleView
//
//  Created by ileo on 16/7/19.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSObject+Method.h"
#import <objc/runtime.h>

@implementation NSObject (Method)

static char tagObjectCopyKey;
static char tagObjectStrongKey;

-(void)setTagObject_copy:(id)tagObject_copy{
    objc_setAssociatedObject(self, &tagObjectCopyKey, tagObject_copy, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(id)tagObject_copy{
    return objc_getAssociatedObject(self, &tagObjectCopyKey);
}


-(void)setTagObject_strong:(id)tagObject_strong{
    objc_setAssociatedObject(self, &tagObjectStrongKey, tagObject_strong, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)tagObject_strong{
    return objc_getAssociatedObject(self, &tagObjectStrongKey);
}

+(void)exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2{
    method_exchangeImplementations(class_getInstanceMethod([self class], sel1), class_getInstanceMethod([self class], sel2));
}

+(void)exchangeClassSEL:(SEL)sel1 withClassSEL:(SEL)sel2{
    method_exchangeImplementations(class_getClassMethod([self class], sel1), class_getClassMethod([self class], sel2));
}


@end
