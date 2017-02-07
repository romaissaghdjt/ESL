//
//  MyOrderViewModel.h
//  ESL
//
//  Created by 赵洁 on 16/10/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^All_Block)(id AllData);
typedef void(^User_Block)(id UserData);

typedef void(^No_Pay_Block)(id No_PayData);
typedef void(^stay_shipping_Block)(id stay_shippingData);//待发货
typedef void(^stay_goods_Block)(id stay_goods_Data);//待收货
typedef void(^evaluate_Block)(id evaluate_Data);//待评价
typedef void(^Cancl_Or_DeleteBlock)(id Cancl_Or_deleteData);

@interface MyOrderViewModel : NSObject
@property (nonatomic,copy)All_Block allBlock;
@property (nonatomic,copy)User_Block User_Block;

@property (nonatomic,copy)No_Pay_Block No_Pay_Block;
@property (nonatomic,copy)stay_shipping_Block stay_shipping_Block;
@property (nonatomic,copy)stay_goods_Block stay_goods_Block;
@property (nonatomic,copy)evaluate_Block evaluate_Block;
@property (nonatomic,copy)Cancl_Or_DeleteBlock Cancl_Or_DeleteBlock;
//得到个人的信息
- (void)getUserInfo;
- (void)getAllOrderData;
- (void)getNo_PayOrderData;
- (void)getstay_shippingOrderData;//待发货
- (void)getstay_goodsOrderData;//待收货
- (void)getPreEvaluateData;//待评价
//获取某订单的详情页面
- (void)getevaluateOrderDataWithOrderID:(NSString*)OrderID;
- (void)canclOrderWithOrderID:(NSString*)OrderID;
- (void)deleteOrderWithOrderID:(NSString*)OrderID;
//确认收货
- (void)sureGetGoodsWithOrderID:(NSString*)OrderID;
//得到是否加盟
- (void)getYes_Or_Join;
@end
