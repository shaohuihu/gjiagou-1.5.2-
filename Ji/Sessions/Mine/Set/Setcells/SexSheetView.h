//
//  SexSheetView.h
//  KeGoal
//
//  Created by sbq on 16/3/10.
//  Copyright © 2016年 sbq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    CancelIndex = 10,
    Ok1Index = 11,
    Ok2Index = 12,
    Ok3Index = 13
} TapIndex;
@class SexSheetView;
@protocol SexSheetDelegate <NSObject>

-(void)actionSexSheet:(SexSheetView*)actionSheetView clickAtIndex:(TapIndex)index;
@end




@interface SexSheetView : UIView
@property(nonatomic,strong)NSString *cancelMessage;//取消信息
@property(nonatomic,strong)NSString *ok1Message;//确认1信息
@property(nonatomic,strong)NSString *ok2Message;//确认2信息
@property(nonatomic,strong)NSString *ok3Message;//确认3信息


@property(nonatomic,weak)id<SexSheetDelegate>delegate;
-(id)initActionViewWithCancelMessage:(NSString*)cancelMessage ok1Message:(NSString*)ok1Message ok2Message:(NSString*) ok2Message ok3Message:(NSString*)ok3Message;
@end
