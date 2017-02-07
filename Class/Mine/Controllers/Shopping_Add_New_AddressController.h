//
//  Shopping_Add_New_AddressController.h
//  ESL
//
//  Created by 赵洁 on 16/10/13.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressMolde.h"
@protocol Shopping_Add_New_AddressControllerDelegate <NSObject>
- (void)getEditoredAddress:(NSInteger)index withModel:(AddressMolde*)model isOpen:(BOOL)isOpen;
-(void)getAddDataWithModel:(AddressMolde*)model isOpen:(BOOL)isOpen;
- (void)deleteThisAddressWith:(NSInteger)index;
@end

@interface Shopping_Add_New_AddressController : UIViewController
@property (nonatomic,assign)id<Shopping_Add_New_AddressControllerDelegate>delegate;
@property (nonatomic,strong)AddressMolde*model;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,strong)NSString*address;
@property (nonatomic, assign)BOOL tureOrfalse;
@property (nonatomic)BOOL isFrist;
@property (nonatomic)BOOL isother;
@property (nonatomic)BOOL isComplete;

@end

