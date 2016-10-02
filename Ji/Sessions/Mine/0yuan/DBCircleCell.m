//
//  DBCircleCell.m
//  Ji
//
//  Created by ssgm on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBCircleCell.h"
#import "DBMineService.h"
#define Items   3
@interface DBTitleCell : ELRootCell

@end
@implementation DBCircleCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    
    NSArray *titles = @[@"还没有抽奖码",@"还没有抽奖码",@"还没有抽奖码"];
     [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         UIView *view = [UIView new];
         view.tag = 100+idx;
         [self.contentView addSubview:view];
         
         UIImageView *imageview = [UIImageView new];
         imageview.tag = 200+idx;
         [view addSubview:imageview];
         

         
         UILabel *nameLabel = [UILabel new];
         nameLabel.font = kFont_System(13);
         nameLabel.textAlignment = NSTextAlignmentCenter;
         nameLabel.textColor = EL_TextColor_Dark;
         nameLabel.text = obj;
         nameLabel.tag = 300+idx;

         [view addSubview:nameLabel];
         
         UILabel *tipLabel = [UILabel new];
         tipLabel.font = kFont_System(13);
         tipLabel.textAlignment = NSTextAlignmentCenter;
         tipLabel.textColor = [UIColor whiteColor];
         tipLabel.tag = 400+idx;
         [view addSubview:tipLabel];
         tipLabel.text = [NSString stringWithFormat:@"0%lu",(long)(idx+1)];
         
         CGFloat width = SCREEN_WIDTH/3;
         WS(ws);
         
         [view makeConstraints:^(MASConstraintMaker *make) {
             make.height.equalTo(ws.contentView);
             make.width.equalTo(SCREEN_WIDTH/3);
             make.height.equalTo(kRadioXValue(125));
             make.left.equalTo(width*idx);
         }];
         
         //73
         [imageview makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(15);
             make.centerX.equalTo(view);
             make.width.equalTo(kRadioXValue(73));
             make.height.equalTo(kRadioXValue(73));
         }];
         [nameLabel makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(imageview.bottom);
             make.bottom.equalTo(view);
             make.left.equalTo(view);
             make.right.equalTo(view);
         }];
         [tipLabel makeConstraints:^(MASConstraintMaker *make) {
             make.center.equalTo(imageview);
             
         }];
         
     }];
    
    


    
}

-(void)o_dataDidChanged{
    
    if ([self.data isKindOfClass:[NSArray class]]) {
        NSArray *array = self.data;
        [@[@"",@"",@""] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *view = (UIView*)[self.contentView viewWithTag:100+idx];
            UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:200+idx];
            UILabel *nameLabel = (UILabel*)[self.contentView viewWithTag:300+idx];
            UILabel *tipLabel = (UILabel*)[self.contentView viewWithTag:400+idx];
            //这个是没有签到的时候的图片
            imageView.image = [UIImage imageNamed:@"ic_zero-bg-nonub"];
            tipLabel.text = @"";
            
            if (idx<array.count) {
                [DBMineService lotteryWithUid:UidStr count:20 page:1 block:^(BOOL success, id result) {
                    
                    if(success){
                        
                        
                        
                        
                        /****************在这里面我要对数据进行改动************************/
                        
                        NSMutableArray *  temA=[NSMutableArray array];
                        temA=result[@"lc"];
                        NSDictionary * DATA1=[NSDictionary dictionary];
                        NSString * temS=[NSString string];
                        NSMutableArray * array1=[NSMutableArray array];
                        for (int i=0; i<temA.count; i++) {
                            DATA1 =[temA objectAtIndex:i];
                            temS=[DATA1 objectForKey:@"goodsPicture"];
                            //
                            if (![temS isKindOfClass:[NSNull class]]) {
                                [array1 addObject:temS];
                            }
                            
                            
                            /***********************这里面有需要改动的，如何根据tag确定imageV的图片*********************/
                            //1.进行1此判断，如果temS不为空，则加到数组里面
                            //2.根据数组里面的数据，判定imageView
                            
                        }
                        DDLog(@"*****%@",array1);
                        switch (array1.count) {
                            case 0:
                                imageView.image = [UIImage imageNamed:@"ic_zero-bg-numb"];
                                break;
                            case 1:
                                if (imageView.tag==200) {
                                    
                                    
                                    // NSString * string1=HTTP_BASE_IMAGE_URL;
                                    NSString * string2=[array1 objectAtIndex:0];
                                    
                                    [imageView sd_setImageWithURL:ELIMAGEURL(string2)];
                                    ;
                                    
                                    
                                    DDLog(@"跪求网址%@",ELIMAGEURL(string2));
                                    
                                }
                                
                                else{
                                    
                                    imageView.image = [UIImage imageNamed:@"ic_zero-bg-numb"];
                                }
                                break;
                            case 2:
                                if (imageView.tag==200 ) {
                                    NSString * string2=[array1 objectAtIndex:0];
                                    
                                    [imageView sd_setImageWithURL:ELIMAGEURL(string2)];
                                    ;
                                }
                                else if (imageView.tag==201){
                                    NSString * string2=[array1 objectAtIndex:1];
                                    
                                    [imageView sd_setImageWithURL:ELIMAGEURL(string2)];
                                    ;
                                    
                                    
                                }
                                
                                else{
                                    
                                    imageView.image = [UIImage imageNamed:@"ic_zero-bg-numb"];
                                }
                                break;
                            case 3:
                                if (imageView.tag==200) {
                                    NSString * string2=[array1 objectAtIndex:0];
                                    
                                    [imageView sd_setImageWithURL:ELIMAGEURL(string2)];
                                    ;
                                }
                                else if (imageView.tag==201){
                                    NSString * string2=[array1 objectAtIndex:1];
                                    
                                    [imageView sd_setImageWithURL:ELIMAGEURL(string2)];
                                    ;
                                    
                                    
                                }
                                else{
                                    NSString * string2=[array1 objectAtIndex:2];
                                    
                                    [imageView sd_setImageWithURL:ELIMAGEURL(string2)];
                                    ;
                                }
                                
                                
                                
                                break;
                                
                                
                            default:
                                break;
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                }];
                
                
                
                
                
                
  
                
                
                
                //imageView.image = [UIImage imageNamed:@"ic_zero-bg-numb"];
                nameLabel.text = @"我的抽奖码";
                nameLabel.textColor = EL_TextColor_Dark;
                tipLabel.text = [NSString stringWithFormat:@"0%lu",(long)(idx+1)];
            }else{
                imageView.image = [UIImage imageNamed:@"ic_zero-bg-nonub"];
                nameLabel.text = @"还没有抽奖码";
                nameLabel.textColor = EL_TextColor_Light;
            }
        }];
        
        
    }
}
@end
