//
//  AddressBaseViewModel.h
//  ESL
//
//  Created by 赵洁 on 16/10/20.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressMolde.h"

typedef void(^NewAddBlock)(id AddNewDataSucroe);
typedef void(^AllAddressataBlock)(id AllAddressDataSucroe);
typedef void(^DeleteBlock)(id DeleteDataSucroe);

@interface AddressBaseViewModel : NSObject
@property (nonatomic,copy)NewAddBlock NewAddBlock;//新加
@property (nonatomic,copy)AllAddressataBlock AllAddressataBlock;//修改
@property (nonatomic,copy)DeleteBlock DeleteBlock;//修改

@property (nonatomic,strong)AddressMolde*model;
- (void)AddNew_Or_ModifiyRequestWithUserTel:(NSString*)userTel UUID:(NSString*)uuid RecvTel:(NSString*)RecvTel RecvName:(NSString*)RecvName RecvID:(NSString*)RecvID CountyID:(NSString*)CountyID Details:(NSString*)Details IsDefault:(NSString*)IsDefault isAdd:(BOOL)isAdd;
- (void)getAddNewDataWithUserTel:(NSString*)userTel UUID:(NSString*)uuid ;
- (void)DeleteAddressDataWithUserTel:(NSString*)UserTel UserPhyAdd:(NSString*)UserPhyAdd RecvAddrID:(NSString*)RecvAddrID;
- (void)settingDefullAddressWithRecvID:(NSString*)RecvID ;

@end

