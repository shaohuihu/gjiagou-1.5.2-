//
//  ELMineOrderCell.m
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMineOrderCell.h"
#import "ELMineOrderItemView.h"
#import "DBUserInfo.h"
#import "DBMineService.h"
#import "DBOrder.h"
@implementation ELMineOrderCell


-(void)o_configViews{
    //循环遍历添加“代付款，待发货，待收货，待评价，退款/维权”
    [@[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/维权"]
     enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        ELMineOrderItemView *view = [[ELMineOrderItemView alloc] init];
//        [view setTitle:title image:[NSString stringWithFormat:@"ic_order_state%ld",(unsigned long)idx] count:1];
          [view setTitle:title image:[NSString stringWithFormat:@"ic_order_state%ld",(unsigned long)idx] count:0];
         
         
         
        view.tag = 100 + idx;
         
        [view addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:view];
        CGFloat width = SCREEN_WIDTH/5;
        WS(ws);
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(ws.contentView);
            make.width.equalTo(width);
            make.left.equalTo(width * idx);
        }];
    }];
}


- (void)onButtonTap:(ELMineOrderItemView *)button {
    if ([self.delegate respondsToSelector:@selector(orderCellDidSelectIndex:)]) {
        [self.delegate orderCellDidSelectIndex:button.tag-100];
    }
}

//NSArray *array = @[@{@"vcTitle":@"待付款订单",@"type":@"await_pay"},
//                   @{@"vcTitle":@"待发货订单",@"type":@"await_ship"},
//                   @{@"vcTitle":@"待收货订单",@"type":@"shipped"},
//                   @{@"vcTitle":@"待评价订单",@"type":@"finished"},
//                   @{@"vcTitle":@"退款订单",@"type":@"refund"}];
-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[DBUserInfo class]]) {
        DBUserInfo *userInfoModel = (DBUserInfo*)self.data;
        NSDictionary *orderDic = (NSDictionary*)userInfoModel.order_num;
        NSArray *orderNumberList = @[orderDic[@"await_pay"],orderDic[@"await_ship"],orderDic[@"shipped"],orderDic[@"finished"],orderDic[@"refund_pay"]];
        DDLog(@"&^%%$%@",orderNumberList);
        NSString * lastSt=[orderNumberList objectAtIndex:4];
        int last=[lastSt integerValue];
       
        
        
      //原来这里面的是last-5，现在变为last
       // int tempLast=last-5;
        int tempLast=last;
        DDLog(@"119911%d",tempLast);
    
        
        
        
        
        
        
  /***************************************这里有我做过的一些修改********************************/
        [orderNumberList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ELMineOrderItemView *view = (ELMineOrderItemView*)[self.contentView viewWithTag:idx+100];
            if ([obj integerValue]==0) {
                view.countLabel.hidden = YES;
                
            }else{
                view.countLabel.hidden = NO;
                if (view.tag==100) {
                    view.countLabel.text=[NSString stringWithFormat:@"%@",obj];
                    
                }
                else if (view.tag==101){
                    view.countLabel.text=[NSString stringWithFormat:@"%@",obj];
                }
                else if (view.tag==102){
                    view.countLabel.text=[NSString stringWithFormat:@"%@",obj];
                }
                else if (view.tag==103){
                    view.countLabel.text=[NSString stringWithFormat:@"%@",obj];
                }
                else{
                    view.countLabel.text=[NSString stringWithFormat:@"%d",tempLast];
                }

                
            }
         
                    
            
            
            //view.countLabel.text = [NSString stringWithFormat:@"%@",obj];
        }];

    }
}
@end
