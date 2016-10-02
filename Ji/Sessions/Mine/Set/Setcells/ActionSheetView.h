//
//  ActionSheetView.m
//  KeGoal
//
//  Created by sbq on 15/8/6.
//  Copyright (c) 2015年 sbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SexSheetView.h"
@class ActionSheetView;
@protocol ActionDelegate <NSObject>

-(void)actionSheet:(ActionSheetView*)actionSheetView clickAtIndex:(TapIndex)index;
@end

@interface ActionSheetView : UIView


@property(nonatomic,strong)NSString *cancelMessage;//取消信息
@property(nonatomic,strong)NSString *ok1Message;//确认1信息
@property(nonatomic,strong)NSString *ok2Message;//确认2信息


@property(nonatomic,weak)id<ActionDelegate>delegate;
-(id)initActionViewWithCancelMessage:(NSString*)cancelMessage ok1Message:(NSString*)ok1Message ok2Message:(NSString*) ok2Message;
@end
