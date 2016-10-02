//
//  ELbadSViewController.h
//  Ji
//
//  Created by 龙讯科技 on 16/9/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELBasicViewController.h"
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
@protocol ELMesssageDeleteViewDelegate <NSObject>
@optional
//- (void)deleteViewTagButtonDidTapWithSelected:(BOOL)selected;
-(void)doPay;
@end

@interface ELbadSViewController : ELBasicViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (nonatomic, weak) id<ELMesssageDeleteViewDelegate> delegate;

@property(nonatomic,strong)NSMutableArray * turn_sn;
@property(nonatomic,strong)NSMutableArray * turn_amount;
@property(nonatomic,assign)NSInteger goodID;


@end
