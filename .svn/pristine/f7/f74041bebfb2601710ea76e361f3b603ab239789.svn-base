//
//  MyOrderController.m
//  ESL
//
//  Created by 徐恒 on 16/9/26.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "MyOrderController.h"
#import "MineOrderCell.h"
#import "FaestShowHeaderView.h"
#import "MineOrderFootView.h"
#import "MyOrderViewModel.h"
#import "MyOrederSubModel.h"
#import "MyOrderBaseModel.h"
#import "ESLShopCartViewController.h"
#import "ESLFeastDetailViewController.h"
#import "ESLFoodInfoViewController.h"
#import "ESLPaymentController.h"
#import "ESLEvaluateViewController.h"

@interface MyOrderController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)UIButton*Allbutton;
@property (nonatomic,strong)UIButton*WaitingPaybutton;//待支付
@property (nonatomic,strong)UIButton*WaitingShipmentsbutton;//待发货
@property (nonatomic,strong)UIButton*WaitingShouHuobutton;//待收货
@property (nonatomic,strong)UIButton*WaitingEvaluatebutton;//待评价
@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,strong)UIScrollView*MainScorllView;
@property (nonatomic,strong)MineOrderFootView *Fv;
@property (nonatomic,strong)FaestShowHeaderView*Fh;
@property(nonatomic,strong)UITableView*oneTB;
@property(nonatomic,strong)UITableView*towTB;
@property(nonatomic,strong)UITableView*threeTB;
@property(nonatomic,strong)UITableView*fourTB;
@property(nonatomic,strong)UITableView*fiveTB;
@property(nonatomic,strong)NSMutableArray*ALlArray;//全
@property(nonatomic,strong)NSMutableArray*PayArray;//支付
@property(nonatomic,strong)NSMutableArray*FaArray;//发货
@property(nonatomic,strong)NSMutableArray*ShArray;//收货
@property(nonatomic,strong)NSMutableArray*EvalArray;//评价
@property (nonatomic,strong)MyOrderViewModel*ViewModel;
@property (nonatomic)BOOL isCancl;
@property (nonatomic)BOOL isDelete;
@property (nonatomic)BOOL isWatiing;
@property (nonatomic)BOOL isSure;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic, strong)UIImageView*NillImg;
@property (nonatomic, strong)UIImageView*NillImgP;
@property (nonatomic, strong)UIImageView*NillImgF;
@property (nonatomic, strong)UIImageView*NillImgS;
@property (nonatomic, strong)UIImageView*NillImgE;


@end

@implementation MyOrderController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
    }else{
        self.navigationItem.leftBarButtonItem=nil;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestALL];
            
        });
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestEvla];
            
        });
        
    });
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _isCancl = NO;
    _isDelete = NO;
    _isWatiing = NO;
    _isSure = NO;
    [self AddScrollView];
    
    [self setbuttonView];
    if (_int_ID == 1) {
        [self moveLineView:_WaitingPaybutton ];
        [self.MainScorllView setContentOffset:CGPointMake(KWIDTH, 0)];
        [self chanageBntTitleColor:_WaitingPaybutton.tag];
    }else if (_int_ID == 2)
    {
        [self moveLineView:_WaitingShipmentsbutton ];
        [self.MainScorllView setContentOffset:CGPointMake(KWIDTH*2, 0)];
        
        [self chanageBntTitleColor:_WaitingShipmentsbutton.tag];
    }else if (_int_ID == 3)
    {
        [self moveLineView:_WaitingShouHuobutton ];
        [self.MainScorllView setContentOffset:CGPointMake(KWIDTH*3, 0)];
        
        [self chanageBntTitleColor:_WaitingShouHuobutton.tag];
    }else if (_int_ID == 4)
    {
        [self moveLineView:_WaitingEvaluatebutton ];
        [self.MainScorllView setContentOffset:CGPointMake(KWIDTH*4, 0)];
        
        [self chanageBntTitleColor:_WaitingEvaluatebutton.tag];
    }
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"-=-=-=%@",[NSThread currentThread]);
    // dispatch_async(dispatch_get_main_queue(), ^{
    [self requestALL];
    
    //});
    
    //});
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"-=-=-=%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestNO_Pay];
            
        });
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"-=-=-=%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestEvla];
            
        });
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"-=-=-=%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestNO_fa];
            
        });
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"-=-=-=%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestNo_shou];
            
        });
        
    });
    
}
- (void)requestALL
{
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    self.ALlArray = [NSMutableArray array];
    _ViewModel.allBlock = ^(id AllData){
        _ALlArray = AllData;
        if (_ALlArray.count == 0) {
            weakSelf.NillImg.hidden = NO;
        }else
        {
            weakSelf.NillImg.hidden = YES;
        }
        [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
        [weakSelf.oneTB reloadData];
        
    };
    [_ViewModel getAllOrderData];
}
- (void)requestNO_Pay
{
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    self.PayArray = [NSMutableArray array];
    _ViewModel.allBlock = ^(id AllData){
        _PayArray = AllData;
        if (_PayArray.count == 0) {
            weakSelf.NillImgP.hidden = NO;
        }else
        {
            weakSelf.NillImgP.hidden = YES;
        }
        [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
        
        [weakSelf.towTB reloadData];
    };
    [_ViewModel getNo_PayOrderData];
    
}
- (void)requestNO_fa
{
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    self.PayArray = [NSMutableArray array];
    _ViewModel.allBlock = ^(id AllData){
        _FaArray = AllData;
        if (_FaArray.count == 0)
        {
            weakSelf.NillImgF.hidden = NO;
        }
        else
        {
            weakSelf.NillImgF.hidden = YES;
        }
        
        [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
        
        [weakSelf.threeTB reloadData];
        
        
    };
    
    [_ViewModel getstay_shippingOrderData];
    
    
}
- (void)requestNo_shou
{
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    self.PayArray = [NSMutableArray array];
    _ViewModel.allBlock = ^(id AllData){
        _ShArray = AllData;
        if (_ShArray.count == 0) {
            weakSelf.NillImgS.hidden = NO;
        }else
        {
            weakSelf.NillImgS.hidden = YES;
        }
        
        [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
        
        [weakSelf.fourTB reloadData];
        
    };
    
    [_ViewModel getstay_goodsOrderData];
    
}
//评价
- (void)requestEvla
{
    [[HUDView sharedInstanceWithView:self.view]showHUD];
    
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    self.EvalArray = [NSMutableArray array];
    
    _ViewModel.allBlock = ^(id AllData){
        _EvalArray = AllData;
        if (_EvalArray.count == 0) {
            weakSelf.NillImgE.hidden = NO;
        }else
        {
            weakSelf.NillImgE.hidden = YES;
        }
        
        [[HUDView sharedInstanceWithView:weakSelf.view]hiddenHUD];
        
        [weakSelf.fiveTB reloadData];
        
    };
    
    
    [_ViewModel getPreEvaluateData];
    
    
    
}
- (void)loadNullImg
{
    
}
- (void)AddScrollView
{
    _MainScorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, KWIDTH, KHEIGHT-50)];
    _MainScorllView.pagingEnabled = YES;
    _MainScorllView.alwaysBounceHorizontal = YES;
    _MainScorllView.alwaysBounceVertical = NO;
    _MainScorllView.showsHorizontalScrollIndicator = NO;
    _MainScorllView.bounces = NO;
    _MainScorllView.delegate = self;
    _MainScorllView.contentSize = CGSizeMake(KWIDTH * 5,0);
    _MainScorllView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_MainScorllView];
    
    for (int i = 0; i < 5; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i*KWIDTH, 0, KWIDTH, _MainScorllView.height-50) style:(UITableViewStyleGrouped)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 100+i;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 10;
        [_MainScorllView addSubview:tableView];
        UIImageView*img = [[UIImageView alloc]initWithFrame:CGRectMake((KWIDTH/2-75)+i*KWIDTH, 120, 150, 150)];
        img.image = [UIImage imageNamed:@"null.png"];
        img.hidden = YES;
        img.tag = 10+i;
        [_MainScorllView addSubview:img];
        
    }
    self.NillImg = [self.MainScorllView viewWithTag:10];
    self.NillImg.hidden = YES;
    self.NillImgP = [self.MainScorllView viewWithTag:11];
    self.NillImgP.hidden = YES;
    
    self.NillImgF = [self.MainScorllView viewWithTag:12];
    self.NillImgF.hidden = YES;
    
    self.NillImgS = [self.MainScorllView viewWithTag:13];
    self.NillImgS.hidden = YES;
    
    self.NillImgE = [self.MainScorllView viewWithTag:14];
    self.NillImgE.hidden = YES;
    
    self.oneTB = [self.MainScorllView viewWithTag:100];
    self.towTB = [self.MainScorllView viewWithTag:101];
    self.threeTB = [self.MainScorllView viewWithTag:102];
    self.fourTB = [self.MainScorllView viewWithTag:103];
    self.fiveTB = [self.MainScorllView viewWithTag:104];
    
}

- (void)setbuttonView
{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, 50)];
    backView.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:backView];
    self.backView = backView;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10,backView.bottom-2,KWIDTH/7 , 3)];
    lineView.backgroundColor = ZXColor(55, 178, 34, 1);
    [self.view addSubview:lineView];
    self.lineView = lineView;
    for (int i = 0;i < 5; i++) {
        
        UIButton*bnt = [[UIButton alloc]initWithFrame:CGRectMake(i*KWIDTH/5, 0, KWIDTH/5, 45)];
        [bnt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        bnt.tag = i+10000;
        [backView addSubview:bnt];
        if (SW == 320) {
            bnt.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    self.Allbutton = [self.view viewWithTag:10000];
    [self.Allbutton setTitle:@"全部" forState:(UIControlStateNormal)];
    [self.Allbutton setTitleColor:ZXColor(55, 178, 34, 1)forState:(UIControlStateNormal)];
    [self.Allbutton addTarget:self action:@selector(AllbuttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.WaitingPaybutton = [self.view viewWithTag:10001];
    [self.WaitingPaybutton setTitle:@"待支付" forState:(UIControlStateNormal)];
    [self.WaitingPaybutton addTarget:self action:@selector(WaitingPaybuttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.WaitingShipmentsbutton = [self.view viewWithTag:10002];
    [self.WaitingShipmentsbutton setTitle:@"待发货" forState:(UIControlStateNormal)];
    [self.WaitingShipmentsbutton addTarget:self action:@selector(WaitingShipmentsbuttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.WaitingShouHuobutton = [self.view viewWithTag:10003];
    [self.WaitingShouHuobutton setTitle:@"待收货" forState:(UIControlStateNormal)];
    [self.WaitingShouHuobutton addTarget:self action:@selector(WaitingShouHuobuttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.WaitingEvaluatebutton = [self.view viewWithTag:10004];
    [self.WaitingEvaluatebutton setTitle:@"待评价" forState:(UIControlStateNormal)];
    [self.WaitingEvaluatebutton addTarget:self action:@selector(WaitingEvaluatebuttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
        return _ALlArray.count;
    }else if (tableView.tag == 101) {
        return _PayArray.count;
    }else if (tableView.tag == 102) {
        return _FaArray.count;
    }else if (tableView.tag == 103) {
        return _ShArray.count;
    }else{
        return _EvalArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        MyOrderBaseModel*model = _ALlArray[section];
        return model.Content.count;
    }else if (tableView.tag == 101){
        MyOrderBaseModel*model = _PayArray[section];
        
        return model.Content.count;
    }else if (tableView.tag == 102) {
        MyOrderBaseModel*model = _FaArray[section];
        
        return model.Content.count;
    }else if (tableView.tag == 103) {
        MyOrderBaseModel*model = _ShArray[section];
        
        return model.Content.count;
    }else{
        MyOrderBaseModel*model = _EvalArray[section];
        
        return model.Content.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*Id = @"Mcell";
    MineOrderCell*cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MineOrderCell" owner:nil options:nil].lastObject;
        cell.backgroundColor = ZXColor(220, 220, 220, 1);
    }
    cell.img.layer.cornerRadius = 6;
    cell.img.layer.masksToBounds = YES;
    if (tableView.tag == 100) {
        MyOrderBaseModel*model = _ALlArray[indexPath.section];
        MyOrederSubModel*smodel = model.Content[indexPath.row];
        
        cell.smodel = smodel;
    }else if (tableView.tag == 101) {
        MyOrderBaseModel*model = _PayArray[indexPath.section];
        MyOrederSubModel*smodel = model.Content[indexPath.row];
        cell.smodel = smodel;
    }else if (tableView.tag == 102) {
        MyOrderBaseModel*model = _FaArray[indexPath.section];
        MyOrederSubModel*smodel = model.Content[indexPath.row];
        cell.smodel = smodel;
    }else if (tableView.tag == 103) {
        MyOrderBaseModel*model = _ShArray[indexPath.section];
        MyOrederSubModel*smodel = model.Content[indexPath.row];
        cell.smodel = smodel;
    }else{
        MyOrderBaseModel*model = _EvalArray[indexPath.section];
        MyOrederSubModel*smodel = model.Content[indexPath.row];
        cell.smodel = smodel;
    }
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    FaestShowHeaderView *Hv = [[FaestShowHeaderView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 50)];
    Hv.backgroundColor = [UIColor whiteColor];
    
    self.Fh = Hv;
    
    if (tableView.tag == 100) {
        MyOrderBaseModel*model = _ALlArray[section];
        _Fh.RecLable.text = model.ID;
        _Fh.sate.text = model.Status;
        if ([model.Status isEqualToString:@"订单已取消"]) {
            model.isCancl = YES;
            _Fh.sate.textColor = [UIColor grayColor];
        }
        if ([model.Status isEqualToString:@"正在出库"]) {
            model.isWatiing = YES;
        }else{
            model.isWatiing = NO;
            _isWatiing = NO;
        }
        if ([model.Status isEqualToString:@"已收货"]) {
            model.isSure = YES;
        }else{
            model.isSure = NO;
        }
        if ([model.Status isEqualToString:@"待评价"]) {
            model.isDelete = YES;
        }else
        {
            _isDelete = NO;
            model.isDelete = NO;
            
        }
        if (model.isCancl == YES) {
            _Fh.sate.textColor = [UIColor grayColor];
            _Fh.sate.text = @"订单已取消";
        }
        if ([model.Status isEqualToString:@"已完成"]) {
            model.isDone = YES;
        }
        return self.Fh;
    }else if (tableView.tag == 101){
        MyOrderBaseModel*model = _PayArray[section];
        _Fh.RecLable.text = model.ID;
        _Fh.sate.text = model.Status;
        if (model.isCancl == YES) {
            _Fh.sate.textColor = [UIColor grayColor];
            _Fh.sate.text = @"订单已取消";
        }
        if ([model.Status isEqualToString:@"订单已取消"]) {
            _Fh.sate.textColor = [UIColor grayColor];
        }
        
        return self.Fh;
    }else if (tableView.tag == 102) {
        MyOrderBaseModel*model = _FaArray[section];
        _Fh.RecLable.text = model.ID;
        _Fh.sate.text = model.Status;
        return self.Fh;
    }else if (tableView.tag == 103) {
        MyOrderBaseModel*model = _ShArray[section];
        _Fh.RecLable.text = model.ID;
        _Fh.sate.text = model.Status;
        return self.Fh;
    }else{
        MyOrderBaseModel*model = _EvalArray[section];
        _Fh.RecLable.text = model.ID;
        _Fh.sate.text = model.Status;
        return self.Fh;
    }
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _Fv = [[NSBundle mainBundle]loadNibNamed:@"MineOrderFootView" owner:nil options:nil].lastObject;
    _Fv.frame = CGRectMake(0, 0, KWIDTH, 90);
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 80, KWIDTH, 10)];
    line.backgroundColor = ZXColor(239, 239, 241, 1);
    [_Fv addSubview:line];
    _Fv.Multi_Function_Button.layer.borderWidth = 1;
    _Fv.Multi_Function_Button.layer.borderColor = [UIColor orangeColor].CGColor;
    _Fv.Multi_Function_Button.layer.cornerRadius = 4;
    _Fv.Multi_Function_Button.layer.masksToBounds = YES;
    _Fv.CanclButton.layer.borderWidth = 1;
    _Fv.CanclButton.layer.borderColor = [UIColor blackColor].CGColor;
    _Fv.CanclButton.layer.cornerRadius = 4;
    _Fv.CanclButton.layer.masksToBounds = YES;
    _Fv.CanclButton.tag = section+10;
    _Fv.Multi_Function_Button.tag = section+100;
    _Fv.AdressLable.hidden = YES;
    _Fv.CanclButton.hidden = NO;
    _Fv.GetGoodsAdrssLable.hidden = YES;
    
    _Fv.Multi_Function_Button.layer.borderColor = [UIColor orangeColor].CGColor;
    [_Fv.Multi_Function_Button setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    
    
    if ([tableView isEqual:self.oneTB]) {
        MyOrderBaseModel*model = _ALlArray[section];
        
        _Fv.GoodsLable.text = [NSString stringWithFormat:@"共%@件商品",model.TotalCount];
        _Fv.PriceLable.text = [NSString stringWithFormat:@"¥%.2f",model.TotalPrice.floatValue];
        _Fv.YunFeiLable.text = [NSString stringWithFormat:@"(含运费¥%.1f)",model.Freight.floatValue];
        [_Fv.Multi_Function_Button addTarget:self action:@selector(ALLGo_TO_Pay:) forControlEvents:(UIControlEventTouchUpInside)];
        if (model.isDelete == YES) {
            [_Fv.CanclButton setTitle:@"删除订单" forState:(UIControlStateNormal)];
            [_Fv.CanclButton addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
            [_Fv.Multi_Function_Button setTitle:@"去评价" forState:(UIControlStateNormal)];
            
            
        }else
        {
            [_Fv.Multi_Function_Button setTitle:@"去支付" forState:(UIControlStateNormal)];
            [_Fv.CanclButton addTarget:self action:@selector(canclBnt:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        if ([model.Status isEqualToString:@"正在出库"]) {
            _isWatiing = YES;
            model.isWatiing = YES;
            
        }
        if ([model.Status isEqualToString:@"配送中"]) {
            model.isSure = YES;
            _Fv.GetGoodsAdrssLable.hidden = NO;
            _Fv.AdressLable.hidden = NO ;
            _Fv.AdressLable.text = model.RecvTime;
            
        }
        if ([model.Status isEqualToString:@"已完成"]) {
            [_Fv.Multi_Function_Button setTitle:@"删除订单" forState:(UIControlStateNormal)];
            [_Fv.Multi_Function_Button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            
            _Fv.Multi_Function_Button.layer.borderColor = [UIColor blackColor].CGColor;
            _Fv.CanclButton.hidden = YES;
        }
        
        
        if (model.isCancl == YES) {
            [_Fv.Multi_Function_Button setTitle:@"删除订单" forState:(UIControlStateNormal)];
            [_Fv.Multi_Function_Button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            
            _Fv.Multi_Function_Button.layer.borderColor = [UIColor blackColor].CGColor;
            _Fv.CanclButton.hidden = YES;
            
        }
        if (model.isWatiing == YES) {
            _Fv.CanclButton.hidden = YES;
            [_Fv.Multi_Function_Button setTitle:@"提醒发货" forState:(UIControlStateNormal)];
            [_Fv.Multi_Function_Button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            _Fv.Multi_Function_Button.layer.borderColor = [UIColor blackColor].CGColor;
            
            
        }
        if (model.isSure == YES) {
            _Fv.CanclButton.hidden = YES;
            [_Fv.Multi_Function_Button setTitle:@"确认收货" forState:(UIControlStateNormal)];
            [_Fv.Multi_Function_Button setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
            _Fv.Multi_Function_Button.layer.borderColor = [UIColor orangeColor].CGColor;
            
            
        }
        
    }else if ([tableView isEqual:self.towTB]) {
        
        [_Fv.CanclButton addTarget:self action:@selector(PaycanclBnt:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _Fv.GetGoodsAdrssLable.hidden = YES;
        _Fv.AdressLable.hidden = YES;
        _Fv.CanclButton.hidden = NO;
        _Fv.Multi_Function_Button.layer.borderColor = [UIColor orangeColor].CGColor;
        [_Fv.Multi_Function_Button setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [_Fv.Multi_Function_Button addTarget:self action:@selector(PayGo_TO_Pay:) forControlEvents:(UIControlEventTouchUpInside)];
        MyOrderBaseModel*model = _PayArray[section];
        _Fv.GoodsLable.text = [NSString stringWithFormat:@"共%@件商品",model.TotalCount];
        _Fv.PriceLable.text = [NSString stringWithFormat:@"¥%.1f",model.TotalPrice.floatValue];
        _Fv.YunFeiLable.text = [NSString stringWithFormat:@"(含运费¥%.1f)",model.Freight.floatValue];
        
    }else if ([tableView isEqual:self.threeTB])
    {
        _Fv.GetGoodsAdrssLable.hidden = YES;
        _Fv.AdressLable.hidden = YES;
        _Fv.CanclButton.hidden = YES;
        [_Fv.Multi_Function_Button setTitle:@"提醒发货" forState:(UIControlStateNormal)];
        [_Fv.Multi_Function_Button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _Fv.Multi_Function_Button.layer.borderColor = [UIColor blackColor].CGColor;;
        [_Fv.Multi_Function_Button addTarget:self action:@selector(Remind_To_FA_goods) forControlEvents:(UIControlEventTouchUpInside)];
        MyOrderBaseModel*model = _FaArray[section];
        _Fv.GoodsLable.text = [NSString stringWithFormat:@"共%@件商品",model.TotalCount];
        _Fv.PriceLable.text = [NSString stringWithFormat:@"¥%.1f",model.TotalPrice.floatValue];
        _Fv.YunFeiLable.text = [NSString stringWithFormat:@"(含运费¥%.1f)",model.Freight.floatValue];
        //        _Fv.GetGoodsAdrssLable.text
    }else if ([tableView isEqual:self.fourTB])
    {
        _Fv.CanclButton.hidden = YES;
        _Fv.AdressLable.hidden = NO;
        _Fv.GetGoodsAdrssLable.hidden = NO;
        [_Fv.Multi_Function_Button setTitle:@"确认收货" forState:(UIControlStateNormal)];
        [_Fv.Multi_Function_Button setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        _Fv.Multi_Function_Button.layer.borderColor = [UIColor orangeColor].CGColor;
        [_Fv.Multi_Function_Button addTarget:self action:@selector(Sure_get_goods:) forControlEvents:(UIControlEventTouchUpInside)];
        MyOrderBaseModel*model = _ShArray[section];
        _Fv.GoodsLable.text = [NSString stringWithFormat:@"共%@件商品",model.TotalCount];
        _Fv.PriceLable.text = [NSString stringWithFormat:@"¥%.1f",model.TotalPrice.floatValue];
        _Fv.YunFeiLable.text = [NSString stringWithFormat:@"(含运费¥%.1f)",model.Freight.floatValue];
        _Fv.AdressLable.text = model.RecvTime;
        
    }else if ([tableView isEqual:self.fiveTB])
    {
        _Fv.GetGoodsAdrssLable.hidden = YES;
        _Fv.AdressLable.hidden = YES;
        _Fv.CanclButton.hidden = NO;
        _Fv.Multi_Function_Button.layer.borderColor = [UIColor orangeColor].CGColor;
        [_Fv.Multi_Function_Button setTitle:@"去评价" forState:(UIControlStateNormal)];
        [_Fv.CanclButton setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [_Fv.CanclButton addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
        [_Fv.Multi_Function_Button setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [_Fv.Multi_Function_Button addTarget:self action:@selector(Go_TO_Evaluate:) forControlEvents:(UIControlEventTouchUpInside)];
        MyOrderBaseModel*model = _EvalArray[section];
        _Fv.GoodsLable.text = [NSString stringWithFormat:@"共%@件商品",model.TotalCount];
        _Fv.PriceLable.text = [NSString stringWithFormat:@"¥%.1f",model.TotalPrice.floatValue];
        _Fv.YunFeiLable.text = [NSString stringWithFormat:@"(含运费¥%.1f)",model.Freight.floatValue];
        _Fv.AdressLable.text = model.RecvTime;
        
    }
    return _Fv;
}
//取消订单
- (void)canclBnt:(UIButton*)bnt
{
    NSLog(@"-=-=-=-=-取消订单-=-=-=-=-");
    
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    MyOrderBaseModel*model = _ALlArray[bnt.tag - 10];
    model.isCancl = NO;
    [[ShowMessageTools sharedInstance]showMessage:@"确定取消" controller:weakSelf block:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _ViewModel.Cancl_Or_DeleteBlock = ^(id Cancl_Or_deleteData){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([Cancl_Or_deleteData isEqualToString:@"删除成功"]) {
                        model.isCancl = YES;
                        //[weakSelf.PayArray removeObject:mode];
                        [weakSelf.towTB reloadData];
                        [weakSelf.oneTB reloadData];
                        
                        
                    };
                });
                
            };
        });
        [_ViewModel canclOrderWithOrderID:model.ID];
        
    } canclblock:^{
        return ;
    }];
    
    
}
- (void)PaycanclBnt:(UIButton*)bnt
{
    //待支付页面取消就是删除
    WK(weakSelf);
    MyOrderBaseModel*model = _PayArray[bnt.tag - 10];
    model.isCancl = NO;
    [[ShowMessageTools sharedInstance]showMessage:@"确定要取消订单吗?" controller:weakSelf block:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _ViewModel.Cancl_Or_DeleteBlock = ^(id Cancl_Or_deleteData){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([Cancl_Or_deleteData isEqualToString:@"删除成功"]) {
                        model.isCancl = YES;
                        [weakSelf.towTB reloadData];
                        [weakSelf.oneTB reloadData];
                        
                    };
                });
                
            };
        });
        [_ViewModel canclOrderWithOrderID:model.ID];
        
        [_PayArray  removeObject:model];
        if (_PayArray.count == 0) {
            weakSelf.NillImgP.hidden = NO;
        }
        [weakSelf.towTB reloadData];
    } canclblock:^{
        return ;
    }];
    
}

//去支付或者other
- (void)ALLGo_TO_Pay:(UIButton*)bb
{
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    MyOrderBaseModel*model = _ALlArray[bb.tag-100];
    
    if (model.isCancl == YES || model.isDone == YES) {
        //删除
        [[ShowMessageTools sharedInstance]showMessage:@"确定删除?" controller:weakSelf block:^{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                _ViewModel.Cancl_Or_DeleteBlock = ^(id Cancl_Or_deleteData){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([Cancl_Or_deleteData isEqualToString:@"删除成功"]) {
                            [weakSelf.ALlArray removeObjectAtIndex:bb.tag-100];
                            if (_ALlArray.count == 0) {
                                weakSelf.NillImg.hidden = NO;
                            }
                            [weakSelf.oneTB reloadData];
                        };
                    });
                    
                };
            });
            [_ViewModel deleteOrderWithOrderID:model.ID];
        } canclblock:^{
            return ;
        }];
    }else if(model.isWatiing == YES)
    {
        [[ShowMessageTools sharedInstance]showSimplMessage:@"已经提醒店家及时处理" controller:weakSelf];
        NSLog(@"-=-=-=-=-正在发货=-=-=-=-=-");
    }else if(model.isSure == YES)
    {
        //确认收货
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _ViewModel.Cancl_Or_DeleteBlock = ^(id Cancl_Or_deleteData){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[ShowMessageTools sharedInstance]showMessage:@"确认收货"  controller:weakSelf block:^{
                        if ([Cancl_Or_deleteData isEqualToString:@"收货成功"]) {
                            [weakSelf requestALL];
                            [weakSelf.oneTB reloadData];
                        };
                    } canclblock:^{
                        NSLog(@"gujgj");
                    }];
                    
                    
                    
                });
            };
        });
        [_ViewModel sureGetGoodsWithOrderID:model.ID];
        NSLog(@"-=-=-=-=-已收货=-=-=-=-=-");
    }else if(model.isDelete == YES)
    {
        ESLEvaluateViewController*EvaVC = [[ESLEvaluateViewController alloc]init];
        EvaVC.orderNum = model.ID;
        EvaVC.sectionArray = model.Content;
        [self.navigationController pushViewController:EvaVC animated:YES];
        NSLog(@"-=-=-=-=-评价=-=-=-=-=-");
    }else
    {
        ESLPaymentController*payVC = [[ESLPaymentController alloc]init];
        payVC.orderNum = model.ID;
        payVC.priceLabel = model.TotalPrice;
        payVC.isCome = YES;
        payVC.isBB = YES;
        [self.navigationController pushViewController:payVC animated:YES];
        NSLog(@"-=-=-=-=-去支付=-=-=-=-=-");
    }
    
}
//待支付页面
- (void)PayGo_TO_Pay:(UIButton*)bb
{
    
    MyOrderBaseModel*model = _PayArray[bb.tag-100];
    
    ESLPaymentController*payVC = [[ESLPaymentController alloc]init];
    payVC.orderNum = model.ID;
    payVC.priceLabel = model.TotalPrice;
    payVC.isCome = YES;
    payVC.isBB = YES;
    [self.navigationController pushViewController:payVC animated:YES];
    NSLog(@"-=-=-=-=-去支付=-=-=-=-=-");
    
    
}
//提醒发货
- (void)Remind_To_FA_goods
{
    [[ShowMessageTools sharedInstance]showSimplMessage:@"已经提醒店家及时处理" controller:self];
    
    NSLog(@"-=-=-=-=-提醒发货=-=-=-=-=-");
    
}
//确认收货
- (void)Sure_get_goods:(UIButton*)bb
{
    //确认收货
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    MyOrderBaseModel*model = _ShArray[bb.tag-100];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _ViewModel.Cancl_Or_DeleteBlock = ^(id Cancl_Or_deleteData){
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ShowMessageTools sharedInstance]showMessage:@"确认收货" controller:weakSelf block:^{
                    if ([Cancl_Or_deleteData isEqualToString:@"收货成功"]) {
                        [weakSelf.ShArray removeObjectAtIndex:bb.tag-100];
                        if (_ShArray.count == 0) {
                            weakSelf.NillImgS.hidden = NO;
                        }
                        [weakSelf.fourTB reloadData];
                    };
                } canclblock:^{
                    
                }];
                
            });
            
        };
    });
    
    [_ViewModel sureGetGoodsWithOrderID:model.ID];
    NSLog(@"-=-=-=-=-确认收货=-=-=-=-=-");
    
}
//去评价
- (void)Go_TO_Evaluate:(UIButton*)bb
{
    MyOrderBaseModel*model = _EvalArray[bb.tag-100];
    
    ESLEvaluateViewController*EvaVC = [[ESLEvaluateViewController alloc]init];
    EvaVC.orderNum = model.ID;
    EvaVC.sectionArray = model.Content;
    [self.navigationController pushViewController:EvaVC animated:YES];
    NSLog(@"-=-=-=-=-去评价=-=-=-=-=-");
    
}
//删除
- (void)delete:(UIButton*)deleBnt
{
    
    NSLog(@"-=-=-=-=-=删除-=-=-=-=");
    _ViewModel = [[MyOrderViewModel alloc]init];
    WK(weakSelf);
    MyOrderBaseModel*model = _ALlArray[deleBnt.tag-10];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _ViewModel.Cancl_Or_DeleteBlock = ^(id Cancl_Or_deleteData){
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([Cancl_Or_deleteData isEqualToString:@"删除成功"]) {
                    [weakSelf.ALlArray removeObjectAtIndex:deleBnt.tag-10];
                    if (_ALlArray.count == 0) {
                        weakSelf.NillImg.hidden = NO;
                    }
                    [weakSelf.oneTB reloadData];
                    //                    [weakSelf.fiveTB reloadData];
                };
            });
            
        };
    });
    
    [_ViewModel deleteOrderWithOrderID:model.ID];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 90;
}
#define scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView == _MainScorllView) {
        CGFloat x = scrollView.contentOffset.x;
        
        if (x==KWIDTH) {
            UIButton*bb = [self.view viewWithTag:10001];
            [self moveLineView:bb];
        }else if (x==KWIDTH*2)
        {
            UIButton*bb = [self.view viewWithTag:10002];
            [self moveLineView:bb];
        }else if (x==KWIDTH*3)
        {
            UIButton*bb = [self.view viewWithTag:10003];
            [self moveLineView:bb];
        }else if (x==KWIDTH*4)
        {
            
            UIButton*bb = [self.view viewWithTag:10004];
            [self moveLineView:bb];
        }else
        {
            UIButton*bb = [self.view viewWithTag:10000];
            [self moveLineView:bb];
        }
    }
    NSInteger tag = scrollView.contentOffset.x/KWIDTH+10000;
    [self chanageBntTitleColor:tag];
    
}
- (void)AllbuttonClick:(UIButton*)bnt
{
    [self requestALL];
    
    [self moveLineView:bnt];
    
    [self.MainScorllView setContentOffset:CGPointMake(0, -54)];
    
    [self chanageBntTitleColor:bnt.tag];
    [self.oneTB reloadData];
}
- (void)WaitingPaybuttonClick:(UIButton*)bnt
{
    [self requestNO_Pay];
    [self moveLineView:bnt];
    
    [self.MainScorllView setContentOffset:CGPointMake(KWIDTH, -54)];
    
    [self chanageBntTitleColor:bnt.tag];
    [self.towTB reloadData];
    
}
- (void)WaitingShipmentsbuttonClick:(UIButton*)bnt
{
    [self moveLineView:bnt ];
    [self.MainScorllView setContentOffset:CGPointMake(KWIDTH*2, -54)];
    [self requestNO_fa];
    
    [self chanageBntTitleColor:bnt.tag];
    [self.threeTB reloadData];
}
- (void)WaitingShouHuobuttonClick:(UIButton*)bnt
{
    [self requestNo_shou];
    
    [self moveLineView:bnt ];
    [self.MainScorllView setContentOffset:CGPointMake(KWIDTH*3, -54)];
    
    [self chanageBntTitleColor:bnt.tag];
    
    [self.fourTB reloadData];
}
- (void)WaitingEvaluatebuttonClick:(UIButton*)bnt
{
    [self moveLineView:bnt ];
    [self.MainScorllView setContentOffset:CGPointMake(KWIDTH*4, -54)];
    [self requestEvla];
    NSLog(@"%@",self.EvalArray);
    [self chanageBntTitleColor:bnt.tag];
    [self.fiveTB reloadData];
    
}
- (void)moveLineView:(UIButton*)bb1
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect test = self.lineView.frame;
        test.origin.x = 10+KWIDTH/5*(bb1.tag-10000);
        self.lineView.frame = test;
        [bb1 setTitleColor:ZXColor(55, 178, 34, 1) forState:(UIControlStateNormal)];
    }];
    
}
- (void)chanageBntTitleColor:(NSInteger)tag
{
    if (tag == 10000) {
        [self.WaitingPaybutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShipmentsbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShouHuobutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingEvaluatebutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        
    }else if (tag == 10001)
    {
        [self.Allbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShipmentsbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShouHuobutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingEvaluatebutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        
    }else if (tag == 10002)
    {
        [self.WaitingPaybutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.Allbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShouHuobutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingEvaluatebutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        
    }else if (tag == 10003)
    {
        [self.WaitingPaybutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShipmentsbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.Allbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingEvaluatebutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        
    }else if (tag == 10004)
    {
        [self.WaitingPaybutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShipmentsbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.WaitingShouHuobutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.Allbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view]destroy];
    
}
- (void)dealloc
{
    self.NillImg = nil;
    self.NillImgP = nil;
    self.NillImgE = nil;
    self.NillImgF = nil;
    self.NillImgS = nil;
}

- (void)rebackToRootViewAction {
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

