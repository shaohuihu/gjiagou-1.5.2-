//
//  DBContentCell.m
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBContentCell.h"
#import "DBOrder.h"
#import "DBOrderDetialModel.h"

@interface DBContentCell (){
    UILabel *stateLabel;
}



@end

@implementation DBContentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//这个是订单的商品的信息
-(void)o_configViews{
    _avatarImageView = [UIImageView new];
    [self.contentView addSubview:_avatarImageView];
    
    _titleLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    
    _subTitleLabel  =[ELUtil createLabelFont:12 color:EL_TextColor_Light];
    _subTitleLabel.numberOfLines = 2;
    [self.contentView addSubview:_subTitleLabel];
    
    _priceLabel = [ELUtil createLabelFont:13 color:[UIColor redColor]];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
    
    _countLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    _countLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_countLabel];
    
    /*
     * 有关评论的按钮
     */
  
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.titleLabel.font = kFont_System(12);
    [_commentBtn setTitle:@"评价" forState:UIControlStateNormal];
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"ic_butn_line_3"] forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commentBtn];
    NSUserDefaults *getpaymentNSU=[NSUserDefaults standardUserDefaults];
    NSString * paymentSS=[getpaymentNSU objectForKey:@"payment"];
    DDLog(@"打印一下订单的payment%@",paymentSS);
    if ([self.vcTitle isEqualToString:@"退款订单"]) {
        _commentBtn.hidden=YES;
        
    }
    
    UIView *white = [UIView new];
    white.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:white];
    
    self.contentView.backgroundColor = EL_BackGroundColor;
    WS(ws);
    [_avatarImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(ws.contentView).offset(-2);
        make.width.equalTo(kRadioXValue(60));
        make.height.equalTo(kRadioXValue(60));
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImageView.right).offset(5);
        make.top.equalTo(10);
        make.right.equalTo(ws.contentView).offset(-70);
        make.height.greaterThanOrEqualTo(30);
    }];
    
    [_subTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom);
        make.right.equalTo(_titleLabel.right);
        make.left.equalTo(_titleLabel.left);
        make.height.greaterThanOrEqualTo(30);
        make.bottom.equalTo(ws.contentView).offset(-15);
    }];
    
    [white makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(5);
    }];
    
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-5);
        make.top.equalTo(ws.contentView).offset(10);
        make.height.equalTo(20);
        make.width.equalTo(70);
    }];
    
    [_countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.bottom);
        make.right.equalTo(-5);
        make.height.equalTo(20);
        make.width.equalTo(70);

    }];
    
    [_commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-10);
        make.right.equalTo(_priceLabel.right);
        make.height.equalTo(kRadioXValue(20));
        make.width.mas_greaterThanOrEqualTo(kRadioXValue(50));
    }];
//    _avatarImageView.backgroundColor = [UIColor blackColor];
//    _titleLabel.text    = @"这是一瓶鱼塘酱油,美味可口，回味无穷";
//    _subTitleLabel.text = @"颜色：绿色";
//    _priceLabel.text    = @"￥0.01";
//    _countLabel.text    = @"x3";
    
}


-(void)o_dataDidChanged{
    //list
    if ([self.data isKindOfClass:[Goods_List class]]) {
        Goods_List *goods = self.data;
        _titleLabel.text = goods.goodsName;
        _subTitleLabel.text = goods.standard;
        _countLabel.text = [NSString stringWithFormat:@"x%@",integerToString(goods.goodsNum)];
        NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",goods.goodsPayPrice];
        _priceLabel.text = DBPRICE(priceStr);
        [_avatarImageView sd_setImageWithURL:ELIMAGEURL(goods.goodsImage)];
    }
    
    //详情
    if ([self.data isKindOfClass:[Goodslist class]]) {
        
        Goods_List *goods = self.data;
        _titleLabel.text = goods.goodsName;
        _subTitleLabel.text = goods.standard;
        _countLabel.text = [NSString stringWithFormat:@"x%@",integerToString(goods.goodsNum)];
        NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",goods.goodsPayPrice];
        _priceLabel.text = DBPRICE(priceStr);
        [_avatarImageView sd_setImageWithURL:ELIMAGEURL(goods.goodsImage)];
//        if ([self.vcTitle isEqualToString:@"退款订单"]) {
//商品的状态：1.退款处理中，2.退款失败，3.退款处理中，4.退款成功，5.申请售后
        
        DDLog(@"15092710472%@",goods.goodsName);
        DDLog(@"18263802293%@",goods.standard);
        
            if (goods.status==1) {
                _commentBtn.userInteractionEnabled = NO;
                [_commentBtn setTitle:@"退款处理中" forState:UIControlStateNormal];
            }
            if (goods.status==2) {
                _commentBtn.userInteractionEnabled = YES;
                [_commentBtn setTitle:@"退款失败" forState:UIControlStateNormal];

            }
            if (goods.status==3) {
                _commentBtn.userInteractionEnabled = NO;
                [_commentBtn setTitle:@"退款处理中" forState:UIControlStateNormal];

            }
            if (goods.status==4) {
                _commentBtn.userInteractionEnabled = NO;
                [_commentBtn setTitle:@"退款成功" forState:UIControlStateNormal];
            }
            if (goods.status==0) {
                
                _commentBtn.userInteractionEnabled = YES;
                [_commentBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            }
//        }
        
    }
}


//list页调用
-(void)setCommtnBtn:(DBOrder *)order{
    if (order.state==5) {//已收货
        _commentBtn.hidden = NO;
        if ([order.isDis integerValue]==1) {
            [_commentBtn setTitle:@"已评价" forState:UIControlStateNormal];
        }else{
            [_commentBtn setTitle:@"评价" forState:UIControlStateNormal];
        }
    }else{
        
        _commentBtn.hidden = YES;
        
    }
}


//详情页调用
/*
 * 这个是设置售后的方法，如果订单的状态是已付款代发货，已收货，已发货状态，那么可以进行申请售后的功能，
 */
-(void)setShouhouBtn:(Order *)order and:(Goods_List *)good{
    if (![self.vcTitle isEqualToString:@"退款订单"]) {
        //订单状态 状态  1交易关闭(已取消)2(默认):未付款;3:已付款,待发货;4:已发货;5：已收货;6：申请退货退款
        if ( order.state==3 || order.state==4 ||order.state==5 ) {//已收货
            _commentBtn.hidden = NO;
            [_commentBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        }else{//在订单状态为1.交易关闭，2.未付款，6.申请退货退款的情况下不可以点击申请售后
            
           
            _commentBtn.hidden = YES;
        }
    }else{
#pragma mark-这个是从退款订单进入的订单详情
       
        

        
#pragma mark-这里有我改动的地方
        _commentBtn.hidden = NO;
        
    }

}
-(void)btn:(UIButton*)btn{

    if ([self.delegate respondsToSelector:@selector(commentBtnClick:)]) {
        [self.delegate commentBtnClick:btn];
    }

}
@end
