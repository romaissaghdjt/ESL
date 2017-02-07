
//
//  ConfirmOrderController.m
//  ESL
//
//  Created by 徐恒 on 16/10/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "InformationCell.h"
#import "ContentCell.h"
#import "ESLCuisineCell.h"
#import "ESLConfirmBottomView.h"
#import "ESLDeliveryTime.h"
#import "ESLPaymentController.h"
#import "FeastAllModel.h"
#import "ESLSingleProModel.h"
#import "ESLDeliveryTime.h"
#import "ShoppingAddressController.h"
#import "ESLCuisineController.h"
#import "ESLSureModel.h"
#import "ESLPaymentController.h"
#import "CLCalendarViewController.h"
@interface ConfirmOrderController () <UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate,UITextFieldDelegate>
@property (strong, nonatomic)UITableView *TableView;
@property (strong, nonatomic)UIView *backgroundView;
@property (strong , nonatomic)UIView *cuisineView;
@property (strong , nonatomic)ESLCuisineController *cuisineC;
@property (strong, nonatomic)ESLDeliveryTime *deliverTime;
@property (strong , nonatomic)ESLConfirmBottomView *confirmBV;
@property (strong , nonatomic)ESLSingleProModel *Pmodel;
@property (strong , nonatomic)FeastAllModel*Fmodel;
@property (assign , nonatomic)BOOL isNeed;
//地址
@property (strong , nonatomic)NSMutableArray *addArray;
@property (strong , nonatomic) NSMutableArray *arr;
@property (strong , nonatomic)NSString *orderNumber;//订单号
@property (strong , nonatomic)NSString *returnPrice;//总价
@property (strong , nonatomic)NSString *Reason;//失败原因
@property (strong, nonatomic)UIView *clearView;//挡板
@property (strong, nonatomic)UIView *barckView;//厨师价格表
@property (assign, nonatomic)CGFloat  sum1;
@property (assign, nonatomic)CGFloat  sun;

@property (strong, nonatomic)NSString *FreightPoint;//比较是否收取运费请求的值
@property (strong, nonatomic)NSString *OrderFreight;
@property (strong, nonatomic)UIButton *noonBtn;//中午
@property (strong, nonatomic)UILabel *noonLab;//中午
@property (strong, nonatomic)UIButton *eveningBtn;//晚上;
@property (strong, nonatomic)UILabel *eveningLab;//晚上
@property (strong, nonatomic)UIButton *determine;//需要厨师弹出框上的确认按钮
@property (strong, nonatomic)NSString *record;//记录选择的是中午还是晚上

@end
@implementation ConfirmOrderController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isRefresh ==  YES) {
         [self request];
    }
}
- (void)dismiss
{
    self.tabBarController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"确认订单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    _isNeed = NO;
    [self createTableView];
    [self createFooterView];
    [self request];
    [self requestForFreight];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
 }
-(void)backClick:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#define mark ==获取运费
- (void)requestForFreight{
    // http://120.27.141.95:9225/ashx/Other.ashx?Function=HttpGetConfig
    NSString *url = [PREURL stringByAppendingString:@"Other.ashx?Function=HttpGetConfig"];
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"===%@",dic);
        self.FreightPoint = dic[@"FreightPoint"];//比较的价格
        self.OrderFreight = dic[@"OrderFreight"];//实际运费
        [self ComprehensivePrice];
    } failedWithError:^(NSError *Error) {
        
    }];
}
//底部视图
-(void)createFooterView{
    _confirmBV = [[ESLConfirmBottomView alloc]initWithFrame:CGRectMake(0, KHEIGHT-40, KWIDTH, 40)];
    _confirmBV.backgroundColor = ZXColor(248, 248, 248, 1);
    [_confirmBV.submit setTitle:@"提交订单" forState: UIControlStateNormal];
    [_confirmBV.submit setTitle:@"提交订单" forState:UIControlStateSelected];
    [_confirmBV.submit addTarget:self action:@selector(ConfirmSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBV];
}
#pragma mark-网络请求-
- (void)request{
//    NSString *str = [[NSUserDefaults standardUserDefaults ]objectForKey:@"us"];
    NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"User.ashx?Function=HttpQueryDefaultRecvAddr&UserTel=%@&UserPhyAdd=%@"],us,KUUID];
    [zJRequestManager requestWithUrl:url parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSArray *key = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"key==%@",key);
        if (key.count == 0) {
            self.TableView.hidden = YES;
            _confirmBV.totalPrice.text = @"0.00";
            [self showAddressEmptyMessage:@"您还没有收货地址,请添加~!"];
            return ;
        }else{
            
            self.TableView.hidden = NO;
            self.addArray = [NSMutableArray array];
            for (NSDictionary *dic in key) {
                
                ESLSureModel *Suremodel = [[ESLSureModel alloc]init];
                [Suremodel setValuesForKeysWithDictionary:dic];
                [self.addArray addObject:Suremodel];
        }
        }
      
            [self.TableView reloadData];
        
    } failedWithError:^(NSError *connectionError) {
        
    }];

}
//底部综合价格
- (void)ComprehensivePrice{
    _sum1 = 0;
    _sun  = 0;
    CGFloat sun = 0;
    CGFloat sum = 0;
    for (_Pmodel in self.singleProArray) {
       
        sun = sun + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
    }
    for (_Fmodel in self.feastArray) {
        sum = sum + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
    }
    _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",sun + sum];
    NSLog(@"self.FreightPoint.integerValue===%@\n _confirmBV.totalPrice.text=== %@",self.FreightPoint,_confirmBV.totalPrice.text);

    if ( _confirmBV.totalPrice.text.integerValue< self.FreightPoint.integerValue) {
        _confirmBV.freightLab.text = [NSString stringWithFormat:@"含运费¥%ld元",self.OrderFreight.integerValue];
        for (_Pmodel in self.singleProArray) {
            _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
        }
        for (_Fmodel in self.feastArray) {
            _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
        }
        _confirmBV.totalPrice.text = [NSString stringWithFormat:@"¥%.2f",_sun + _sum1+self.OrderFreight.integerValue];
        
    }else{
        for (_Pmodel in self.singleProArray) {
            _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
        }
        for (_Fmodel in self.feastArray) {
            _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
        }
        _confirmBV.totalPrice.text = [NSString stringWithFormat:@"¥%.2f",_sun + _sum1];
        _confirmBV.freightLab.text = @"免运费";
    }
    
    [self.TableView reloadData];
}
/*提交订单*/
-(void)ConfirmSubmitClick:(UIButton *)sender{
    
   sender.selected =! sender.selected;
    if (_confirmBV.submit.selected) {
        _confirmBV.submit.userInteractionEnabled = NO;
        //套餐
        _arr = [NSMutableArray array];
        if (self.type == FREASH || self.type == SNAP) {
            //直接购买单品
            for (ESLSingleProModel *singModel in self.singleProArray) {
                self.Pmodel = singModel;
                for (SingleSubModel*model in singModel.subArray) {
                    NSMutableDictionary *dica = [NSMutableDictionary dictionary];
                    dica[@"ID"] = model.ID;
                    dica[@"Count"] = model.subNum;
                    [_arr addObject:dica];
                }
            }
        }else{
        for (FeastAllModel*modle in self.feastArray) {
            self.Fmodel = modle;
            NSMutableDictionary*dic = [NSMutableDictionary dictionary];
            dic[@"ProID"] = modle.ID;
            dic[@"TotalCount"] = modle.totalCount;
            dic[@"ProductCgy"] = modle.ProductCgy;
            [_arr addObject:dic];
        }
        
        //抢购
            for (ESLSingleProModel *singModel in self.singleProArray) {
                self.Pmodel = singModel;
                NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
                dicc[@"ProID"] = singModel.proID;
                dicc[@"ProductCgy"] = singModel.count;
                [_arr addObject:dicc];
                
            }
        }
        NSString*str1 = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:_arr options:NSJSONWritingPrettyPrinted  error:nil] encoding:NSUTF8StringEncoding];
        
        if (self.type==SNAP || self.type == BAG) {
            NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=Freash&Function=HttpToBeRobbery&UserTel=%@&UserPhyAdd=%@&ProID=%@&GamishInfo=%@&TotalCount=%@"],us,KUUID,_Pmodel.proID,str1,_Pmodel.mainCount];//抢购单品
            NSString *url3 = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=FreashPackage&Function=HttpPreBuy&UserTel=%@&UserPhyAdd=%@&ProID=%@"],us,KUUID,_Fmodel.ID];//大礼包
            NSLog(@"url3==%@",url3);
            if (self.type==SNAP) {
                [self request1:url];
            }else if (self.type == BAG){
                [self request1:url3];
            }
        }else{
            
            if (_deliverTime.timenLabel.text.length==0){
                [self ChooseCalendarMessage:@"请选择送货日期"];
            }else {
                
                if (_isNeed==YES) {
                    if (_deliverTime.NeedBtn.selected&&_deliverTime.tableNum.text.length == 0) {
                        [self showWhyFailureMessage:@"请填写桌数"];
                    }else{
                        _confirmBV.submit.userInteractionEnabled = NO;
                        NSString *str = @"true";
        NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=ShoppingCart&Function=HttpsSubmit&UserTel=%@&UserPhyAdd=%@&RecvTime=%@&IsNeedCook=%@&Cuisine=%@&TableNumber=%@&ProArray=%@&DinnerTime=%@"],us,KUUID,_deliverTime.timenLabel.text,str,_deliverTime.CuisineBtn.titleLabel.text,_deliverTime.tableNum.text,str1,self.record];//购物车套餐
//                            NSLog(@"url==%@",url);
                        
        NSString *url1 = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpPreBuy&UserTel=%@&UserPhyAdd=%@&ProID=%@&TotalCount=%@&RecvTime=%@&TableNumber=%@&IsNeedCook=%@&DinnerTime=%@"],us,KUUID,_Fmodel.ID,_Fmodel.totalCount,_deliverTime.timenLabel.text,_deliverTime.tableNum.text,str,self.record];//套餐直接购买
                        
        NSString *url2 = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=Freash&Function=HttpPreBuy&UserTel=%@&UserPhyAdd=%@&ProID=%@&GamishInfo=%@&TotalCount=%@&RecvTime=%@&IsNeedCook=%@&Cuisine=%@&TableNumber=%@&DinnerTime=%@"],us,KUUID,_Pmodel.proID,str1,_Pmodel.mainCount,_deliverTime.timenLabel.text,str,_deliverTime.CuisineBtn.titleLabel.text,_deliverTime.tableNum.text,self.record];//单品
        
                        NSLog(@"url2==%@",url2);
                        if (self.type==PACKAGE){
                            [self request1:url1];
                        }else if(self.type==SHOPPING){
                            [self request1:url];
                        }else if (self.type == FREASH){
                            [self request1:url2];
                        }
                    }
                }else{
                    _confirmBV.submit.userInteractionEnabled = NO;

                    NSString *str = @"false";
                    
        NSString *url = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=ShoppingCart&Function=HttpsSubmit&UserTel=%@&UserPhyAdd=%@&RecvTime=%@&IsNeedCook=%@&Cuisine=%@&TableNumber=%@&ProArray=%@"],us,KUUID,_deliverTime.timenLabel.text,str,_deliverTime.CuisineBtn.titleLabel.text,_deliverTime.tableNum.text,str1];//购物车套餐
                    
        NSString *url1 = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=FreashSetMeal&Function=HttpPreBuy&UserTel=%@&UserPhyAdd=%@&ProID=%@&TotalCount=%@&RecvTime=%@&TableNumber=%@&IsNeedCook=%@"],us,KUUID,_Fmodel.ID,_Fmodel.totalCount,_deliverTime.timenLabel.text,_deliverTime.tableNum.text,str];//套餐直接购买
                    
        NSString *url2 = [NSString stringWithFormat:[PREURL stringByAppendingString:@"Shopping.ashx?Component=Product&ProModule=Freash&Function=HttpPreBuy&UserTel=%@&UserPhyAdd=%@&ProID=%@&GamishInfo=%@&TotalCount=%@&RecvTime=%@&IsNeedCook=%@&Cuisine=%@"],us,KUUID,_Pmodel.proID,str1,_Pmodel.mainCount,_deliverTime.timenLabel.text,str,_deliverTime.CuisineBtn.titleLabel.text];//单品
                    NSLog(@"%@",url2);

                    if (self.type==SHOPPING){
                        [self request1:url];
                    }else if(self.type==PACKAGE){
                        [self request1:url1];
                    }else if (self.type == FREASH){
                        [self request1:url2];
                    }
                }
            }
         }
       }
    }
- (void)request1:(NSString *)str{
    [zJRequestManager requestWithUrl:str parmDic:nil method:POST1 succeedWithData:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if ([dic[@"提示"] isEqualToString:@"此产品不可抢购"]) {
            [self.view showWarning:@"此产品不可抢购"];
        }
        self.orderNumber = dic[@"订单号"];
        self.returnPrice = dic[@"TotalPrice"];
        self.Reason  = dic[@"Reason"];
           [self show:dic];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)show:(NSDictionary *)dic{
    [self showSuccessfulMessage:dic[@"提示"]];
}
- (void)createTableView{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.tableFooterView = [UIView new];//去掉多余的线
    _TableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_TableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.feastArray.count == 0||self.singleProArray.count == 0) {
        return 2;
    }else
    {
        return 3;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        if (self.singleProArray.count == 0) {
            return self.feastArray.count;
        }
        return self.singleProArray.count;
    }else{
        return self.feastArray.count;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {//地址
        static NSString *ID = @"cella";
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ContentCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        ShoppingAddressController *addressC = [[ShoppingAddressController alloc]init];
        if (self.addArray.count == 0) {
            return cell;
        }else{
            ESLSureModel *Suremodel= self.addArray[indexPath.row];
            if (addressC.isEmpty == NO) {
                cell.Smodel = Suremodel;
            }else{
                cell.Smodel = nil;
            }
            return cell;
        }
        
    }else if (indexPath.section==1){//套餐
            if (self.singleProArray.count == 0) {
            //赵杰
            static NSString *IDa = @"cella";
            InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:IDa];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"InformationCell" owner:nil options:nil].lastObject;
            }
            FeastAllModel*Fmodel = self.feastArray[indexPath.row];
            cell.Fmodel = Fmodel;
            
            return cell;
        }
        else
        {
            //成龙
            static NSString *ID = @"cellb";
            ESLCuisineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"ESLCuisineCell" owner:nil options:nil].lastObject;
            }
            ESLSingleProModel *Pmodel = self.singleProArray[indexPath.row];
            cell.Pmodel = Pmodel;
            return cell;
        }
        
    }else{
        //赵杰
        static NSString *IDa = @"cella";
        InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:IDa];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"InformationCell" owner:nil options:nil].lastObject;
        }
        FeastAllModel*Fmodel = self.feastArray[indexPath.row];
        cell.Fmodel = Fmodel;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 70;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        if (self.type==SNAP ||self.type==BAG) {
            return 0;
        }
        return 100;
        
    }else{
        return 0.00f;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _deliverTime = [[ESLDeliveryTime alloc]init];
    self.TableView.tableFooterView = _deliverTime;

    if (section==0) {
        _deliverTime.backgroundColor = [UIColor whiteColor];
        [_deliverTime.CalendarBtn addTarget:self action:@selector(CalendarBtn:) forControlEvents:UIControlEventTouchUpInside];//选日历
        [_deliverTime.NeedBtn addTarget:self action:@selector(NeedBtnClick:) forControlEvents:UIControlEventTouchUpInside];//需要
        [_deliverTime.NoNeedBtn addTarget:self action:@selector(NoNeedBtnClick:) forControlEvents:UIControlEventTouchUpInside];//不需要
        [_deliverTime.CuisineBtn addTarget:self action:@selector(CuisineBtnClick:) forControlEvents:UIControlEventTouchUpInside];//菜系选择
        [_deliverTime.tableNum addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];//桌数
        _deliverTime.NoNeedBtn.selected = YES;
    }
    if ((section==0 &&self.type==SNAP)|| self.type==BAG) {
        _deliverTime.oneView.hidden = YES;
        _deliverTime.towView.hidden = YES;
    }
    return _deliverTime;
}
//限制桌数
- (void)textFieldDidChange:(UITextField *)textField{
   
    if (textField == _deliverTime.tableNum) {
        if (textField.text.length > 3) {
            textField.text = [textField.text substringToIndex:3];
        }
    }
}
//日历
- (void)CalendarBtn:(UIButton *)snder{
    CLCalendarViewController *cvc = [[CLCalendarViewController alloc]init];
    cvc.isFromOther = YES;
    self.isRefresh = NO;
    cvc.PushData = ^(NSString *date){
       _deliverTime.timenLabel.text = date;
    };
    [self.navigationController pushViewController:cvc animated:YES];
    
}
//菜系选择
-(void)CuisineBtnClick:(UIButton *)sender{
    
    ESLCuisineController *cuisine = [[ESLCuisineController alloc]init];
    cuisine.view.backgroundColor = ZXColor(60, 170, 40, 1);
    [self presentViewController:cuisine animated:YES completion:nil];
    self.isRefresh = NO;
    cuisine.block = ^(NSString *name){
        NSLog(@"%@", name);
        [_deliverTime.CuisineBtn setTitle:name forState:UIControlStateNormal];
        NSLog(@"===%@", _deliverTime.CuisineBtn.titleLabel.text);
    };
}
//需要
-(void)NeedBtnClick:(UIButton *)sender{
    sender.selected =! sender.selected;
    if (_deliverTime.NeedBtn.selected == YES) {
        [self popUpBox];
//        _deliverTime.NoNeedBtn.selected = NO;
//        _deliverTime.tableNum.userInteractionEnabled = YES;
        
        _isNeed = YES;
    }
    else{
        _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1];
        _deliverTime.NoNeedBtn.selected = YES;
        _deliverTime.tableNum.text = nil;
        _deliverTime.tableNum.userInteractionEnabled = NO;
        _isNeed = NO;
        
        _sum1 = 0;
        _sun  = 0;
        CGFloat sun = 0;
        CGFloat sum = 0;
        for (_Pmodel in self.singleProArray) {
            
            sun = sun + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
        }
        for (_Fmodel in self.feastArray) {
            sum = sum + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
        }
        _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",sun + sum];
        
        if ( _confirmBV.totalPrice.text.integerValue< self.FreightPoint.integerValue) {
            _confirmBV.freightLab.text = [NSString stringWithFormat:@"含运费¥%ld元",self.OrderFreight.integerValue];
            
            for (_Pmodel in self.singleProArray) {
                _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
            }
            for (_Fmodel in self.feastArray) {
                _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
            }
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+self.OrderFreight.integerValue];
        }else{
            for (_Pmodel in self.singleProArray) {
                _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
            }
            for (_Fmodel in self.feastArray) {
                _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
            }
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1];
            _confirmBV.freightLab.text = @"免运费";
        }


    }
}
//不需要
-(void)NoNeedBtnClick:(UIButton *)sender{
    sender.selected =! sender.selected;
    //    _deliverTime.NoNeedBtn.selected = !_deliverTime.NoNeedBtn.selected;
    if (_deliverTime.NoNeedBtn.selected == YES) {
        _deliverTime.NeedBtn.selected = NO;
        _deliverTime.tableNum.text = nil;
        _isNeed = NO;
        _deliverTime.tableNum.userInteractionEnabled = NO;
//    _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1];
        _sum1 = 0;
        _sun  = 0;
        CGFloat sun = 0;
        CGFloat sum = 0;
        for (_Pmodel in self.singleProArray) {
            
            sun = sun + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
        }
        for (_Fmodel in self.feastArray) {
            sum = sum + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
        }
        _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",sun + sum];
        if ( _confirmBV.totalPrice.text.integerValue< self.FreightPoint.integerValue) {
            _confirmBV.freightLab.text = [NSString stringWithFormat:@"含运费¥%ld元",self.OrderFreight.integerValue];
            
            for (_Pmodel in self.singleProArray) {
                _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
            }
            for (_Fmodel in self.feastArray) {
                _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
            }
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+self.OrderFreight.integerValue];
        }else{
            for (_Pmodel in self.singleProArray) {
                _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
            }
            for (_Fmodel in self.feastArray) {
                _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
            }
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1];
            _confirmBV.freightLab.text = @"免运费";
        }

    }else{
        _isNeed=YES;
        _deliverTime.NeedBtn.selected = YES;
        _deliverTime.tableNum.userInteractionEnabled = YES;
        [self popUpBox];
        _sum1 = 0;
        _sun  = 0;
        CGFloat sun = 0;
        CGFloat sum = 0;
        for (_Pmodel in self.singleProArray) {
            
            sun = sun + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
        }
        for (_Fmodel in self.feastArray) {
            sum = sum + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
        }
        _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",sun + sum];
        if ( _confirmBV.totalPrice.text.integerValue< self.FreightPoint.integerValue) {
            _confirmBV.freightLab.text = [NSString stringWithFormat:@"含运费¥%ld元",self.OrderFreight.integerValue];
            
            for (_Pmodel in self.singleProArray) {
                _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
            }
            for (_Fmodel in self.feastArray) {
                _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
            }
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+self.OrderFreight.integerValue];
        }else{
            for (_Pmodel in self.singleProArray) {
                _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
            }
            for (_Fmodel in self.feastArray) {
                _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
            }
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1];
            _confirmBV.freightLab.text = @"免运费";
        }
    }
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"订单详情";
    }else
    {
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        self.isRefresh = YES;
        ShoppingAddressController*ss = [[ShoppingAddressController alloc]init];
        ss.isother = YES;
        [self.navigationController pushViewController:ss animated:YES];
    }
}
//需要出示的弹出框
- (void)popUpBox{
    if (!self.clearView) {
        _clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
        _clearView.backgroundColor = ZXColor(127, 127, 127, 0.5);
        [self.view addSubview:_clearView];
        if (!self.barckView) {
            _barckView = [[UIView alloc]initWithFrame:CGRectMake((KWIDTH-310)*0.5, (KHEIGHT-250)*0.5, 310, 250)];
            _barckView.backgroundColor = [UIColor whiteColor];
            _barckView.layer.cornerRadius = 10;
            _barckView.layer.masksToBounds = YES;
            
            //title
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _barckView.frame.size.width, 30)];
            titleLab.text = @"厨师价格说明";
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.font = [UIFont systemFontOfSize:18];
            titleLab.backgroundColor = ZXColor(61, 176, 47, 1);
            titleLab.textColor = [UIColor whiteColor];
            [_barckView addSubview:titleLab];
            
            UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, _barckView.frame.size.width, 30)];
            contentLab.text = @"根据订单价格确定厨师价格:";
            contentLab.font = [UIFont systemFontOfSize:17];
            contentLab.textAlignment = NSTextAlignmentCenter;
            [_barckView addSubview:contentLab];
            
            
            NSString *str  = @"订单价格<700元,厨师服务费300元;";
            NSString *str1 = @"700元<订单价格<1000元,厨师服务费400元;";
            NSString *str2 = @"订单价格>1000元,厨师服务费500元;";
            
            UILabel *headLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, _barckView.frame.size.width, 30)];
            headLab.numberOfLines = 0;
            headLab.font = [UIFont systemFontOfSize:15];
            headLab.text = [NSString stringWithFormat:@"%@",str];
            headLab.textAlignment = NSTextAlignmentCenter;
            [_barckView addSubview:headLab];
            
            UILabel *headLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, _barckView.frame.size.width, 30)];
            headLab1.numberOfLines = 0;
            headLab1.font = [UIFont systemFontOfSize:15];
            headLab1.text = [NSString stringWithFormat:@"%@",str1];
            headLab1.textAlignment = NSTextAlignmentCenter;
            [_barckView addSubview:headLab1];
            
            UILabel *headLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, _barckView.frame.size.width, 30)];
            headLab2.numberOfLines = 0;
            headLab2.font = [UIFont systemFontOfSize:15];
            headLab2.text = [NSString stringWithFormat:@"%@",str2];
            headLab2.textAlignment = NSTextAlignmentCenter;
            [_barckView addSubview:headLab2];
            
            UILabel *headingsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, headLab2.frame.origin.y+30, _barckView.frame.size.width, 30)];
            headingsLab.numberOfLines = 0;
            headingsLab.textAlignment = NSTextAlignmentCenter;
            headingsLab.font = [UIFont systemFontOfSize:17];
            headingsLab.text = @"请选择用餐时间:";
            headingsLab.textAlignment = NSTextAlignmentCenter;
            [_barckView addSubview:headingsLab];
        
            UILabel *noonLab = [[UILabel alloc]initWithFrame:CGRectMake(63, headingsLab.frame.origin.y+25, 40, 30)];
            noonLab.numberOfLines = 0;
            noonLab.textAlignment = NSTextAlignmentCenter;
            noonLab.font = [UIFont systemFontOfSize:16];
            noonLab.text = @"中午";
//            noonLab.backgroundColor = [UIColor greenColor];
            noonLab.textAlignment = NSTextAlignmentCenter;
            [_barckView addSubview:noonLab];
            self.noonLab = noonLab;
            
            UIButton *noonBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noonLab.frame)+20, headingsLab.frame.origin.y+30, 22, 22)];
            [noonBtn setImage:defaultImg forState:UIControlStateNormal];
            [noonBtn setImage:seletedImg forState:UIControlStateSelected];
            [noonBtn addTarget:self action:@selector(noonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            self.noonBtn = noonBtn;
            [_barckView addSubview:noonBtn];
            
            
            UILabel *eveningLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noonBtn.frame)+20, headingsLab.frame.origin.y+25, 40, 30)];
            eveningLab.numberOfLines = 0;
            eveningLab.textAlignment = NSTextAlignmentCenter;
            eveningLab.font = [UIFont systemFontOfSize:16];
            eveningLab.text = @"晚上";
//            eveningLab.backgroundColor = [UIColor greenColor];
            eveningLab.textAlignment = NSTextAlignmentCenter;
            [_barckView addSubview:eveningLab];
            self.eveningLab = eveningLab;
            
            
            UIButton *eveningBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(eveningLab.frame)+20, headingsLab.frame.origin.y+30, 22, 22)];
            [eveningBtn setImage:defaultImg forState:UIControlStateNormal];
            [eveningBtn setImage:seletedImg forState:UIControlStateSelected];
            [eveningBtn addTarget:self action:@selector(eveningBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            eveningBtn.backgroundColor = [UIColor redColor];
            [_barckView addSubview:eveningBtn];
            self.eveningBtn = eveningBtn;
            
            UIButton *determine = [[UIButton alloc]initWithFrame:CGRectMake((_barckView.frame.size.width-60)*0.5, _barckView.frame.size.height-40, 60, 30)];
            [determine setTitle:@"确定" forState:UIControlStateNormal];
            determine.layer.cornerRadius = 2;
            determine.layer.masksToBounds = YES;
            determine.backgroundColor = ZXColor(86, 160, 48, 1);
            [determine addTarget:self action:@selector(determineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_barckView addSubview:determine];
            self.determine = determine;
            self.noonBtn.selected = YES;
            self.record = @"中午";
            [_clearView addSubview:_barckView];
        }
    }else{
        self.clearView.hidden = NO;
        self.barckView.hidden = NO;
    }
}
//中午
-(void)noonBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.noonBtn.selected = YES;
        self.eveningBtn.selected = NO;
        self.record = @"中午";
    }else{
        self.eveningBtn.selected = YES;
        self.noonBtn.selected = NO;
        self.record = @"晚上";
    }
}
//晚上
-(void)eveningBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.eveningBtn.selected = YES;
        self.noonBtn.selected = NO;
        self.record = @"晚上";

    }else{
        self.eveningBtn.selected = NO;
        self.noonBtn.selected = YES;
        self.record = @"中午";

    }
}
//需要厨师弹出框的点击事件
- (void)determineBtnClick:(UIButton*)sender
{
    _deliverTime.NoNeedBtn.selected = NO;
    _deliverTime.tableNum.userInteractionEnabled = YES;
    [_deliverTime.tableNum becomeFirstResponder];
    
    _sum1 = 0;
    _sun  = 0;
    CGFloat sun = 0;
    CGFloat sum = 0;
    for (_Pmodel in self.singleProArray) {
        
        sun = sun + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
    }
    for (_Fmodel in self.feastArray) {
        sum = sum + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
    }
    _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",sun + sum];
    NSLog(@"self.FreightPoint.integerValue===%@\n _confirmBV.totalPrice.text=== %@",self.FreightPoint,_confirmBV.totalPrice.text);
    
//    if ( _confirmBV.totalPrice.text.integerValue< self.FreightPoint.integerValue) {
//        _confirmBV.freightLab.text = [NSString stringWithFormat:@"含运费¥%ld元",self.OrderFreight.integerValue];
//        
//        for (_Pmodel in self.singleProArray) {
//            _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
//        }
//        for (_Fmodel in self.feastArray) {
//            _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
//        }
//        
//        if (_sun+_sum1<700) {
//            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+300+self.OrderFreight.integerValue];
//        }else if (_sun+_sum1>700&&_sun+_sum1<1000){
//            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+400+self.OrderFreight.integerValue];
//        }else{
//            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+500+self.OrderFreight.integerValue];
//        }
//    }else{
        for (_Pmodel in self.singleProArray) {
            _sum1 = _sum1 + (_Pmodel.mainPrice.floatValue) * (_Pmodel.mainCount.floatValue ) + _Pmodel.gamishTotalPrice.floatValue;
        }
        for (_Fmodel in self.feastArray) {
            _sun = _sun + (_Fmodel.Price.floatValue)*(_Fmodel.totalCount.integerValue);
        }
        if (_sun+_sum1<700) {
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+300];
        }else if (_sun+_sum1>700&&_sun+_sum1<1000){
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+400];
        }else{
            _confirmBV.totalPrice.text = [NSString stringWithFormat:@"%.2f",_sun + _sum1+500];
        }
    if ( _confirmBV.totalPrice.text.integerValue< self.FreightPoint.integerValue) {
        _confirmBV.freightLab.text = [NSString stringWithFormat:@"含运费¥%ld元",self.OrderFreight.integerValue];
    }
    else
    {
        _confirmBV.freightLab.text = @"免运费";
    }
//    }
    
    [self.TableView reloadData];
    self.clearView.hidden = YES;
    self.barckView.hidden = YES;
}
//选日历的时候调用这个
- (void)ChooseCalendarMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        _confirmBV.submit.userInteractionEnabled = YES;
        
        CLCalendarViewController *cvc = [[CLCalendarViewController alloc]init];
        cvc.isFromOther = YES;
        self.isRefresh = NO;
        cvc.PushData = ^(NSString *date){
            _deliverTime.timenLabel.text = date;
        };
        [self.navigationController pushViewController:cvc animated:YES];
    }];
    
    [alert addAction:cancelAction];
}

////没选中午或者晚上的调用
//- (void)showFailureMessage:(NSString *)message {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
//    [self presentViewController:alert animated:YES completion:nil];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
////        _confirmBV.submit.userInteractionEnabled = YES;
////        _deliverTime.tableNum.userInteractionEnabled = YES;
////        [_deliverTime.tableNum becomeFirstResponder];
//    }];
//    
//    [alert addAction:cancelAction];
//}

//桌数没填的时候调用这个
- (void)showWhyFailureMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        _confirmBV.submit.userInteractionEnabled = YES;
        _deliverTime.tableNum.userInteractionEnabled = YES;
        [_deliverTime.tableNum becomeFirstResponder];
    }];
    
    [alert addAction:cancelAction];
}
//成功
- (void)showSuccessfulMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message: message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        _confirmBV.submit.userInteractionEnabled = YES;
        WK(weakSelf)
        if ([message isEqualToString:@"提交失败"]||[message isEqualToString:@"预定失败"]||[message isEqualToString:@"抢购失败"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else if ([message isEqualToString:@"提交成功"]||[message isEqualToString:@"预定成功"]||[message isEqualToString:@"抢购成功"]){
        // 进入支付界面
        ESLPaymentController *PaymentC = [[ESLPaymentController alloc]init];
        PaymentC.priceLabel = self.returnPrice;//总价
        PaymentC.orderNum = self.orderNumber;//订单号
        if (self.type == SNAP) {
            PaymentC.isSnap = YES;
        }
        [self.navigationController pushViewController:PaymentC animated:YES];
    }
    }];
    [alert addAction:confirm];

}
//地址为空调用
- (void)showAddressEmptyMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    WK(weakSelf)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        _confirmBV.submit.userInteractionEnabled = YES;

        ShoppingAddressController*ss = [[ShoppingAddressController alloc]init];
        ss.isother = YES;
        [self.navigationController pushViewController:ss animated:YES];
    }];
  
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
}
//补齐 cell 右边缺失的线条
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (NSMutableArray *)arr {
    if (!_arr) {
        _arr = [[NSMutableArray alloc]init];
    }
    return _arr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

