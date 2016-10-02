//
//  DBUserCenter.m
//  Ji
//
//  Created by sbq on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBUserCenter.h"

@implementation DBUserCenter
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
    
}

+ (DBUserCenter *)shareInstance {
    static DBUserCenter *user;
    if (user == nil) {
        user = [[DBUserCenter alloc] init];
    }
    return user;
}


-(void)saveWithDic:(NSDictionary*)dic{

    [self setValuesForKeysWithDictionary:dic];
    self.uid = dic[@"id"];
}

-(void)saveAccount:(NSString*)account andPw:(NSString*)pw andUid:(NSNumber*)uid{
    
    NSString *uidStr = [NSString stringWithFormat:@"%@",uid];
    [[NSUserDefaults standardUserDefaults]setObject:account forKey:@"account"];
    [[NSUserDefaults standardUserDefaults]setObject:pw forKey:@"pw"];
    [[NSUserDefaults standardUserDefaults]setObject:uidStr forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}



-(NSString*)getAccount{
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    if (account==nil) {
        return @"";
    }else{
        return  account;
    }
        

}

-(NSString*)getPw{
    NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"pw"];
    NSLog(@"1111%@",pw);
    
    if (pw==nil) {
        return @"";
    }else{
        return  pw;
    }
}

-(NSString*)getUid{

    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if (uid==nil) {
        return @"";
    }else{
        return  uid;
    } 
}


-(void)logout{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"pw"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"account"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
