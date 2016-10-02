//
//  ELSpecificationView.m
//  Ji
//
//  Created by evol on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELSpecificationView.h"
#import "ELSpecificationCell.h"
#import "ELGoodsDetailModel.h"
#import "ELSpecificationCell.h"
#import "ELSpecCountCell.h"
#import "ELCatoryService.h"
#import "ELShopController.h"
#import "ELGoodsPrice.h"

@interface ELSpecificationView ()<UITableViewDelegate,UITableViewDataSource,ELSpecificationCellDelegate,ELSpecCountCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIImageView *goodsIcon;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *storgeLabel;

@end

@implementation ELSpecificationView{
    NSString * stardandValue;
    UIView *contentView;
    UITableView * tableView;
}


- (instancetype)init
{
   

    self = [super init];
    if (self) {
        [self p_setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}

#pragma mark - Setter



#pragma mark - Private

- (void)p_setUp {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
        //监听键盘出现
        [[NSNotificationCenter defaultCenter] addObserver:self
    
                                                 selector:@selector(keyboardWasShown:)
    
                                                     name:UIKeyboardDidShowNotification object:nil];
    
        //添加手势点击空白处键盘消失
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self.contentView addGestureRecognizer:tapGestureRecognizer];
        
    

    
    
    
    
    self.goodsCount = 1;
    _parameters = [NSMutableArray arrayWithCapacity:0];
    
    [self addTarget:self action:@selector(onSelfTap) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    
    /*
     *  在这里进行判断如果我点击了弹出键盘改变contenView的坐标
     */
    
    
    contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, kRadioXValue(180), self.el_width, self.el_height - kRadioXValue(180));

    
        


    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView = contentView];
//top
    UIView *topView = [[UIView alloc] init];
//    if ([tagSS isEqualToString:@"1"]) {
    
        topView .frame= CGRectMake(0, 0, self.el_width, kRadioXValue(90));
        
//    }
//    else{
//        
//        
//        topView .frame= CGRectMake(0, 0, self.el_width, kRadioXValue(90));
//    }

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, -20, kRadioXValue(90), kRadioXValue(90))];
    imageView.backgroundColor = EL_BackGroundColor;
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    [topView addSubview:self.goodsIcon = imageView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.el_right + 13, kRadioXValue(20), 200, 15)];
    
#pragma mark-改变原来的storelabel的坐标
   

    priceLabel.textColor = EL_MainColor;
    priceLabel.font = kFont_System(14);
    [topView addSubview:self.priceLabel = priceLabel];
    
    UILabel *storgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.el_left, priceLabel.el_bottom + kRadioXValue(6), 200, 15)];
    storgeLabel.textColor = EL_TextColor_Dark;
    storgeLabel.font = kFont_System(14.f);
    [topView addSubview:self.storgeLabel = storgeLabel];
    
    UILabel *chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.el_left, storgeLabel.el_bottom + kRadioXValue(6), 200, 15)];
    chooseLabel.font = kFont_System(14.f);
    chooseLabel.textColor = EL_TextColor_Dark;
    chooseLabel.text = @"请选择";
    [topView addSubview:chooseLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(13, topView.el_height - 0.5, self.el_width - 13, 0.5)];
    lineView.backgroundColor = EL_Color_Line;
    [topView addSubview:lineView];
    
    [contentView addSubview:topView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"ic_deleter_address"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(onSelfTap) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton sizeToFit];
    [topView addSubview:cancelButton];
    cancelButton.el_top = 15;
    cancelButton.el_right = topView.el_width - 15;

    
// table
    
   
   // UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, kRadioXValue(90), self.el_width, contentView.el_height-44-kRadioXValue(90))];
    tableView=[[UITableView alloc]init];
//        tableView  .frame             = CGRectMake(0, kRadioXValue(90), self.el_width, contentView.el_height-44-kRadioXValue(90));
    
//     if ([tagSS isEqualToString:@"弹出键盘"]) {
//         tableView  .frame             = CGRectMake(0, kRadioXValue(90)-100, self.el_width, contentView.el_height-44-kRadioXValue(90));
//         [tableView reloadData];
//    }
//    else{
    NSUserDefaults *gettagsNSU=[NSUserDefaults standardUserDefaults];
    NSString * tagSS=[gettagsNSU objectForKey:@"keyboard"];
    DDLog(@"我啦啦啦啦啦啦啦啦%@",tagSS);
   
         tableView  .frame             = CGRectMake(0, kRadioXValue(90), self.el_width, contentView.el_height-44-kRadioXValue(90));
    //tableView.scrollEnabled=NO;
    
    
//
//
//    }
    
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
//    tableView.estimatedRowHeight         = 44;
     tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = [UIColor whiteColor];
   [tableView registerClasses:@[@"ELSpecificationCell",@"ELSpecCountCell"]];
        //[tableView registerClasses:@[@"ELSpecCountCell"]];

    [tableView clearExtraLine];
    [contentView addSubview:self.tableView = tableView ];
    
//bottom
    UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopButton setTitle:@"确定" forState:UIControlStateNormal];
    [shopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopButton setBackgroundColor:UIColorFromRGB(0xf08939)];
    [shopButton setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
    [shopButton addTarget:self action:@selector(onShopTap) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:shopButton];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyButton setBackgroundColor:UIColorFromRGB(0xcf2b28)];
    [buyButton setFrame:CGRectMake(shopButton.el_right, 0, SCREEN_WIDTH/2, 44)];
    //把立即购买的方法
    [buyButton addTarget:self action:@selector(onBuyTap) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:buyButton];

    shopButton.el_bottom = contentView.el_height;
    buyButton.el_bottom = contentView.el_height;
#pragma mark-在这里添加显示和隐藏键盘的方法
    //监听键盘是不是出现获取消失
    //监听键盘消失

//    CGFloat x=self.contentView.frame.origin.x;
//     CGFloat y=self.contentView.frame.origin.x;
//    CGFloat width=self.contentView.frame.size.width;
//    CGFloat height=self.contentView.frame.size.height;
//    self.contentView.frame=CGRectMake(x, y-100, width, height);
    
}

#pragma mark - Response

- (void)onSelfTap{
    [self.parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *value = obj[@"value"];
            
            [value bindBool:NO];
        }
    }];
    self.goodsCount = 1;
    [self hide];
}

- (void)clear{
    [self.parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *value = obj[@"value"];
            [value bindBool:NO];
        }
    }];
}

//键盘出现的方法
-(void)keyboardWasShown:(NSNotification * )note{

    NSString * tagS=@"1";
    NSUserDefaults * keyboardNSU=[NSUserDefaults standardUserDefaults];
    [keyboardNSU setObject:tagS forKey:@"keyboard"];
    
        DDLog(@"我在view里面监听到了键盘弹出了");
     CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    tableView .frame             = CGRectMake(0, kRadioXValue(90), self.el_width, contentView.el_height-44-kRadioXValue(90)-keyBoardRect.size.height);
    //[tableView reloadData];
    //tableView.scrollEnabled=NO;
    
    
}


#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    tableView .frame             = CGRectMake(0, kRadioXValue(90), self.el_width, contentView.el_height-44-kRadioXValue(90));
    //[tableView reloadData];
    

    DDLog(@"我在view里面监听到了键盘的消失");
    
    
}
//tableView滑动消失键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //方式一
    [self.contentView endEditing:YES];
 
}





//确定
- (void)onShopTap{
   
    //DDLog(@"这个是我的%@",self.fromBuy);
    
    //在确定的方法里面有我改动过的地方，原来的是等于，现在我让他不等于了（在他前面加了个！号）
    //fromCart是用来判断是点击加入购物车进来的，还是直接点击商品规格进来的
//  
//    if (self.fromCart) {
//        [self addCart];
//        
//        
//        
//    }else if (self.fromBuy){
//        [self onBuyTap];
//        
//    }else{
//        
//        if ([self didSelectAll] == NO) {
//            
//            [self el_makeToast:@"请先选择属性"];
//            return;
//        }
//    //让团出来的视图在0.3秒内消失
//        [self hide];
//    }
   
    if ([self didSelectAll]==YES) {
       [self addCart];
       
    }
    else{
        
        //[self el_makeToast:@"请先选择属性"];
        
        return;
    }
    [self hide];
    
    
    
}

- (void)addCart{
  
    DDLog(@"%lu",(unsigned long)self.goodModel.goods.specification.count);
    
    if ([self didSelectAll] == NO) {
       [self el_makeToast:@"请先选择属性"];
       
        return;
    }
    
    if (self.goodModel.goods.specification.count == 0) {
        NSString *price = [NSString stringWithFormat:@"%.2f",self.goodModel.goods.price];
        NSString *storage = [NSString stringWithFormat:@"%ld",(long)self.goodModel.goods.storage];
        WS(ws);
        [ELCatoryService addGoodsToCart:self.goodModel.goods.goodsId price:DBPRICE(price) count:self.goodsCount storage:storage spec:@"" channel:2 block:^(BOOL success, id result1) {
            if (success) {
                if (ws.completion) {
                    ws.completion();
                }
                [ws onSelfTap];
            }else{
                [ws el_makeToast:result1];
            }
        }];
    }else{
        if(self.priceModel){
            if (self.priceModel.stock.integerValue == 0) {
                [self el_makeToast:@"暂无库存!"];
            }else{
                [self p_insertCart];
            }
        }
    }
  
    
    
    
    
}


- (void)p_insertCart{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    [self.parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@:%@",obj[@"key"],obj[@"value"]]];
    }];
    NSString *standard = [array componentsJoinedByString:@","];
    WS(ws);
    [ELCatoryService addGoodsToCart:self.goodModel.goods.goodsId price:self.priceModel.price count:self.goodsCount storage:self.priceModel.stock spec:standard channel:2 block:^(BOOL success, id result) {
        if (success) {
            if (ws.completion) {
                ws.completion();
            }
            [self onSelfTap];
        }else{
            [self el_makeToast:result];
        }
    }];

}

- (void)onBuyTap{
    
    if ([self didSelectAll] == NO) {
        [self el_makeToast:@"请先选择属性"];
        return;
    }
    
    if (self.buyBlock) {
        self.buyBlock(stardandValue);
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodModel.goods.specification.count+1;
    //return  self.goodModel.goods.specification.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell;
    if (indexPath.row == self.goodModel.goods.specification.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ELSpecCountCell"];
       
        [cell setData:nil];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"ELSpecificationCell"];
        [cell setData:self.goodModel.goods.specification[indexPath.row] index:indexPath];
    }
    cell.delegate = self;
    return cell;
}

#pragma mark - ELSpecificationCellDelegate

- (void)specCell:(ELSpecificationCell *)cell didSelectWithKey:(NSString *)key value:(NSString *)value
{
    stardandValue = [NSString stringWithFormat:@"%@:%@",key,value];
    [ELCatoryService getStandardImageWithGoodsId:self.goodModel.goods.goodsId standard:value block:^(BOOL success, id result) {
        if(success){
            NSString *img = result[@"image"];
            if ([img isKindOfClass:[NSString class]] && img.length > 0) {
                NSURL *url = [NSURL URLWithString:[[[HTTP_BASE_IMAGE_URL stringByAppendingString:@"imgs/"] stringByAppendingString:img] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

                [self.goodsIcon sd_setImageWithURL:url];
            }
        }else{
            [self el_makeToast:result];
        }
    }];
    [_parameters replaceObjectAtIndex:cell.indexPath.row withObject:@{@"key":key,@"value":value}];
    
    if ([self didSelectAll]) {
        __block NSMutableArray *array0 = [NSMutableArray arrayWithCapacity:0];
        [self.parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array0 addObject:obj[@"value"]];
        }];
        NSString *spec = [array0 componentsJoinedByString:@","];
        [ELCatoryService getStandardPriceWithGoodsId:self.goodModel.goods.goodsId standard:spec block:^(BOOL success, id result) {
            if (success) {
                _priceModel = [ELGoodsPrice mj_objectWithKeyValues:result];
                NSString *price = [NSString stringWithFormat:@"￥%.2f",_priceModel.price.doubleValue];
                self.priceLabel.text = DBPRICE(price);
                self.storgeLabel.text = [NSString stringWithFormat:@"库存%@",_priceModel.stock];
                DDLog(@"库存值%@",_priceModel.stock);
                //将数据存到沙盒中
                NSUserDefaults * storgeNSU=[NSUserDefaults standardUserDefaults];
                [storgeNSU setObject:_priceModel.stock forKey:@"storgerNum"];
                //在这里发送一个通知
                
                NSDictionary * Noticdic=[NSDictionary dictionaryWithObject:_priceModel.stock forKey:@"stock"];
                
                //创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:Noticdic];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                
                [self setNeedsDisplay];
            }else{
                _priceModel = nil;
            }
        }];
    }
}


#pragma mark - ELSpecCountCellDelegate 
- (void)countCellDidChange:(NSInteger)count{
    self.goodsCount = count;
}

- (NSInteger)getOriginCount{
    return self.goodsCount;
}

#pragma mark - Public
- (void)showInView:(UIView *)view {
    self.contentView.el_top = SCREEN_HEIGHT;
    [view addSubview:self];
    [self reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.el_top = kRadioXValue(180);
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.el_top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        NSString * tagS=@"1";
        NSUserDefaults * textNSU=[NSUserDefaults standardUserDefaults];
        [textNSU setObject:tagS forKey:@"textFeild"];
    }];
}

#pragma mark - Setters 

- (void)setGoodModel:(ELGoodsDetailModel *)goodModel {
    _goodModel = goodModel;
    [self.goodsIcon sd_setImageWithURL:ELIMAGEURL(goodModel.goods.imgUrl)];
    NSString *price = [NSString stringWithFormat:@"￥%.2f",goodModel.goods.price];
    self.priceLabel.text = DBPRICE(price);
    self.storgeLabel.text = [NSString stringWithFormat:@"库存%ld",(long)goodModel.goods.storage];
    NSString * storageS=[NSString stringWithFormat:@"%ld",(long)goodModel.goods.storage];
    NSUserDefaults * storgeNSU=[NSUserDefaults standardUserDefaults];
    [storgeNSU setObject:storageS   forKey:@"storgerNum"];
    [self.goodModel.goods.specification enumerateObjectsUsingBlock:^(ELGoodsSpecification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_parameters addObject:[NSNull null]];
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
    
}


- (BOOL)didSelectAll {
    __block BOOL isAll = YES;
    [self.parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            isAll = NO;
            *stop = YES;
        }
    }];
    return isAll;
}

@end
