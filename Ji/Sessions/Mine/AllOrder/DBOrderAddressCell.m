//
//  DBOrderAddressCell.m
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBOrderAddressCell.h"
#import "DBOrderDetialModel.h"
@implementation DBOrderAddressCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//@property(nonatomic,strong)UIView *leftView;
//@property(nonatomic,strong)UIImageView *iconImageview;
//@property(nonatomic,strong)UILabel *userLabel;
//@property(nonatomic,strong)UILabel *addressLabel;
//@property(nonatomic,strong)UILabel *phoneLabel;

-(void)o_configViews{

    _leftView = [UIView new];
    [self.contentView addSubview:_leftView];
    
    _iconImageview = [UIImageView new];
    _iconImageview.image = [UIImage imageNamed:@"ic_order_address"];
    [_leftView addSubview:_iconImageview];
    
    _rightView = [UIView new];
    [self.contentView addSubview:_rightView];
    
    _userLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    [_rightView addSubview:_userLabel];
    
    _phoneLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    [_rightView addSubview:_phoneLabel];
    _phoneLabel.textAlignment = NSTextAlignmentRight;
    
    _addressLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    _addressLabel.numberOfLines = 2;
    [_rightView addSubview:_addressLabel];
    
    WS(ws);
    [_leftView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(70));
        make.width.equalTo(kRadioValue(30));
    }];
    [_iconImageview makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_leftView);
    }];
    
    [_rightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(ws.contentView);
        make.left.equalTo(ws.leftView.right);
    }];
    [_userLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightView);
        make.top.equalTo(3);
        make.height.equalTo(kRadioValue(33));
    }];
    [_phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rightView);
        make.right.equalTo(-5);
        make.height.equalTo(kRadioValue(33));
    }];
    [_addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_rightView);
        make.height.equalTo(kRadioValue(33));
        make.bottom.equalTo(-3);
    }];

}


-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[Order class]]) {
        Order *order        = self.data;
        _userLabel.text     = order.username;
        _phoneLabel.text    = order.phone;
        _addressLabel.text  = order.addressDetail;
    }
}
@end
