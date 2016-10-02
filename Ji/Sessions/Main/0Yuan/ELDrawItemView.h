//
//  ELDrawItemView.h
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELDrawtomModel;

@protocol ELDrawItemViewDelegate <NSObject>

@optional
- (void)itemViewDidSelectWithModel:(ELDrawtomModel *)model;
- (void)itemViewImageDidTapWithModel:(ELDrawtomModel *)model;
@end
@interface ELDrawItemView : UIView

@property (nonatomic, strong) ELDrawtomModel *model;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, weak) id<ELDrawItemViewDelegate> delegate;

@end
