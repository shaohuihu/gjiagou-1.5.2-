//
//  ELCartGoodsModel+bind.h
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCartListModel.h"

@interface ELCartGoodsModel (bind)

- (void)bindBool:(BOOL)tag;
- (BOOL)getBool;
- (void)bindDelKey:(BOOL)tag;
- (BOOL)getDelKey;

@end
