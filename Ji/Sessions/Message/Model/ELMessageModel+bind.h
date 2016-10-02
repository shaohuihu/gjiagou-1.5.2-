//
//  ELMessageModel+bind.h
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMessageListModel.h"

@interface ELMessageModel (bind)

- (void)bindBool:(BOOL)tag;
- (BOOL)getBool;
@end
