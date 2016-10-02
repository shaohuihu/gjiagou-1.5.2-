//
//  DBConst.h
//  Ji
//
//  Created by sbq on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#ifndef DBConst_h
#define DBConst_h


#import "DBUserCenter.h"
#import "DBHandel.h"

#define Uid [[[DBUserCenter shareInstance]getUid]integerValue]
#define UidStr [[DBUserCenter shareInstance]getUid]

#define Net_Error_Msg @"网络故障"

#define ALPHA_BG_COLOR [UIColor colorWithWhite:0.0 alpha:0.3]

#define TimeInterval 60


#define DBPRICE(__xx__)      [DBHandel deleteLastZero:__xx__]
#endif /* DBConst_h */
