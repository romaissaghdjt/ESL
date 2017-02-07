//
//  MapBottomView.m
//  YY
//
//  Created by 陈龙 on 16/6/1.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "MapBottomView.h"

@implementation MapBottomView

-(instancetype)init
{
    if (self = [super init]) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.equalTo(0);
            make.size.mas_equalTo(CGSizeMake(120, 80));
        }];
        
        
        _villageName = [[UILabel alloc]init];
        [self addSubview:_villageName];
        [_villageName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView.mas_right).offset(10);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.right.mas_equalTo(0);
//            make.height.mas_equalTo(20);
        }];
        
        
        _villageAdd = [[UILabel alloc]init];
        _villageAdd.text = @"地址:";
        [self addSubview:_villageAdd];
        [_villageAdd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView.mas_right).offset(10);
            make.top.mas_equalTo(_villageName.mas_bottom).offset(0);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        _villageAdd.font = [UIFont systemFontOfSize:12];
        
        
        _villageAddress = [[UILabel alloc]init];
        _villageAddress.numberOfLines = 0;
        [self addSubview:_villageAddress];
        [_villageAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_villageAdd.mas_right).offset(0);
            make.top.mas_equalTo(_villageName.mas_bottom).offset(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        _villageAddress.font = [UIFont systemFontOfSize:12];
        
        
        _villagePeo = [[UILabel alloc]init];
        _villagePeo.text = @"联系人:";
        [self addSubview:_villagePeo];
        [_villagePeo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView.mas_right).offset(10);
            make.top.mas_equalTo(_villageAddress.mas_bottom).offset(0);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
        }];
        _villagePeo.font = [UIFont systemFontOfSize:12];
        
        
        _villagePeople = [[UILabel alloc]init];

        [self addSubview:_villagePeople];
        [_villagePeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_villagePeo.mas_right).offset(0);
            make.top.mas_equalTo(_villageAddress.mas_bottom).offset(0);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        _villagePeople.font = [UIFont systemFontOfSize:12];
        
        
        _villagePeoTele = [[UILabel alloc]init];
        _villagePeoTele.text = @"电话:";
        [self addSubview:_villagePeoTele];
        [_villagePeoTele mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView.mas_right).offset(10);
            make.top.mas_equalTo(_villagePeople.mas_bottom).offset(0);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(20);
        }];
        _villagePeoTele.font = [UIFont systemFontOfSize:12];
        
        
        _villagePeopleTele = [[UILabel alloc]init];
        [self addSubview:_villagePeopleTele];
        [_villagePeopleTele mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_villagePeoTele.mas_right).offset(0);
            make.top.mas_equalTo(_villagePeople.mas_bottom).offset(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
        _villagePeopleTele.font = [UIFont systemFontOfSize:12];

    }
    return self;
    
}

-(void)setValueForVillageModel:(CLVillageModel *)villageModel
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:villageModel.ImageUrl]];
    self.villageName.text = villageModel.Name;
    self.villageAddress.text = villageModel.DetailAddr;
    self.villagePeople.text = villageModel.Principal;
    self.villagePeopleTele.text = villageModel.PrincipalTel;
}

@end
