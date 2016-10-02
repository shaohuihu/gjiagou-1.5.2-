//
//  DBStateCell.m
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBStateCell.h"
#import "DBOrderDetialModel.h"
@implementation DBStateCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_bgView];
    
    _stateLabel = [ELUtil createLabelFont:15 color:[UIColor whiteColor]];
    [_bgView addSubview:_stateLabel];
    
    _gjiagouImageView = [UIImageView new];
    _gjiagouImageView.image = [UIImage imageNamed:@"ic_order_topimg"];
    [_bgView addSubview:_gjiagouImageView];
    
    WS(ws);
    [_bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(80));
    }];
    
    [_stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_bgView);
        make.left.equalTo(20);
    }];
    
    [_gjiagouImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView);
        make.right.equalTo(-10);
    }];

}

-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[Order class]]) {
        Order *order = self.data;
        if (order.state==1) {
            _stateLabel.text = @"交易关闭";
        }
        if (order.state==2) {
            _stateLabel.text = @"待付款";
        }
        if (order.state==3) {
            _stateLabel.text = @"待发货";
        }
        if (order.state==4) {
            _stateLabel.text = @"已发货";
        }
        if (order.state==5) {
            _stateLabel.text = @"已收货";
        }
        if (order.state==6) {
            _stateLabel.text = @"已申请退货";
        }

    }

}
    //    * 订单状态 状态  1退款处理中 2商家已同意;3:退款失败;4:商家已收到退款货物;5：退款成功;6：待平台审核
-(void)setDataTuikuan{
    if ([self.data isKindOfClass:[Order class]]) {
        Order *order = self.data;
        if (order.state==1) {
            _stateLabel.text = @"退款处理中";
        }
        if (order.state==2) {
            _stateLabel.text = @"商家已同意";
        }
        if (order.state==3) {
            _stateLabel.text = @"退款失败";
        }
        if (order.state==4) {
            _stateLabel.text = @"商家已收到退款货物";
        }
        if (order.state==5) {
            _stateLabel.text = @"退款成功";
        }
        if (order.state==6) {
            _stateLabel.text = @"待平台审核";
        }
    }
}

-(void)setDataFeituikuan{
    if ([self.data isKindOfClass:[Order class]]) {
        Order *order = self.data;
        if (order.state==1) {
            _stateLabel.text = @"交易关闭";
        }
        if (order.state==2) {
            _stateLabel.text = @"待付款";
        }
        if (order.state==3) {
            _stateLabel.text = @"待发货";
        }
        if (order.state==4) {
            _stateLabel.text = @"已发货";
        }
        if (order.state==5) {
            _stateLabel.text = @"已收货";
        }
        if (order.state==6) {
            _stateLabel.text = @"已申请退货";
        }
        
    }
}
@end
