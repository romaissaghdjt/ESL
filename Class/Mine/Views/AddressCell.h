//
//  AddressCell.h
//  ESL
//
//  Created by 赵洁 on 16/10/13.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressMolde.h"


@interface AddressCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *NameLable;
@property (strong, nonatomic) IBOutlet UILabel *PhoneNumLable;
@property (strong, nonatomic) IBOutlet UILabel *AddressLable;
@property (strong, nonatomic) IBOutlet UIButton *ChooseButton;
@property (strong, nonatomic) IBOutlet UIButton *EditorButton;
@property (strong, nonatomic) IBOutlet UIButton *DeleateButton;
@property (strong, nonatomic) IBOutlet UILabel *MoRenLable;
@property (nonatomic,strong)AddressMolde*model;
@end
