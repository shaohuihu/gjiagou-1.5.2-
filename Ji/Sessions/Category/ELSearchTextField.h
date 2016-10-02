//
//  ELSearchTextField.h
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELSearchTextField : UITextField

@property (nonatomic, copy) void(^completion)(NSString *text);
@property (nonatomic, copy) void(^textDidChange)(NSString *text);
@property (nonatomic, copy) void(^beginEditing)();

@end
