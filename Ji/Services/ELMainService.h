//
//  ELMainService.h
//  Ji
//
//  Created by evol on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DianQiCheng (348)
#define JiJiaHui    (341)
/******************数据改动，正确的为345，测试用的是304*********************/
#define BenDiTeChan (345)
//#define BenDiTeChan (304)
@interface ELMainService : NSObject
+ (NSURLSessionDataTask *)getAreasWithBlock:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getBannerWithAreaId:(NSString *)areaId block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getHotGoods:(NSString *)areaId block:(AFCompletionBlock)block;//首页热门商品
+ (NSURLSessionDataTask *)getHotGoodsCategory:(NSString *)areaId block:(AFCompletionBlock)block;//首页热门楼层商品
//热卖功能
+ (NSURLSessionDataTask *)getHomeGoods:(NSString *)areaId page:(NSInteger)page count:(NSInteger)count block:(AFCompletionBlock)block;
//热门店铺
+ (NSURLSessionDataTask *)getHotShop:(NSString *)areaId page:(NSInteger)page block:(AFCompletionBlock)block;
//商铺首页
+ (NSURLSessionDataTask *)getShopHome:(NSInteger)shopId page:(NSInteger)page block:(AFCompletionBlock)block;
//商品分类
+ (NSURLSessionDataTask *)getShopCategory:(NSInteger)shopId block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getShopCategory1:(NSInteger)shopId block:(AFCompletionBlock)block;

//收藏商铺
+ (NSURLSessionDataTask *)addShopFavList:(NSInteger)shopId uId:(NSInteger)uId block:(AFCompletionBlock)block;
//是否收藏
+ (NSURLSessionDataTask *)isShopFavList:(NSInteger)shopId uId:(NSInteger)uId block:(AFCompletionBlock)block;
//商铺分类下的商品
+ (NSURLSessionDataTask *)getShopCategoryGoods:(NSInteger)shopId categoryId:(NSInteger)categoryId level:(NSInteger)level pageNo:(NSInteger)pageNo block:(AFCompletionBlock)block;
//搜索商铺商品
+ (NSURLSessionDataTask *)getShopSearchWithShopId:(NSInteger)shopId text:(NSString *)text pageNo:(NSInteger)pageNo block:(AFCompletionBlock)block;

/**  0元购  **/
//我的0元购
+ (NSURLSessionDataTask *)getMy0YuanGouWithUserId:(NSInteger)uid block:(AFCompletionBlock)block;
//会员是否签到
+ (NSURLSessionDataTask *)is0SignIn:(NSInteger)uid block:(AFCompletionBlock)block;
//会员签到
+ (NSURLSessionDataTask *)signInWithUserId:(NSInteger)uid block:(AFCompletionBlock)block;
//抽奖页面数据
+ (NSURLSessionDataTask *)getDraw0YuanDataWithAreaId:(NSString *)areaId block:(AFCompletionBlock)block;
//中奖名单
+ (NSURLSessionDataTask *)getWinnerListWithAreaId:(NSString *)areaId block:(AFCompletionBlock)block;
//中奖商品详情
+ (NSURLSessionDataTask *)getDrawGoodsDetailWithGoodsId:(NSInteger)goodsId block:(AFCompletionBlock)block;
//抽奖商品详情
+ (NSURLSessionDataTask *)getDrawDetailWithDrawId:(NSInteger)drawId block:(AFCompletionBlock)block;
//抽奖功能
+ (NSURLSessionDataTask *)getDrawingWithDrawId:(NSInteger)drawId userId:(NSInteger)uid block:(AFCompletionBlock)block;
//我的代金券
+ (NSURLSessionDataTask *)getVouchersDetailWithUID:(NSInteger)uid block:(AFCompletionBlock)block;
//判断是否使用了代金券
+ (NSURLSessionDataTask *)getVouchersWhetherWithcartIds:(NSArray *)cartIds uid:(NSInteger)uid block:(AFCompletionBlock)block;
//活动规则
+ (NSURLSessionDataTask *)getRulesWithBlock:(AFCompletionBlock)block;

//活动弹层
+ (NSURLSessionDataTask *)getThicknessWithBlock:(AFCompletionBlock)block;

//用来改变iosShow的数目
+ (NSURLSessionDataTask *)ChangenumberWithUID:(NSInteger )uid iosShow:(NSString *)iosShow block:(AFCompletionBlock)block;

@end
