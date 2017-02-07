//
//  ESLMyCollectionCell.m
//  ESL
//
//  Created by 徐恒 on 2016/11/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLMyCollectionCell.h"
@implementation ESLMyCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}
-(void)setModel:(MyCollectionModel *)model
{
//    _model = model;
    [self.Icon sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl]];
    self.Name.text = model.Remark;
    self.Price.text = [NSString stringWithFormat:@"¥%.2f",model.Price.floatValue];
    self.ProId = model.ProID;
    self.ProductCgy = model.ProductCgy;
}
- (void)createCell{
    self.ChooseBtn = [UIButton new];
    [self.ChooseBtn addTarget:self action:@selector(ChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.ChooseBtn];
    [self.ChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.mas_equalTo(55/2);
        make.left.mas_equalTo(5);
//        make.bottom.mas_equalTo(-55/2);
    }];

    self.Icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"7"]];
//    self.Icon.backgroundColor = [UIColor redColor];
    self.Icon.layer.cornerRadius = 5;
    self.Icon.layer.masksToBounds = YES;
    [self addSubview:self.Icon];
    [self.Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(82, 82));
        make.top.mas_equalTo(4);
        make.left.equalTo(self.ChooseBtn.mas_right).with.offset(5);
        make.bottom.mas_equalTo(-4);
    }];
    
    
    self.Name = [UILabel new];
    self.Name.numberOfLines = 0;
    self.Name.text = @"";
    self.Name.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.Name];
//    self.Name.backgroundColor = [UIColor greenColor];
    [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KWIDTH-(self.ChooseBtn.frame.size.width+self.Icon.frame.size.width+15), 25));
        make.top.mas_equalTo(5);
        make.left.equalTo(self.Icon.mas_right).with.offset(10);
        make.right.mas_equalTo(-5);
    }];
    
    self.Price = [UILabel new];
    self.Price.text = @"";
    self.Price.textAlignment = NSTextAlignmentRight;
//    self.Price.backgroundColor = [UIColor yellowColor];
    self.Price.font = [UIFont systemFontOfSize:15];
    self.Price.textColor = [UIColor redColor];
    [self addSubview:self.Price];
    [self.Price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-1);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(21);
    }];
    
//    UILabel *lab = [UILabel new];
//    lab.text = @"¥";
//    lab.textColor = [UIColor redColor];
//    lab.font = [UIFont systemFontOfSize:15];
//    [self addSubview:lab];
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(10, 21));
//        make.right.equalTo(self.Price.mas_left).with.offset(0);
//        make.bottom.mas_equalTo(-1);
//    }];
}
- (void)ChooseBtnClick:(UIButton *)sender{
    sender.selected =!sender.selected;
    self.butBlock(self.indexpath);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
