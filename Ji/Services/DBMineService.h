//
//  DBMineService.h
//  Ji
//
//  Created by sbq on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMineService : NSObject
//user/info
/**
 *  用户信息
 *
 *  @param uid   uid
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)getUserInfoWithUid:(NSString*)uid block:(AFCompletionBlock)block;




#pragma mark---收货地址相关


//user/accAddress
/**
 *  查询收货地址集合
 *
 *  @param uid   用户id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)accAddressWithUid:(NSString*)uid block:(AFCompletionBlock)block;

/**
 *  保存收货地址
 *
 *  @param name          收货人姓名
 *  @param phone         手机号
 *  @param zipCode       邮编
 *  @param provinceName  省
 *  @param cityName      市
 *  @param countryName   县
 *  @param addressDetial 详细地址
 *  @param block
 *
 *  @return
 */

+ (NSURLSessionTask *)saveAddressWithAddressDic:(NSDictionary*)dic block:(AFCompletionBlock)block;


/**
 *  收货地址--修改页面
 *
 *  @param aid   地址主键值 session
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)eidtAddressWithAid:(NSString*)aid block:(AFCompletionBlock)block;



/**
 *  收货地址修改

 *  @return
 */
+ (NSURLSessionTask *)updateAddressWithDic:(NSDictionary*)dic block:(AFCompletionBlock)block;


/**
 *  收货地址删除
 *
 *  @param aid   主键值
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)deleteAddressWithId:(NSString*)aid block:(AFCompletionBlock)block;

/**
 *  设为默认收货地址
 *  @return
 *///{"session":{"uid":"327","sid":""},"address_id":"69","user_id":"327"}
+ (NSURLSessionTask *)updateAddressDefaultWithAid:(NSString*)aid block:(AFCompletionBlock)block;

/**
 *  返回省市集合
 *
 *  @param p_id  父级id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)regionWithParentId:(NSString*)p_id block:(AFCompletionBlock)block;



#pragma mark--用户设置
/**
 *  修改头像
 *
 *  @param uid      用户id
 *  @param fileData 图片文件
 *  @param block
 */
+ (void )accFaceWithUid:(NSString*)uid imageData:(NSData*)fileData block:(AFCompletionBlock)block;

/**
 *  修改密码
 *
 *  @param uid          用户id
 *  @param passwordOrig 旧密码
 *  @param passwordNew  新密码
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)updatePassWithUid:(NSString*)uid passwordOrig:(NSString*)passwordOrig passwordNew:(NSString*)passwordNew block:(AFCompletionBlock)block;

/**
 *  修改性别
 *
 *  @param uid   用户id
 *  @param sex   性别代码（0 1 2）男女保密
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)updateSexWithUid:(NSString*)uid sex:(NSString*)sex block:(AFCompletionBlock)block;


//获取手机验证码 http://www.gjiagou.com/api/user/bindMobile    json:  {'phone':15954705439}
+ (NSURLSessionTask *)bindMobileWithPhone:(NSString*)phone block:(AFCompletionBlock)block;
//修改绑定手机号：   http://www.gjiagou.com/api/user/updateMoble      json：{"phone"：15954705437 "userId":128}
+ (NSURLSessionTask *)updateMobleWithUid:(NSString*)uid phone:(NSString*)phone block:(AFCompletionBlock)block;

#pragma mark--扫描二维码
/**
 *  绑定商户
 *
 *  @param uid      用户id
 *  @param sellerId 商户id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)bindWithUid:(NSString*)uid sellerId:(NSString*)sellerId block:(AFCompletionBlock)block;



#pragma mark--0yuan
/**
 *  我的零元购
 *  {"pagination":{"count":10,"page":1},"user_id":271}
 *  @param uid   用户id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)lotteryWithUid:(NSString*)uid count:(NSInteger)count page:(NSInteger)page block:(AFCompletionBlock)block;

#pragma mark--商品收藏
/**
 *  查询商品
 *
 *  @param uid   用户id
 *  @param count 每页数量
 *  @param page  页面
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)accFavoriteWithUid:(NSString*)uid count:(NSInteger)count page:(NSInteger)page block:(AFCompletionBlock)block;

/**
 *  取消商品收藏
 *
 *  @param uid   用户id
 *  @param recId collectionId 收藏id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)delCollectionWithUid:(NSString *)uid recId:(NSString *)recId block:(AFCompletionBlock)block;


#pragma mark--店铺收藏accFavshop
/**
 *  店铺查询
 *{"pagination":{"count":10,"page":1},"user_id":"271"}
 *  @param uid   用户id
 *  @param count 每页数量
 *  @param page  页面
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)accFavshopWithUid:(NSString*)uid count:(NSInteger)count page:(NSInteger)page block:(AFCompletionBlock)block;


/**
 *  取消店铺收藏
 *{"user_id":"271","rec_id":"255"}
 *  @param uid   用户id
 *  @param recId 收藏id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)delShopWithUid:(NSString*)uid recId:(NSString*)recId  block:(AFCompletionBlock)block;


#pragma mark--订单相关

//{"pagination":{"count":10,"page":1},"type":"whole","uid":"303"} type:whole--全部订单，await_pay--未付款，await_ship--代发货，shipped--代收货
//finished--历史订单，refund--退款
+ (NSURLSessionTask *)myOrderUid:(NSString*)uid count:(NSInteger)count page:(NSInteger)page type:(NSString*)type  block:(AFCompletionBlock)block;

//orderId:订单的id
+ (NSURLSessionTask *)orderDetailUid:(NSString*)uid orderId:(NSString*)orderId block:(AFCompletionBlock)block;


//goods/commentImg传评论图片
+ (void )commentImgWithUid:(NSString*)uid imageData:(NSData*)fileData block:(AFCompletionBlock)block;

//goods/saveComment 保存商品评价 {"uid":"156","goodsContent":"很好非常好","goodsId":"15","goodsImage":/imgs/399394ssdcusd.jpg","orderId":"755"}
+ (NSURLSessionTask *)saveCommentWithUid:(NSString*)uid goodsContent:(NSString*)goodContent goodsId:(NSString*)goodsId goodImage:(NSString*)goodsImage orderId:(NSString*)orderId block:(AFCompletionBlock)block;
//user/cancelOrder取消订单
+ (NSURLSessionTask *)cancelOrderWithUid:(NSString*)uid orderId:(NSString*)orderId block:(AFCompletionBlock)block;

//确认收货user/affirmReceived
+ (NSURLSessionTask *)affirmReceivedWithUid:(NSString*)uid orderId:(NSString*)orderId block:(AFCompletionBlock)block;
//申请退货次数order/calCount
+ (NSURLSessionTask *)calCountWithUid:(NSString*)uid orderId:(NSString*)orderId goodId:(NSString*)goodId block:(AFCompletionBlock)block;
//保存捷信支付退款次数
//+ (NSURLSessionTask *)JiexincalCountWithOrderId:(NSString*)orderId  block:(AFCompletionBlock)block;
+ (NSURLSessionTask *)JiexincalCountWithUid:(NSString*)uid orderId:(NSString*)orderId  block:(AFCompletionBlock)block;

//保存退款信息order/saveRefund

+ (NSURLSessionTask *)saveRefundWithUid:(NSString*)uid orderId:(NSString*)orderId refundNo:(NSString*)refundNo refundPrice:(NSString*)refundPrice applyService:(NSString*)applyService reason:(NSString*)reason description:(NSString*)description orderGoodsId:(NSString*)orderGoodsId orderStatus:(NSString*)orderStatus block:(AFCompletionBlock)block;


@end
