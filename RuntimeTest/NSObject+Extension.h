//
//  NSObject+Extension.h
//  RuntimeTest
//
//  Created by winbei on 2018/5/28.
//  Copyright © 2018年 winbei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
-(NSArray *)ignoredNames;
-(void)encode:(NSCoder *)aCoder;
-(void)decode:(NSCoder *)aDecoder;
-(void)setModelInfoDict:(NSDictionary *)infoDict;
@end
