//
//  DBGoodsAddressViewController.h
//  Ji
//
//  Created by sbq on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELBasicViewController.h"

/**
 *  收货地址管理
 */
@class AddressListModel;

@interface DBGoodsAddressViewController : ELBasicViewController

@property (nonatomic, copy) void(^selectBlock)(AddressListModel * addressModel);
@property(nonatomic,assign)BOOL notSelect;
@end
