//
//  NSObject+Extension.m
//  RuntimeTest
//
//  Created by winbei on 2018/5/28.
//  Copyright © 2018年 winbei. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
@implementation NSObject (Extension)
-(void)encode:(NSCoder *)aCoder{
    Class c = self.class;
    while (c&&c!=[NSObject class]) {
        unsigned int outCount =0 ;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar ivarInfo = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivarInfo)];
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) {
                    continue;
                }
            }
            
            id value = [self valueForKey:key];
            [aCoder encodeObject:value forKey:key];
        }
        
        free(ivars);
        c= [c superclass];
    }
}
-(void)decode:(NSCoder *)aDecoder{
    Class c = self.class;
    while (c&&c!=[NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar ivarInfo = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivarInfo)];
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) {
                    continue;
                }
            }
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
        c = [c superclass];
        
    }
}
-(void)setModelInfoDict:(NSDictionary *)infoDict{
    Class c = self.class;
    while (c&&c!=[NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar ivarInfo = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivarInfo)];
            key = [key substringFromIndex:1];
            id value = infoDict[key];
            if (value==nil) {
                continue;
            }
            [self setValue:value forKeyPath:key];
        }
        free(ivars);
        c = [c superclass];
        
    }
    
}
@end
