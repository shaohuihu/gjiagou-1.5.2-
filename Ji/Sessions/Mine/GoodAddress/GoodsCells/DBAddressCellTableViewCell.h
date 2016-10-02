//
//  DBAddressCellTableViewCell.h
//  Ji
//
//  Created by sbq on 16/5/22.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBBtnView.h"
#import "AddressListModel.h"
#define Icon_Checked  [UIImage imageNamed:@"ic_checked"]
#define Icon_UnChecked  [UIImage imageNamed:@"ic_unchecked"]
@interface DBAddressCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet DBBtnView *customView;
@property (weak, nonatomic) IBOutlet DBBtnView *custom2View;

@property(nonatomic,strong)UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;


-(void)setData:(id)data;
@end
