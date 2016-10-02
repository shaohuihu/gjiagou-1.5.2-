//
//  DBNodataView.h
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AddClickBlock) (UIButton*btn);

@interface DBNodataView : UIView
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *upLabel;
@property(nonatomic,strong)UILabel *downLabel;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)AddClickBlock addClickBlock;

-(void)setImage:(NSString*)imageName andUpLabel:(NSString*)upLabel andDownLabel:(NSString*)downLabel andBtn:(NSString*)btnName;
@end
