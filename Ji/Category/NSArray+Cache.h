//
//  NSArray+Cache.h
//  Wai
//
//  Created by lwq on 16/5/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Cache)

- (void)saveFileName:(NSString *)fileName completion:(void(^)(BOOL ret))completion;

+ (NSArray *)readFromFileName:(NSString *)fileName;

@end
