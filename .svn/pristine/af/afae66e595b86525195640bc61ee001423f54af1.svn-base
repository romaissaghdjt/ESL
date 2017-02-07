//
//  ShippingAddressController.m
//  ESL
//
//  Created by 徐恒 on 16/9/27.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "ShoppingAddressController.h"
#import "AddressCell.h"
#import "Shopping_Add_New_AddressController.h"
#import "AddressMolde.h"
#import "AddressBaseViewModel.h"
#import "ESLShopCartViewController.h"
#import "ESLFeastDetailViewController.h"
#import "ESLFoodInfoViewController.h"
#import "Shopping_Add_New_AddressController.h"
#import "ConfirmOrderController.h"
@interface ShoppingAddressController ()<UITableViewDelegate,UITableViewDataSource,Shopping_Add_New_AddressControllerDelegate>
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong)UIButton*AddButton;
@property (nonatomic,strong)NSMutableArray*chooseButtonStateAry;
@property (nonatomic,assign)NSInteger i;
@property (nonatomic,strong)UILabel *lable;
@property (strong, nonatomic)ESLShopCartViewController *shoppingCC;
@property (strong, nonatomic)ESLFeastDetailViewController*FDVC;
@property (strong, nonatomic)ESLFoodInfoViewController *fivc;
//@property (strong, nonatomic)Shopping_Add_New_AddressController *AddressC;
@property (strong, nonatomic)ConfirmOrderController *confirmOC;

@property (nonatomic,strong)HUDView*hh;
@end


@implementation ShoppingAddressController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadAllData];
        });
        
    });
    [self.tableView reloadData];
    NSLog(@"%ld",(unsigned long)self.dataArray.count);

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HUDView sharedInstanceWithView:self.view] destroy];


}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管理地址";
    _i = -1;
    _isopen = NO;
    _isEmpty = NO;
    _chooseButtonStateAry = [NSMutableArray array];
    [self AddTableView];
    self.view.backgroundColor = [UIColor blackColor];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         dispatch_async(dispatch_get_main_queue(), ^{
             [self loadAllData];
         });
         
     });
         
    [self addViewbottom];

}
- (void)loadAllData
{
    AddressBaseViewModel*ViewModel = [[AddressBaseViewModel alloc]init];
    WK(weakSelf);
        ViewModel.AllAddressataBlock= ^(id AllAddressDataSucroe){
            
            self.dataArray = AllAddressDataSucroe;
            if (weakSelf.dataArray.count == 0) {
                _lable.hidden = NO;
            }else
            {
                _lable.hidden = YES;
            }
                [weakSelf .tableView reloadData];
        };
    
    [ViewModel getAddNewDataWithUserTel:us UUID:KUUID];
}
- (void)addViewbottom
{
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, KWIDTH/2, KWIDTH, 21)];
    _lable.text = @"你还没有添加地址请添加";
    _lable.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    _lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_lable];
    self.lable.hidden = YES;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //在这里self.view.fram被确定
    [self creatBottmButton];

    
}
- (void)AddTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-50) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (void)creatBottmButton
{
    _AddButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.height-50, KWIDTH, 50)];
    [_AddButton setTitle:@"添加新地址" forState:(UIControlStateNormal)];
    _AddButton.backgroundColor = ZXColor(255, 148, 3, 1);
    [_AddButton addTarget:self action:@selector(add) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_AddButton];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ID = @"Adcell";
    AddressCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"AddressCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.ChooseButton addTarget:self action:@selector(ChooseButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.EditorButton addTarget:self action:@selector(EditorButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.DeleateButton addTarget:self action:@selector(DeleateButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.ChooseButton setImage:[UIImage imageNamed:@"choose.png"] forState:(UIControlStateSelected)];
    cell.ChooseButton.tag = indexPath.section+10;
    cell.EditorButton.tag = indexPath.section+100;
    cell.DeleateButton.tag = indexPath.section+1000;
    if ([_chooseButtonStateAry containsObject:[NSString stringWithFormat:@"%ld",cell.ChooseButton.tag-10]])
    {
        cell.ChooseButton.selected = YES;
        cell.MoRenLable.textColor = [UIColor orangeColor];
    }
    if (indexPath.section == _i)
    {
        cell.ChooseButton.selected = YES;
        cell.MoRenLable.textColor = [UIColor orangeColor];
        
    }else
    {
        cell.ChooseButton.selected = NO;
        cell.MoRenLable.textColor = [UIColor blackColor];
        
    }
    
    cell.model = self.dataArray[indexPath.section];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(defaultSettingNotificaor) name:@"last" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataArrayIsNUllNotificaor) name:@"null" object:nil];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (void)ChooseButtonClick:(UIButton*)sender
{
    AddressMolde*model = self.dataArray[sender.tag-10];
    
        if ([model.isDefault isEqualToString:@"true"]) {
            return;
        }
        
    
    if (sender.selected == YES) {
        return;
    }
    [[HUDView sharedInstanceWithView:self.view] showHUD];
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        AddressMolde*model = self.dataArray[sender.tag-10];
        AddressBaseViewModel*ViewModel = [[AddressBaseViewModel alloc]init];
        WK(weakSelf);
        ViewModel.NewAddBlock = ^(id AddNewDataSucroe)
        {
            if ([AddNewDataSucroe isEqualToString:@"设置成功"]) {
               
            }
            
            [[HUDView sharedInstanceWithView:self.view] hiddenHUD];
            [weakSelf.tableView reloadData];
            
        };
        
        [ViewModel settingDefullAddressWithRecvID:model.RecvID];
        [_chooseButtonStateAry addObject:[NSString stringWithFormat:@"%ld",sender.tag-10]];
        for (AddressMolde*model in self.dataArray) {
            if ([model.isDefault isEqualToString:@"true"]) {
                model.isDefault = @"false";
            }
        }
        _i = sender.tag-10;
        [self.tableView reloadData];
    }
    
}
- (void)EditorButtonClick:(UIButton*)sender
{
    Shopping_Add_New_AddressController*ANewVC =[[Shopping_Add_New_AddressController alloc]init];
    ANewVC.model = self.dataArray[sender.tag-100];
    ANewVC.index = sender.tag-100;
    ANewVC.delegate = self;
    ANewVC.isAdd = NO;
    if (_isother == YES) {
        ANewVC.isother = NO;

    }else
    {
        ANewVC.isother = YES;

    }

    [self.navigationController pushViewController:ANewVC animated:YES];
}

//删除地址
- (void)DeleateButtonClick:(UIButton*)sender
{
    AddressMolde*model = self.dataArray[sender.tag-1000];
    WK(weakSelf);
    AddressBaseViewModel*viewmodel = [[AddressBaseViewModel alloc]init];
    [[ShowMessageTools sharedInstance]showMessage:@"确定删除" controller:weakSelf block:^{
        viewmodel.NewAddBlock = ^(id AddNewDataSucroe){
            NSLog(@"%@",AddNewDataSucroe);
        };
        [viewmodel DeleteAddressDataWithUserTel:us UserPhyAdd:KUUID RecvAddrID:model.RecvID];
        [weakSelf.dataArray removeObjectAtIndex:sender.tag-1000];
        if (_dataArray.count == 0)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"null" object:nil];
            
        }else
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"last" object:nil];
        }
        
        [weakSelf.tableView reloadData];
    } canclblock:^{
        return ;
    }];
  
}
//把数组第一个设置为默认地址
- (void)defaultSettingNotificaor
{
    _i = 0;
    AddressMolde*model = self.dataArray[0];
    AddressBaseViewModel*ViewModel = [[AddressBaseViewModel alloc]init];
    ViewModel.NewAddBlock = ^(id AddNewDataSucroe)
    {
    };
    
    [ViewModel settingDefullAddressWithRecvID:model.RecvID];
   [self.tableView reloadData];
    
}
//数组空了
- (void)dataArrayIsNUllNotificaor
{
    self.lable.hidden = NO;
    if (self.dataArray.count == 0) {
        self.isEmpty = YES;
    }
}
//得到编辑后地址
- (void)getEditoredAddress:(NSInteger)index withModel:(AddressMolde *)model isOpen:(BOOL)isOpen
{
    [self.dataArray replaceObjectAtIndex:index withObject:model];
    if (isOpen == YES) {
        for (AddressMolde*model in self.dataArray) {
            if ([model.isDefault isEqualToString:@"true"]) {
                model.isDefault = @"false";
            }
            
        }
        _i = index;
        [self.dataArray removeObjectAtIndex:_i];
        [self.dataArray insertObject:model atIndex:0];
        _i= 0;
    }
    [self.tableView reloadData];
}
//添加
- (void)add
{
    Shopping_Add_New_AddressController*ANewVC =[[Shopping_Add_New_AddressController alloc]init];
    ANewVC.isAdd = YES;
    ANewVC.delegate = self;
    if (_isother == YES) {
        ANewVC.isother = NO;
        
    }else
    {
        ANewVC.isother = YES;
        
    }
    if (self.dataArray.count == 0) {
        ANewVC.isFrist = YES;
    }
    [self.navigationController pushViewController:ANewVC animated:YES];
}
//得到添加的地址
-(void)getAddDataWithModel:(AddressMolde *)model isOpen:(BOOL)isOpen
{
    if (isOpen == YES) {
        //把默认的改变只能选择一个
        
        for (AddressMolde*model in self.dataArray) {
            if ([model.isDefault isEqualToString:@"true"]) {
                model.isDefault = @"false";
            }
            
        }
        _i= 0;
        _isopen = YES;
        [self.dataArray insertObject:model atIndex:0];
        
    }else{
        _isopen = NO;
        if (self.dataArray.count == 0) {
            self.dataArray = [NSMutableArray array];
            [self.dataArray addObject:model];
            _i = 0;
            self.lable.hidden = YES;
        }else
        {

            [self.dataArray insertObject:model atIndex:1];
            

        }
        
    }
    [self.tableView reloadData];
}
- (void)deleteThisAddressWith:(NSInteger)index

{
    [self.dataArray removeObjectAtIndex:index];
    [self.tableView reloadData];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"last" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"null" object:nil];

    
}
@end
