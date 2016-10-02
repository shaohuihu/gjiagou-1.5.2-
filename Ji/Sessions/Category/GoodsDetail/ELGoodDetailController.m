//
//  ELGoodDetailController.m
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodDetailController.h"
#import "ELGoodsTopView.h"
#import "ELGoodsBottomView.h"
#import "ELGoodsTableView.h"
#import "ELCatoryService.h"
#import "ELGoodsDetailModel.h"
#import "ELGoodsCommentModel.h"
#import "ELCommentListCell.h"
#import "ELSpecificationView.h"
#import "ELMainShopController.h"
#import "ELShopController.h"
#import "ELShopSearchController.h"
#import "DBNodataView.h"
#import "DBGoodsAddressViewController.h"
#import "AddressListModel.h"
#import "ELCheckoutController.h"
#import "ELCartListModel.h"
#import "ELGoodsPrice.h"
//这里是为了添加购物车而添加的东西
#import "ELMineOrderItemView.h"
#import "ELShopService.h"
//友盟分享
#import "UMSocial.h"
#import "SDWebImageManager.h"
@interface ELGoodDetailController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate,
    ELCommentListCellDelegate,
    ELGoodsTableViewDelegate,
    ELGoodsBottomViewDelegate
>

@property (nonatomic, strong) ELGoodsTopView *topView;

@property (nonatomic, weak  ) UIView *contentView;
@property (nonatomic, strong) ELGoodsBottomView *bottomView;
@property (nonatomic, weak  ) UIScrollView *scrollView;
@property (nonatomic, strong) UIWebView *callWebView;
@property (nonatomic, strong) DBNodataView *noDadaView;


/**
 *  视图
 */
@property (nonatomic, strong) ELGoodsTableView *goodsTableView;
@property (nonatomic, weak  ) UIWebView *webView;
@property (nonatomic, weak  ) UITableView *commentTableView;

@property (nonatomic, strong) ELSpecificationView *specView;
/**
 *  model
 */
@property (nonatomic, strong) ELGoodsDetailModel *goodsDetailModel;
@property (nonatomic, strong) NSMutableArray *comments;

@end

@implementation ELGoodDetailController
{
    NSInteger curPage_;
    NSString * tempS;
    __block NSInteger totalCount;
    //添加商品规格
    NSString * value_;

}
//-(void)viewWillAppear:(BOOL)animated{
//    UIImage* img=[UIImage imageNamed:@"ic_back_button"];
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    btn.frame =CGRectMake(0, 0,11, 20);
//    
//    [btn setBackgroundImage:img forState:UIControlStateNormal];
//    
//    [btn addTarget: self action: @selector(doback) forControlEvents: UIControlEventTouchUpInside];
//    
//    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:btn];
//    
//    self.navigationItem.leftBarButtonItem=item;
//    
//    
//
//}
- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
[self.specView clear];
    
    

    
}

-(void)doback{
    DDLog(@"商品详情页自定制成功");
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)o_configDatas {
    _comments = [NSMutableArray arrayWithCapacity:0];
}

#pragma mark-这个是我添加的一个方法，视图将要出现的时候刷新一下数据
#warning 我给你注掉了，底部tabbar的问题就解决了。

- (void)o_viewLoad {
    UIImage *shopImage  = [[UIImage imageNamed:@"ic_shop_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [ELShopService getCartListWithBlock:^(BOOL success, id result) {
        if (success) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSArray *array = result[@"goods_list"];
                totalCount = 0;
                array = [ELCartListModel mj_objectArrayWithKeyValuesArray:array];
                [array enumerateObjectsUsingBlock:^(ELCartListModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                    [model.goodslist enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        totalCount += obj.goods_number;
                    }];
                }];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    DDLog(@"今天又是周一了%ld",(long)totalCount);
                    
                    /***************在这里要添加一个可以让这个按钮显示数量的东西***************/
                    //设置一个label来添加购物车的数量
                    
                    UILabel * messageL=[[UILabel alloc]init];
                    messageL.frame=CGRectMake(CGRectGetMaxX(button.frame)+18, button.frame.origin.y-6, 16, 16);
                    messageL.backgroundColor=[UIColor redColor];
                    
                    NSString * numS=[NSString stringWithFormat:@"%ld",(long)totalCount];
                    //NSString * numSS=[NSString stringWithFormat:@"%ld",(long)_goodNum];
                    // NSInteger temNT=_goodNum;
                    
                    //                    if (_goodNum>totalCount) {
                    //                       // messageL.text=numSS;
                    //
                    //                    }
                    //                    else{
                    messageL.text=numS;
                    //}
                    
                    messageL.textAlignment=NSTextAlignmentCenter;
                    messageL.textColor=[UIColor whiteColor];
                    messageL.font=[UIFont systemFontOfSize:12];
                    messageL.layer.cornerRadius=8;
                    messageL.clipsToBounds=YES;
                    if (totalCount==0) {
                        messageL.hidden=YES;
                    }
                    else{
                        [button addSubview:messageL];
                        
                    }
                    
                    
                    [button setImage:shopImage forState:UIControlStateNormal];
                    [button sizeToFit];
                    
                    [button addTarget:self action:@selector(onShopTap:) forControlEvents:UIControlEventTouchUpInside];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
                    
                    
                    
                    
                    self.navigationItem.rightBarButtonItems = @[self.notiItem,item];
                    
                    self.navigationItem.titleView = self.topView;
                    
                    
                });
            });
        }
    }];
    

}

- (void)o_configViews {
    //自定制返回的按钮
               
        
    

    
    
    
    
    [self.view addSubview:self.bottomView];
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = YES;
    scrollView.delegate = self;
    [self.view addSubview:self.scrollView = scrollView];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = EL_BackGroundColor;
    [scrollView addSubview:self.contentView = contentView];
    
//商品
    ELGoodsTableView *goodsTableView = [[ELGoodsTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    goodsTableView.goodsDelegate = self;
    [contentView addSubview: self.goodsTableView = goodsTableView];
    
    [contentView addSubview:self.noDadaView];
    self.noDadaView.hidden = YES;
//详情
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    webView.backgroundColor = [UIColor blackColor];
    [contentView addSubview:self.webView = webView];
    
//评论
    UITableView *tableView               = [[UITableView alloc] init];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    [tableView registerClasses:@[@"ELCommentListCell"]];
    [contentView addSubview:self.commentTableView = tableView ];
    
    WS(ws);
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        curPage_ = 1;
        [ws p_loadComments];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        curPage_++;
        [ws p_loadComments];
    }];
    [tableView.mj_header beginRefreshing];

/** 布局 **/
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.view);
        make.bottom.equalTo(ws.bottomView.top);
    }];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
        make.width.equalTo(3*SCREEN_WIDTH);
    }];
    
    [goodsTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(contentView);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    [self.noDadaView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(goodsTableView);
    }];
    
    [webView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(goodsTableView);
        CGFloat width =  790/2 < SCREEN_WIDTH ? 790/2 : SCREEN_WIDTH;
        make.width.equalTo(width);
        make.centerX.equalTo(goodsTableView.right).offset(SCREEN_WIDTH/2);
//        make.left.equalTo(goodsTableView.right);
    }];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.width.equalTo(goodsTableView);
        make.left.equalTo(SCREEN_WIDTH*2);
    }];

}


- (void)o_loadDatas {
    
    WS(ws);
    [ELCatoryService getGoodsDetailWithGoodsId:self.goodId block:^(BOOL success, id result) {
        if (success) {
            self.noDadaView.hidden = YES;
            _goodsDetailModel = [ELGoodsDetailModel mj_objectWithKeyValues:result];
            
#pragma mark-把要分享的东西存到沙盒里面
          NSDictionary * shareDATA=result[@"goods"];
            
            NSString * name=[shareDATA objectForKey:@"name"];
            NSString * imageURL=[shareDATA objectForKey:@"imgUrl"];
            DDLog(@"分享的名字%@",name);
            DDLog(@"分享的图片%@",imageURL);
            /*
             * 把要分享的商品的名字和图片保存到沙盒里
             */
            
            NSUserDefaults * shareNameNSU=[NSUserDefaults standardUserDefaults];
            [shareNameNSU setObject:name forKey:@"shareName"];
            
            NSUserDefaults * shareURL=[NSUserDefaults standardUserDefaults];
            [shareURL setObject:imageURL forKey:@"shareURL"];

            ws.goodsTableView.goodsDetailModel = _goodsDetailModel;
           
            self.bottomView.collectButton.selected = _goodsDetailModel.goods.collected;
            [self.webView loadHTMLString:_goodsDetailModel.goods.intro baseURL:nil];
            [ws.goodsTableView reloadData];
        }else{
            if (result == nil) {
                self.noDadaView.hidden = NO;
                self.scrollView.scrollEnabled = NO;
                self.bottomView.hidden = YES;
            }else{
                [self.view el_makeToast:result];
            }
//            [self.view el_makeToast:result];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
            
        }
    }];
    
}

#pragma mark - Private 

- (void)p_loadComments{
    WS(ws);
    [ELCatoryService getGoodsCommentsGoodsId:self.goodId page:curPage_ block:^(BOOL success, id result) {
        [ws p_endRefresh];
        if (success) {
            NSArray *array = result[@"goodsDiscussList"];
            if (curPage_ == 1) {
                [_comments removeAllObjects];
                [_comments addObjectsFromArray:[ELGoodsCommentModel mj_objectArrayWithKeyValuesArray:array]];
                if (_comments.count > 0) {
                    NSInteger commentCount =  [(NSNumber *)result[@"goodsDiscussListCount"] integerValue];
                    [self.goodsTableView setGoodsCommentModel:_comments.firstObject commentCount:commentCount];
                }
            }else{
                [_comments addObjectsFromArray:[ELGoodsCommentModel mj_objectArrayWithKeyValuesArray:array]];
            }
            [ws.commentTableView reloadData];
        }
    }];
}

- (void)p_endRefresh{
    if (self.commentTableView.mj_header.isRefreshing) {
        [self.commentTableView.mj_header endRefreshing];
    }
    if (self.commentTableView.mj_footer.isRefreshing) {
        [self.commentTableView.mj_footer endRefreshing];
    }
}


#pragma mark - Response 
//点击进入购物车
- (void)onShopTap:(UIBarButtonItem *)item {
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    ELShopController *vc = [[ELShopController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELCommentListCell"];
    cell.delegate = self;
    [cell setData:_comments[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ELGoodsBottomViewDelegate

- (void)bottomViewOnJoinCartTap//购物车
{

    
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    if ([self.specView didSelectAll] == NO) {
        self.specView.fromCart = YES;
        [self.specView showInView:self.view.window];
        return;
    }
    DDLog(@"明天不上班%lu",(unsigned long)self.goodsDetailModel.goods.specification.count);
    if (self.goodsDetailModel.goods.specification.count == 0) {
        NSString *price = [NSString stringWithFormat:@"%.2f",self.goodsDetailModel.goods.price];
        NSString *storage = [NSString stringWithFormat:@"%ld",(long)self.goodsDetailModel.goods.storage];
        //保存商品到购物车
   /*****************************在这里我有改变的东西，我加了一个channe：2******************************/
        [ELCatoryService addGoodsToCart:self.goodsDetailModel.goods.goodsId price:DBPRICE(price) count:self.specView.goodsCount storage:storage spec:@"" channel:2  block:^(BOOL success, id result1) {
            if (success) {
                ELShopController *vc = [[ELShopController alloc] init];
                [self.specView onSelfTap];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self.view el_makeToast:result1];
            }
        }];
    }else{//就是self.goodsDetailModel.goods.specification.count
        
        if (self.specView.priceModel) {
            if (self.specView.priceModel.stock.integerValue == 0) {
                [self.view el_makeToast:@"暂无库存!"];
            }else{
                WS(ws);
                __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                [ws.specView.parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [array addObject:[NSString stringWithFormat:@"%@:%@",obj[@"key"],obj[@"value"]]];
                }];
                NSString *standard = [array componentsJoinedByString:@","];
                
                NSString *price = self.specView.priceModel.price;
                NSString *stock = self.specView.priceModel.stock;
                
/*****************************在这里我有改变的东西，我加了一个channe：2******************************/
       //把商品加入到购物车
                               [ELCatoryService addGoodsToCart:self.goodsDetailModel.goods.goodsId price:price count:self.specView.goodsCount storage:stock spec:standard channel:2 block:^(BOOL success, id result1) {
                    if (success) {
                        ELShopController *vc = [[ELShopController alloc] init];
                        [self.specView onSelfTap];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [self.view el_makeToast:result1];
                    }
                }];
            }
        }
    }
}
#pragma mark -- 立即购买
-(void)bottomViewOnCreateOrderTapWithValue:(NSString*)value{
    value_ = value;
    [self bottomViewOnCreateOrderTap];
    
}



- (void)bottomViewOnCreateOrderTap//购买
{
  
    
    
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    if ([self.specView didSelectAll] == NO) {
        self.specView.fromBuy = YES;
        [self.specView showInView:self.view.window];
        return;
    }
    
    if (self.goodsDetailModel.goods.specification.count == 0) {
        NSString *price = [NSString stringWithFormat:@"%.2f",self.goodsDetailModel.goods.price];
        NSString *storage = [NSString stringWithFormat:@"%ld",(long)self.goodsDetailModel.goods.storage];
        WS(ws);
        //调用理解购买的接口
        [ELCatoryService saveCartForBillWithGoodsId:self.goodsDetailModel.goods.goodsId price:DBPRICE(price) count:self.specView.goodsCount storage:storage channel:2  standard:value_  block:^(BOOL success, id result) {
            if (success) {
                NSNumber *cartId = result[@"cartId"];
                              
                
                //立即购买
                [ELCatoryService bugGoodNowWithCartId:cartId block:^(BOOL success, id result) {
                    if (success) {
                        id obj = result[@"defAdd"];
                        if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
                            DBGoodsAddressViewController *vc = [[DBGoodsAddressViewController alloc]init];
                            vc.notSelect = YES;
                            [ws.navigationController pushViewController:vc animated:YES];
                        }else{
                           

                            
                            AddressListModel *model = [AddressListModel mj_objectWithKeyValues:result[@"defAdd"]];
                            
                            ELCheckoutController *vc = [[ELCheckoutController alloc] init];
                            NSArray *arr = [ELCartGoodsModel mj_objectArrayWithKeyValuesArray:result[@"carts"]];
                           //我这里需要把数据进行解析存到沙盒里面，然后分享出去
//                            NSArray * shareData=result[@"carts"];
//                            NSDictionary * sharaDic=[sharaDic objectForKey:0];
//                            
                            
                            
                            vc.goods = [NSMutableArray arrayWithArray:arr];
                            vc.totalMoney = ws.goodsDetailModel.goods.postage + ws.specView.goodsCount * DBPRICE(price).doubleValue;
                            vc.postage = ws.goodsDetailModel.goods.postage;
                            vc.count = ws.specView.goodsCount;
                            vc.addressModel = model;
                            vc.price = DBPRICE(price);
                            vc.fromNow = YES;
                            vc.stardandValue=value_;
                            //vc.turnDic=dic;
                            vc.goodsDetailModel = self.goodsDetailModel;
                            vc.goodID=self.goodId;
                            if (ws.specView.superview ) {
                                [ws.specView hide];
                            }

                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }
                }];
            }
        }];
    }else{
        if (self.specView.priceModel) {
            if (self.specView.priceModel.stock.integerValue == 0) {
                [self.view el_makeToast:@"暂无库存!"];
                return;
            }else{
                WS(ws);
                //立即购买有规格
                [ELCatoryService saveCartForBillWithGoodsId:self.goodsDetailModel.goods.goodsId price:self.specView.priceModel.price count:self.specView.goodsCount storage:self.specView.priceModel.stock channel:2 standard:value_   block:^(BOOL success, id result) {
                    if (success) {
                        NSNumber *cartId = result[@"cartId"];
                       
                        [ELCatoryService bugGoodNowWithCartId:cartId block:^(BOOL success, id result) {
                            if (success) {
                                id obj = result[@"defAdd"];
                                if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
                                    DBGoodsAddressViewController *vc = [[DBGoodsAddressViewController alloc]init];
                                    vc.notSelect = YES;
                                    [self.navigationController pushViewController:vc animated:YES];
                                }else{

                                    AddressListModel *model = [AddressListModel mj_objectWithKeyValues:result[@"defAdd"]];
                                    NSArray *arr = [ELCartGoodsModel mj_objectArrayWithKeyValuesArray:result[@"carts"]];
                                    ELCheckoutController *vc = [[ELCheckoutController alloc] init];
                                    vc.goods = [NSMutableArray arrayWithArray:arr];
                                    vc.totalMoney = ws.goodsDetailModel.goods.postage + ws.specView.goodsCount * self.specView.priceModel.price.doubleValue;
                                    vc.postage = ws.goodsDetailModel.goods.postage;
                                    vc.count = ws.specView.goodsCount;
                                    vc.addressModel = model;
                                    vc.price = self.specView.priceModel.price;
                                    vc.fromNow = YES;
                                    vc.goodsDetailModel = self.goodsDetailModel;
                                    vc.stardandValue=value_;
                                    vc.goodID=self.goodId;
                                    if (ws.specView.superview ) {
                                        [ws.specView hide];
                                    }
                                    [self.navigationController pushViewController:vc animated:YES];
                                }
                            }
                        }];
                    }
                }];
            }
        }

    }

}

- (void)bottomViewPersonServiceTap//客服
{
    NSString *qqurl = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",_goodsDetailModel.shopInfo.qq];
    NSURL *url = [NSURL URLWithString:qqurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    webView.delegate = self;
    [self.callWebView loadRequest:request];
}

- (void)bottomViewOnCheckoutShopTap//商铺
{
    ELMainShopController  *vc = [ELMainShopController new];
    vc.shopId = self.goodsDetailModel.shopInfo.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)bottomViewOnAddFavShopTap//收藏
{
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    if (self.bottomView.collectButton.selected == YES) {
        [self.view el_makeToast:@"已收藏"];
    }else{
        [ELCatoryService addGoodsToFav:self.goodsDetailModel.goods.goodsId block:^(BOOL success, id result) {
            if (success) {
                self.bottomView.collectButton.selected = YES;
                [self.view el_makeToast:@"收藏成功!"];
            }else{
                [self.view el_makeToast:result];
            }
        }];
    }
    
}

#pragma mark - ELGoodsTableViewDelegate

- (void)goodsViewClickToCheckAllComments {
    [self.scrollView setContentOffset:CGPointMake(2*SCREEN_WIDTH, 0) animated:YES];
    self.topView.selectIndex = 2;
}


- (void)goodsViewStandardClick {
    self.specView.fromCart = NO;
    self.specView.fromBuy = NO;
    [self.specView showInView:self.view.window];
}
//这个是进店逛逛
- (void)goodsViewOnShopInfoTap {
    ELMainShopController  *vc = [ELMainShopController new];
    vc.shopId = self.goodsDetailModel.shopInfo.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}
//查看分类
- (void)goodsViewOnShopCategoryTap {
    ELShopSearchController * vc = [[ELShopSearchController alloc] init];
    vc.shopId = self.goodsDetailModel.shopInfo.shopId;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)doshare{
 /*
  * 把要分享的商品的名字和图片从沙盒里读出来
  */
    NSUserDefaults *getshareNameNSU=[NSUserDefaults standardUserDefaults];
    NSString * nameSS=[getshareNameNSU objectForKey:@"shareName"];
 
    NSUserDefaults *getshareURLNSU=[NSUserDefaults standardUserDefaults];
    NSString * imageUrlSS=[getshareURLNSU objectForKey:@"shareURL"];

    
    DDLog(@"在这里进行分析法");
    //易信的要设置type
    //分享图片资源
    NSString * basUrl=@"http://www.gjiagou.com";
    //SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //UIImage *cachedImage = [manager imageWithURL:url];
    UIImageView * ImageV=[[UIImageView alloc]init];
   // DDLog(@"打印一下图片的网址%@",imageUrlSS);
    
    
    
    NSString * urlS=[NSString stringWithFormat:@"%@%@",basUrl,imageUrlSS];
//  
//   [ImageV sd_setImageWithURL:ELIMAGEURL(imageUrlSS)];
    DDLog(@"打印网址%@",urlS);
    NSURL *url=[NSURL URLWithString:urlS];
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
   // UIImage * imag=ImageV.image;

    DDLog(@"参照物%@",imgFromUrl);
    
   //[[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:urlS];

    [UMSocialData defaultData].extConfig.alipaySessionData.alipayMessageType =      UMSocialAlipayMessageTypeText;
    //设置分享的内容
   
    [UMSocialData defaultData].extConfig.yxsessionData.yxMessageType =UMSocialYXMessageTypeText;
   
    //http://www.gjiagou.com/goods/detail?goodsId=551
    //拼接字符串
    NSString *baskUrl=@"http://www.gjiagou.com/goods/detail";
    NSString * good=@"goodsId";
    NSString * goodIDS=[NSString stringWithFormat:@"%ld",(long)self.goodId];
    NSString * Lstring=[NSString stringWithFormat:@"%@=%@",good,goodIDS];
    NSString * string=[NSString stringWithFormat:@"%@?%@",baskUrl,Lstring];
    DDLog(@"具体商品的网址%@",string);
    NSString *shareS=[NSString stringWithFormat:@"%@  %@",nameSS,string];
    [UMSocialData defaultData].extConfig.title = shareS;
    //设置微信的点击之后的网址
    [[UMSocialData defaultData].extConfig.wechatSessionData setUrl:string];
    //设置QQ点击之后的网址
     [[UMSocialData defaultData].extConfig.qqData setUrl:string];
    //设置QQ空间点击之后的网址
     [[UMSocialData defaultData].extConfig.qzoneData setUrl:string];
    //设置微信朋友圈点击之后的网址
     [[UMSocialData defaultData].extConfig.wechatTimelineData setUrl:string];
       //设置人人网点击之后的网址
     [[UMSocialData defaultData].extConfig.renrenData setUrl:string];
    //设置豆瓣网点击之后的网址
    // [[UMSocialData defaultData].extConfig.doubanData setUrl:@"http://www.gjiagou.com"];
    //设置音信易信点击之后的网址
     [[UMSocialData defaultData].extConfig.yxsessionData setUrl:string];
    //设置支付宝点击之后的网址
     [[UMSocialData defaultData].extConfig.alipaySessionData setUrl:string];
    //设置短信点击之后的网址
   //  [[UMSocialData defaultData].extConfig.smsData setUrl:@"http://www.gjiagou.com"];
    //设置邮件点击之后的网址
    // [[UMSocialData defaultData].extConfig.emailData setUrl:@"http://www.gjiagou.com"];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57a5391d67e58ed7db001b6e"
                                      shareText:shareS
                                     shareImage:imgFromUrl
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms,UMShareToTencent]
                                       delegate:self];
    [UMSocialData defaultData].extConfig.alipaySessionData.alipayMessageType = UMSocialAlipayMessageTypeText;
//    
//    [UMSocialData defaultData].extConfig.alipaySessionData.shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";

}

#pragma mark-这个方法是易信的回调方法
//实现回调方法：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    DDLog(@"发送分享的结果%u",response.responseCode);
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"分享的平台是多少 %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


- (void)goodsViewOnContactTap {
    NSString *phoneNum = _goodsDetailModel.shopInfo.phone;// 电话号码
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    NSURLRequest *request = [NSURLRequest requestWithURL:phoneURL];
    [self.callWebView loadRequest:request];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        self.topView.selectIndex = scrollView.mj_offsetX/SCREEN_WIDTH;
    }
}


#pragma mark - ELCommentListCellDelegate

- (void)cellNeedReload:(ELCommentListCell *)cell{
//    [self.commentTableView reloadData];
//    NSIndexPath *indexPath = [self.commentTableView indexPathForCell:cell];
//    [self.commentTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Getters

- (ELGoodsTopView *)topView {
    if (_topView == nil) {
        _topView = [[ELGoodsTopView alloc] initWithFrame:CGRectMake(0, 0, kRadioValue(190), 44)];
        _topView.el_centerX = SCREEN_WIDTH/2;
        WS(ws);
        [_topView setSelectBlock:^(NSInteger index){
            [ws.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 9) animated:YES];
        }];
    }
    return _topView;
}

- (ELGoodsBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView  = [[ELGoodsBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kRadioValue(40)-64, SCREEN_WIDTH, kRadioValue(40))];
        _bottomView.delegate = self;
    }
    return _bottomView;
}


- (ELSpecificationView *)specView {
    if (_specView == nil) {
        _specView = [[ELSpecificationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _specView.goodModel = self.goodsDetailModel;
        WS(ws);
        [_specView setCompletion:^{
            [ws.navigationController pushViewController:[ELShopController new] animated:YES];
        }];
        
//        [_specView setBuyBlock:^(NSString){
//            [ws bottomViewOnCreateOrderTap];
//        }];
        //根据1.4版本修改
        [_specView setBuyBlock:^(NSString *value){
            [ws bottomViewOnCreateOrderTapWithValue:value];
        }];

    }
    return _specView;
}

- (UIWebView *)callWebView {
    if (_callWebView == nil) {
        _callWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_callWebView];
    }
    return _callWebView;
}

- (DBNodataView *)noDadaView {
    if (_noDadaView == nil) {
        _noDadaView = [DBNodataView new];
        [_noDadaView setImage:@"ic_person_product_img" andUpLabel:@"抱歉，该商品不存在或已被下架" andDownLabel:nil andBtn:nil];
    }
    return _noDadaView;
}
//设置协议可以来完成分享
//- (void)onRightButtonTap{
//    if ([self.delegate respondsToSelector:@selector(doshare)]) {
//        DDLog(@"我马上就要完成分享了");
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
