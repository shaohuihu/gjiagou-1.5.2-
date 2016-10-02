//
//  ELLoginFooterView.h
//  Ji
//
//  Created by sbq on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchDeleget <NSObject>

-(void)touchWithBtn:(UIButton*)btn;

@end

@interface ELLoginFooterView : UIView
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *forgetBtn;
@property(nonatomic,strong)id<TouchDeleget>delegate;
@end
