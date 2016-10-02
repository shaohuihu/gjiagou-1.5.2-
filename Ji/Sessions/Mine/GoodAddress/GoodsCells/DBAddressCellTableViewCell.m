
//
//  DBAddressCellTableViewCell.m
//  Ji
//
//  Created by sbq on 16/5/22.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBAddressCellTableViewCell.h"
@implementation DBAddressCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconBtn.userInteractionEnabled = YES;
    [self.iconImageView addSubview:self.iconBtn];
    [self.iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-5, -5, -5, -5));
    }];
}
-(void)drawRect:(CGRect)rect{
    self.custom2View.name.text = @"删除";
    self.custom2View.img.image = [UIImage imageNamed:@"ic_deleter_address"];
    
    self.customView.name.text = @"编辑";
    self.customView.img.image = [UIImage imageNamed:@"ic_eidt_address"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setData:(id)data{
    if ([data isKindOfClass:[AddressListModel class]]) {
        AddressListModel *model = data;
        self.userNameLabel.text = model.userName;
        self.phoneLabel.text = model.phone;
        self.addressLabel.text = model.addressDetail;
        if (model.isDefault) {
            self.iconImageView.image = Icon_Checked;
            self.defaultLabel.hidden = NO;
        }else{
            self.iconImageView.image = Icon_UnChecked;
            self.defaultLabel.hidden = YES;

        }
        
    }
}
@end
