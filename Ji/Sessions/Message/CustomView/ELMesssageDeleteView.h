//
//  ELMesssageDeleteView.h
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ELMesssageDeleteViewDelegate <NSObject>
@optional
- (void)deleteViewTagButtonDidTapWithSelected:(BOOL)selected;
- (void)deleteViewRightTap;
@end


@interface ELMesssageDeleteView : UIView

@property (nonatomic, weak) id<ELMesssageDeleteViewDelegate> delegate;

- (void)setLeftTag:(BOOL)leftTag rightTag:(BOOL)rightTag;

@end
