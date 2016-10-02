//
//  CustomSheetView.h
//  KeGoal
//
//  Created by sbq on 16/2/16.
//  Copyright © 2016年 sbq. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CustomSheetView;
@protocol CustomsheetDelegate <NSObject>

-(void)customSheetView:(CustomSheetView*)sheetView clickAtIndex:(NSInteger)btnIndex;

@end

@interface CustomSheetView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipMessageLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property(nonatomic,weak)id<CustomsheetDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *downView;


-(void)initCustomSheetWithTipString:(NSString*)tipMessage andSureMessage:(NSString*)sureMessage andCancelMessage:(NSString*)cancelMessage ;

@end
