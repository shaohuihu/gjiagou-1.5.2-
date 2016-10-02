//
//  NSArray+Cache.m
//  Wai
//
//  Created by lwq on 16/5/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "NSArray+Cache.h"

@implementation NSArray (Cache)

- (void)saveFileName:(NSString *)fileName completion:(void(^)(BOOL ret))completion
{
    if (self.count == 0) {
        completion(NO);
        return;
    }
    
    NSString *filePath = [[self class] filePathName:fileName];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        BOOL ret = [data writeToFile:filePath atomically:YES];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(completion)
                completion(ret);
        });
    });
}

+ (NSArray *)readFromFileName:(NSString *)fileName
{
    NSString *filePath = [[self class] filePathName:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSArray *results = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return results;
    } else {
        NSLog(@"file:%@ not exist",fileName);
        return [NSArray array];
    }
}

+ (NSString *)filePathName:(NSString *)fileName
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/NSArray+%@",fileName]];
    return path;
}


@end
