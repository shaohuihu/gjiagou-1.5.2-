//
//  ELCheckoutAddressCell.m
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCheckoutAddressCell.h"
#import "AddressListModel.h"

@interface ELCheckoutAddressCell ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UILabel *phoneLabel;

@end

@implementation ELCheckoutAddressCell

- (void)o_configViews {
    UIImageView *topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_order_line_2"]];
    [self.contentView addSubview:topImage];
    
    UIImageView *bottomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_address_line_top"]];
    [self.contentView addSubview:bottomImage];
    
    UIImageView *addressIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_address"]];
    [self.contentView addSubview:addressIcon];
    
    UILabel *nameLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.nameLabel =nameLabel];
    
    UILabel *addressLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.addressLabel = addressLabel];
    
    UILabel *phoneLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.phoneLabel = phoneLabel];
    WS(ws);
    [topImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.contentView);
        make.height.equalTo(kRadioXValue(2));
    }];
    
    [addressIcon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView.centerY).multipliedBy(0.75);
        make.left.equalTo(15);
    }];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressIcon.right).offset(15);
        make.top.equalTo(15);
    }];
    
    [phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-13);
        make.top.equalTo(nameLabel);
    }];
    
    [addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.bottom).offset(15);
    }];
    
    [bottomImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(kRadioXValue(2));
        make.top.equalTo(addressLabel.bottom).offset(20);
    }];
}


- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[AddressListModel class]]) {
        AddressListModel *model = self.data;
        self.nameLabel.text = [NSString stringWithFormat:@"收件人 : %@",model.userName];
        self.phoneLabel.text = model.telePhone;
        self.addressLabel.text = [NSString stringWithFormat:@"收货地址 : %@ %@ %@ %@",model.provinceName,model.cityName,model.countyName,model.addressDetail];
    }
}

@end
