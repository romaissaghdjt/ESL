//
//  ESLChoseView.m
//  ESL
//
//  Created by eyou on 16/10/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ESLChoseView.h"
#import "ViceView.h"
#import "MainFoodCell.h"


@interface ESLChoseView()<UITableViewDelegate, UITableViewDataSource, FoodInfoButtonDelegate>
//总价
@property (nonatomic, strong)UILabel *totalLabel;
@property (nonatomic, assign)NSInteger countNum;
@property (nonatomic, strong)ViceView *viceView;
@property (nonatomic, assign)BOOL isFromRob;

@property (nonatomic, strong)UIImageView *img;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UIButton *buyBtn1;
@property (nonatomic, strong)UIButton *buyBtn2;
@property (nonatomic, strong)UIButton *addBtn;
@end

@implementation ESLChoseView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //半透明视图
        _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.2;
        [self addSubview:_alphaView];
        //装载商品信息的视图
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 150*SCREEN_SCALE, self.frame.size.width, self.frame.size.height-150*SCREEN_SCALE)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//        [whiteView addGestureRecognizer:tap];
        //商品图片
        _img = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 100, 100)];
        _img.backgroundColor = [UIColor yellowColor];
        _img.layer.cornerRadius = 4;
        _img.layer.borderColor = [UIColor whiteColor].CGColor;
        _img.layer.borderWidth = 5;
        
        [_img.layer setMasksToBounds:YES];
        [whiteView addSubview:_img];
        //退出按钮
        UIButton *cancleBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.frame = CGRectMake(whiteView.frame.size.width-40, 10,30, 30);
        [cancleBtn setBackgroundImage:[UIImage imageNamed:@"close@3x"] forState:0];
        [whiteView addSubview:cancleBtn];
        
        //商品价格
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_img.frame.origin.x+_img.frame.size.width+20, 20, whiteView.frame.size.width-(_img.frame.origin.x+_img.frame.size.width+40+40), 20)];
        
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:_priceLabel];
        //商品库存
        UILabel *stockLabel = [[UILabel alloc] initWithFrame:CGRectMake(_img.frame.origin.x+_img.frame.size.width+20, _priceLabel.frame.origin.y+_priceLabel.frame.size.height, whiteView.frame.size.width-(_img.frame.origin.x+_img.frame.size.width+40+40), 20)];
        stockLabel.text = @"选择 配菜 规格";
        stockLabel.textColor = [UIColor blackColor];
        stockLabel.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:stockLabel];
//        //用户所选择商品的尺码和颜色
//        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, stockLabel.frame.origin.y+stockLabel.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 40)];
//        detailLabel.numberOfLines = 2;
//        detailLabel.backgroundColor = [UIColor redColor];
//        detailLabel.textColor = [UIColor blackColor];
//        detailLabel.font = [UIFont systemFontOfSize:14];
//        [whiteView addSubview:detailLabel];
        UILabel *headerLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _img.frame.origin.y+_img.frame.size.height+20, whiteView.frame.size.width - 40, 0.5)];
        headerLineLabel.backgroundColor = [UIColor lightGrayColor];
        [whiteView addSubview:headerLineLabel];
        
        //底部视图
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-150*SCREEN_SCALE - 80, self.frame.size.width, 80)];
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, 1)];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [whiteView addSubview:bottomView];
       
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-10, 40)];
        
        _totalLabel.textAlignment = NSTextAlignmentRight;
        _totalLabel.textColor = [UIColor redColor];
        
       
        _buyBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 40)];
        [_buyBtn1 setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyBtn1.backgroundColor = ZXColor(216, 137, 33, 1);
        [_buyBtn1 addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:_buyBtn1];
    
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width / 2.0, 40)];
        [_addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addBtn.backgroundColor = ZXColor(109, 176, 55, 1);
        [_addBtn addTarget:self action:@selector(addShopcart:) forControlEvents:UIControlEventTouchUpInside];
        
        _buyBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 2.0, 40, self.frame.size.width / 2.0, 40)];
        [_buyBtn2 setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyBtn2.backgroundColor = ZXColor(216, 137, 33, 1);
        [_buyBtn2 addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:_buyBtn2];
        [bottomView addSubview:_addBtn];
        
        [bottomView addSubview:_totalLabel];
        [bottomView addSubview:bottomLineView];
        //scrollView
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headerLineLabel.frame.origin.y+headerLineLabel.frame.size.height, whiteView.frame.size.width, bottomView.frame.origin.y-(headerLineLabel.frame.origin.y+headerLineLabel.frame.size.height))];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [whiteView addSubview:_mainTableView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MainFoodCell *cell = [[NSBundle mainBundle]loadNibNamed:@"MainFoodCell" owner:nil options:nil].firstObject;
        cell.delegate = self;
        cell.unitLabel.text = [NSString stringWithFormat:@"%@%@", self.model.BaseData.Number,self.model.BaseData.NormUnit];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        [_viceView removeFromSuperview];
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        _viceView = [[ViceView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, self.garnishesArray.count*35+70) Array:self.garnishesArray];
        _viceView.delegate = self;
        [cell.contentView addSubview:_viceView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70;
    }
    return self.garnishesArray.count*35+70;
}

-(void)buttonClickWithButton:(UIButton *)sender Type:(NSString *)type
{
    if (sender.tag == 100 && [type isEqualToString:@"sub"]) {
        self.countNum--;
        if (self.isFromRob == YES) {
            _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [[_totalLabel.text substringFromIndex:1] doubleValue] - [self.model.RobData doubleValue]];
        }
        else
        {
            _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [[_totalLabel.text substringFromIndex:1] doubleValue] - [self.model.BaseData.Price doubleValue]];
        }
        
    }
    else if (sender.tag == 100 && [type isEqualToString:@"add"]) {
        self.countNum++;
        if (self.isFromRob == YES) {
            _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [[_totalLabel.text substringFromIndex:1] doubleValue] + [self.model.RobData doubleValue]];
        }
        else
        {
            _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [[_totalLabel.text substringFromIndex:1] doubleValue] + [self.model.BaseData.Price doubleValue]];
        }
    }
    else if ([type isEqualToString:@"add"]) {
        _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [[_totalLabel.text substringFromIndex:1] doubleValue] + [((GarnishesModel *)self.garnishesArray[sender.tag]).price doubleValue]];
    }
    else if ([type isEqualToString:@"sub"]) {
        _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [[_totalLabel.text substringFromIndex:1] doubleValue] - [((GarnishesModel *)self.garnishesArray[sender.tag]).price doubleValue]];
    }
    else if ([type isEqualToString:@"zero"])
    {
        if (self.isFromRob == YES) {
            _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [self.model.RobData doubleValue] * self.countNum];
        }
        else
        {
            _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf",[self.model.BaseData.Price doubleValue]];;
        }
        
    }
    
}

-(void)setInfoValueWithArray:(NSArray *)array withModel:(FreashModel *)freashModel IsFromRob:(BOOL)isFromRob
{
    _viceView = nil;
    self.isFromRob = isFromRob;
    self.countNum = 1;
    self.garnishesArray = array;
    self.model = freashModel;
    [_img sd_setImageWithURL:[NSURL URLWithString:freashModel.BaseData.ImageUrl] placeholderImage:nil];
    if (self.isFromRob == YES) {
        _priceLabel.text = [NSString stringWithFormat:@"¥%.02lf", [freashModel.RobData doubleValue]];
    }
    else
    {
        _priceLabel.text = [NSString stringWithFormat:@"¥%.02lf", [freashModel.BaseData.Price doubleValue]];
    }
    if (self.isFromRob == YES) {
        _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf", [freashModel.RobData doubleValue]];
        _buyBtn1.hidden = NO;
        _buyBtn2.hidden = YES;
        _addBtn.hidden = YES;
    }
    else
    {
        _totalLabel.text = [NSString stringWithFormat:@"¥%.02lf",[freashModel.BaseData.Price doubleValue]];
        _buyBtn1.hidden = YES;
        _buyBtn2.hidden = NO;
        _addBtn.hidden = NO;
    }
    [self.mainTableView reloadData];
}

-(void)buyClick:(UIButton *)sender
{
    [self.delegate GotoBuyClick:_viceView.labelArray MainCount:[NSString stringWithFormat:@"%ld", self.countNum]];
}

-(void)addShopcart:(UIButton *)sender
{
    [self.delegate addShopCartClick:_viceView.labelArray MainCount:[NSString stringWithFormat:@"%ld", self.countNum]];
}

@end
