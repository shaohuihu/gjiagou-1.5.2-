//
//  ELCatoryService.h
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCatoryService : NSObject

+ (NSURLSessionDataTask *)getCategoriesWithBlock:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getSubCategoriesWithId:(NSInteger)cId block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getSubCategories1WithId:(NSInteger)cId block:(AFCompletionBlock)block;
//商品列表
+ (NSURLSessionDataTask *)getCategoryGoodsWithPage:(NSInteger)page para:(NSDictionary *)para block:(AFCompletionBlock)block;
//品牌
+ (NSURLSessionDataTask *)getCategoryBrandsWithCategoryId:(NSInteger)categoryId block:(AFCompletionBlock)block;
//商品详情
+ (NSURLSessionDataTask *)getGoodsDetailWithGoodsId:(NSInteger)goodsId block:(AFCompletionBlock)block;
//商品评价
+ (NSURLSessionDataTask *)getGoodsCommentsGoodsId:(NSInteger)goodsId page:(NSInteger)page block:(AFCompletionBlock)block;
//商品收藏
+ (NSURLSessionDataTask *)addGoodsToFav:(NSInteger)goodsId block:(AFCompletionBlock)block;

//加入购物车
/*****************************对于加入购物车有个改变的地方*********************************/
+ (NSURLSessionDataTask *)addGoodsToCart:(NSInteger)goodsId price:(NSString *)price count:(NSInteger)count storage:(NSString *)storage spec:(NSString *)spec channel:(NSInteger)channel  block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)calculatePriceWithGoodId:(NSInteger)goodsId spec:(NSString *)spec block:(AFCompletionBlock)block;
//+ (NSURLSessionDataTask *)saveCartForBillWithGoodsId:(NSInteger)goodsId price:(NSString *)price count:(NSInteger)count storage:(NSString *)storage channel:(NSInteger)channel block:(AFCompletionBlock)block;
//根据1.4版本改变
+ (NSURLSessionDataTask *)saveCartForBillWithGoodsId:(NSInteger)goodsId price:(NSString *)price count:(NSInteger)count storage:(NSString *)storage channel:(NSInteger)channel standard:(NSString*)standard block:(AFCompletionBlock)block;




+ (NSURLSessionDataTask *)bugGoodNowWithCartId:(NSNumber *)cartId block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getStandardImageWithGoodsId:(NSInteger)goodsId standard:(NSString *)standard block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getStandardPriceWithGoodsId:(NSInteger)goodsId standard:(NSString *)standard block:(AFCompletionBlock)block;
@end
