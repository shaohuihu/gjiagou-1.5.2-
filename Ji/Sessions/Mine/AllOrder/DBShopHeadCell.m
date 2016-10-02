//
//  DBShopHeadCell.m
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBShopHeadCell.h"
#import "DBOrder.h"
#import "DBOrderDetialModel.h"
@implementation DBShopHeadCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{

    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _shopNameLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark ];
    [self.contentView addSubview:_shopNameLabel];
    
    _tipImageView = [UIImageView new];
    [self.contentView addSubview:_tipImageView];
    
   
    
    WS(ws);
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.centerY.equalTo(ws.contentView);
        make.height.equalTo(ws.contentView).offset(-20);
        make.size.height.equalTo(kRadioXValue(16));
        make.size.width.equalTo(kRadioXValue(16));
    }];
    
    [_shopNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.right).offset(5);
        make.centerY.equalTo(ws.contentView);
    }];
    
    [_tipImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLabel.right).offset(5);
        make.centerY.equalTo(ws.contentView);
    }];
    NSUserDefaults *getpaymentNSU=[NSUserDefaults standardUserDefaults];
    NSString * paymentSS=[getpaymentNSU objectForKey:@"payment"];
    DDLog(@"打印一下订单的payment%@",paymentSS);
    //把商品的而数量打印出来
    NSUserDefaults *amousNSU=[NSUserDefaults standardUserDefaults];
    NSString * amouss=[amousNSU objectForKey:@"amous"];
    NSInteger amouNI=[amouss integerValue];
    _stateLabel = [ELUtil createLabelFont:13 color:[UIColor redColor]];
    [self.contentView addSubview:_stateLabel];
    [_stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-5);
        make.centerY.equalTo(ws.contentView);
    }];
//    if ([paymentSS isEqualToString:@"3"]) {
//        
//        
//        
//        
//    }
//    else{
//     
//}
    
//    [_stateLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-5);
//        make.centerY.equalTo(ws.contentView);
//    }];
//    
    
    
    
    
    
    
    
    _iconImageView.image  = [UIImage imageNamed:@"ic_shoping_supermarkert"];
    _tipImageView.image   = [UIImage imageNamed:@"ic_arrow_small_right"];
    
//    _shopNameLabel.text   = @"鱼塘酱油店";
//    _stateLabel.text      = @"等待买家发货";

}


-(void)o_dataDidChanged{
    //详情
    if ([self.data isKindOfClass:[Shop class]]) {
        Shop *shop = self.data;
        _shopNameLabel.text = shop.name;
    }
}


//list页赋值
#pragma mark-退款的所有的状态
-(void)setDataTuikuan{
    //    * 订单状态 状态  1退款处理中 2商家已同意;3:退款失败;4:商家已收到退款货物;5：退款成功;6：待平台审核
    if ([self.data isKindOfClass:[DBOrder class]]) {
        DBOrder *order = self.data;
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
            _stateLabel.text = @"退款处理中";
        }
        if (order.state==5) {
            _stateLabel.text = @"退款成功";
        }
        if (order.state==6) {
            _stateLabel.text = @"退款处理中";
        }
        _shopNameLabel.text = order.shopName;
        DDLog(@"这个是我想打印的order:%@",order);
        
    }
    


}
//list页赋值
#pragma mark-非退款的几种状态
-(void)setDataFeituikuan{
    //    * 订单状态 状态  1交易关闭(已取消)2(默认):未付款;3:已付款,待发货;4:已发货，待收货;5：已收货;6：申请退货退款
    if ([self.data isKindOfClass:[DBOrder class]]) {
        DBOrder *order = self.data;
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
            _stateLabel.text = @"待收货";
        }
        if (order.state==5) {
            _stateLabel.text = @"已收货";
        }
        if (order.state==6) {
            _stateLabel.text = @"已申请退货";
        }
        _shopNameLabel.text = order.shopName;
    }
    

}
@end
