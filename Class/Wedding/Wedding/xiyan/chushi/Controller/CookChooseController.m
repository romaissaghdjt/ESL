//
//  CookChooseController.m
//  YY
//
//  Created by eyou on 16/4/27.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CookChooseController.h"
#import "CookerCell.h"
#import "Masonry.h"
#import "LoginViewController.h"
//#import "ReserveViewController.h"
#define kCONENTWIDTH  [UIScreen mainScreen].bounds.size.width / 3
@interface CookChooseController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UILabel *priceLabel;
@property (strong, nonatomic)NSMutableArray *ary;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation CookChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人厨师详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self createFooterView];
    [self PricesAssignment];
    [self createRightBtn];
}
//返回首页和订单的下拉框
- (void)createRightBtn{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setImage:[UIImage imageNamed:@"50x40_02"] forState:UIControlStateNormal];
//    if (SH<=568) {
//        btn.frame = CGRectMake(245, 10, 40, 30);
//    }else if (SH>568){
//        btn.frame = CGRectMake(320, 10, 40, 30);
//    }
//    btn.titleLabel.font = [UIFont systemFontOfSize:18];
//    btn.tintColor = [UIColor grayColor];
//
//    [btn addTarget:self action:@selector(clickA) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    self.bb = btn;
}
-(void)clickA
{
    //@property (strong, nonatomic) DropdownMenu *Menu ;
//    //@property (strong, nonatomic)UIButton *bb;
//    //MessageControllerDelegeta
//    _Menu = [DropdownMenu menu];
//    MessageController *messageC = [[MessageController alloc]init];
//    messageC.view.height = 50*2;
//    messageC.view.width = 100;
//    messageC.view.backgroundColor = ZXColor(95, 95, 95, 1);
//    messageC.view.layer.cornerRadius = 6;
//    messageC.view.layer.masksToBounds = YES;
//    //    messageC.view.userInteractionEnabled = YES;
//    messageC.deleagte = self;
//    _Menu.contentController = messageC;
//    [_Menu showFrom:self.bb];
}
- (void)dismiss:(NSIndexPath *)indexPath
{
//    [_Menu dismiss];
//    if (indexPath.row==0) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//        
//    }else if (indexPath.row==1){
//        // 判断是否登录过
//        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
//        if (![info boolForKey:@"success"]) {
//            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
//            
//            [self presentViewController:navVC animated:YES completion:nil];
//            return;
//        }
//        // @property (strong, nonatomic)UIButton *btn;
//        // @property (strong, nonatomic)XHIndetController *XHindetC;
//        _XHindetC = [[XHIndetController alloc]init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:_XHindetC];
//        
//        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_btn setImage:[UIImage imageNamed:@"fnhui123"] forState:UIControlStateNormal];
//        [_btn setTintColor:ZXColor(83, 162, 38, 1)];
//        _btn.frame = CGRectMake(0, 0, 20, 20);
//        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
//        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_btn];
//        _XHindetC.navigationItem.leftBarButtonItem = leftItem;
//        
//        [self presentViewController:navigation animated:NO completion:nil];
//        
//    }
}
//- (void)click
//{
//    [self dismissViewControllerAnimated:NO completion:nil];
//}
- (void)createFooterView
{
    UIView *serviceView = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT-44, KWIDTH, 44)];
    serviceView.backgroundColor = ZXColor(245, 245, 245, 1);
    [self.view addSubview:serviceView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];

        btn.frame = CGRectMake(0, 0, KWIDTH, 44);
    [btn addTarget:self action:@selector(appointment) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = ZXColor(125, 180, 43, 1);
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"我要预约" forState: UIControlStateNormal];
    [serviceView addSubview:btn];    
}

#define 加入订单
- (void)appointment{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"success"]) {
        [self showLoginMessage:@"您还没有登陆快去登录吧!"];
        return;
    }
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"us"];
    NSString *url =[NSString
                    stringWithFormat:[PREURL stringByAppendingString: @"BookHandler.ashx?Action=AddIntoOrder&Type=Type_Cook&CookID=%@&fkCusTel=%@&CustPhyAddr=%@"]
                    ,self.Model1.pkCookID,str,KUUID];
    NSLog(@"%@",url);
    
    [self requset:url];
   
}
- (void)requset:(NSString*)string
{
    [zJRequestManager requestWithUrl:string parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary*dic  = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSString *sss = dic[@"提示"];
        [self show:sss];
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failedWithError:^(NSError *connectionError) {
        
    }];
}
- (void)show:(NSString*)str
{
    if ([str isEqualToString:@"你还没有订单"]) {
        [self showMessage:@"你还没有订单先预定哦!"];
        
    }else if ([str isEqualToString:@"你还没有登录"])
    {
        [self showLoginMessage:@"你还没登陆"];
    }else if ([str isEqualToString:@"添加失败"])
    {
        [self showmessage:@"添加失败"];
    }else if ([str isEqualToString:@"添加成功"])
    {
        [self showmessage:@"添加成功"];
    }else if ([str isEqualToString:@"你的账户已在另一台手机登录"])
    {
        [self showmessage:@"你的账户已在另一台手机登录"];
    }else if ([str isEqualToString:@"你还没有注册"])
    {
        [self showLoginMessage:@"你还没有注册"];
    }else if ([str isEqualToString:@"你已经加过这个团队了"]){
        [self showmessage:@"每个厨师团队只能添加一次"];
    }else if ([str isEqualToString:@"替换成功"]){
        [self showmessage:@"替换成功"];
    }

}

- (void)createTableView{
    CGRect rect = CGRectMake(0, 0, KWIDTH, KHEIGHT + 20);
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 480;
    _tableView.separatorStyle = NO;//隐藏分割线
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    CookerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CookerCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    
    cell.pkCookIDA = _Model1.pkCookID;
    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:_Model1.ImageUrl]];
    cell.name.text = _Model1.RealName;
    cell.numberService.text = _Model1.ServiceNum;

    if ([_Model1.Sex isEqual:@"1"]) {
                cell.gender.text = @"男";
            }else if ([_Model1.Sex isEqual:@"0"]){
                cell.gender.text = @"女";
            }
    cell.cookAge.text = [NSString stringWithFormat:@"%@年",_Model1.WorkingTime];
    
//    if ([_Model1.ServiceArea isEqualToString:@"1"]) {
//        cell.serviceScope.text = @"鄞州区";
//    }else if ([_Model1.ServiceArea isEqualToString:@"2"]){
//        cell.serviceScope.text = @"北仑区";
//    }else if ([_Model1.ServiceArea isEqualToString:@"3"]){
//        cell.serviceScope.text = @"奉化区";
//    }
//    else
//    {
//        cell.serviceScope.text = @"其他";
//    }
    
    
    NSMutableString *string_area = [NSMutableString string];
    NSArray *area_array = [_Model1.ServiceArea componentsSeparatedByString:@"#"];
    NSLog(@"%@%@",@"查看所有",_Model1.GoodAt);
    for (int i = 0; i < area_array.count; i++) {
        switch ([area_array[i] integerValue]) {
            case 1:
                [string_area appendString:@"鄞州区,"];
                break;
            case 2:
                [string_area appendString:@"北仑区,"];
                break;
            case 3:
                [string_area appendString:@"奉化区,"];
                break;
            default:
                break;
        }
    }
    NSString *areaString = [string_area substringToIndex:string_area.length-1];
    cell.serviceScope.text = areaString;

    if ([_Model1.StarLevel isEqualToString:@"3"]) {
        cell.starLevel.image = [UIImage imageNamed:@"3@3x(2)"];
    }else if ([_Model1.StarLevel isEqualToString:@"4"]){
        cell.starLevel.image = [UIImage imageNamed:@"4@3x(2)"];
    }else if ([_Model1.StarLevel isEqualToString:@"5"]){
        cell.starLevel.image = [UIImage imageNamed:@"5@3x(2)"];
    }
    if (_Model1.StarNum <= [NSString stringWithFormat:@"%d",1]) {
        cell.praiseStar.image = [UIImage imageNamed:@"11@3x(1)"];
    }
    else if (_Model1.StarNum > [NSString stringWithFormat:@"%d",1]&&_Model1.StarNum <= [NSString stringWithFormat:@"%d",2] ) {
        cell.praiseStar.image = [UIImage imageNamed:@"22@3x(2)"];
    }
    else if (_Model1.StarNum > [NSString stringWithFormat:@"%d",2]&&_Model1.StarNum <=[NSString stringWithFormat:@"%d",3] ){
        cell.praiseStar.image = [UIImage imageNamed:@"33@3x(2)"];
    }
    else if (_Model1.StarNum > [NSString stringWithFormat:@"%d",3]&&_Model1.StarNum <=[NSString stringWithFormat:@"%d",4] ){
        cell.praiseStar.image = [UIImage imageNamed:@"44@3x(2)"];
    }
    else if (_Model1.StarNum > [NSString stringWithFormat:@"%d",4]&&_Model1.StarNum<=[NSString stringWithFormat:@"%d",5] ){
        cell.praiseStar.image = [UIImage imageNamed:@"55@3x(2)"];
    }
    else if (_Model1.StarNum > [NSString stringWithFormat:@"%d",5]){
        cell.praiseStar.image = [UIImage imageNamed:@"55@3x(2)"];
    }
    if ([_Model1.IsYsxRecommend isEqualToString:@"1"]){
        cell.imgView.image = [UIImage imageNamed:@"甬尚鲜推荐1-2"];
    }
    else
    {
        cell.imgView.image = [[UIImage alloc]init];
    }
    
    if ([_Model1.Maximum isEqualToString:@"1"]) {
        cell.largestOrder.text = @"5桌";
    }else if ([_Model1.Maximum isEqualToString:@"2"]){
        cell.largestOrder.text = @"10桌";
    }else if ([_Model1.Maximum isEqualToString:@"3"]){
        cell.largestOrder.text = @"15桌";
    }
    else if ([_Model1.Maximum isEqualToString:@"4"]){
        cell.largestOrder.text = @"20桌";
    }
    else if ([_Model1.Maximum isEqualToString:@"5"]){
        cell.largestOrder.text = @"30桌";
    }else if ([_Model1.Maximum isEqualToString:@"6"]){
        cell.largestOrder.text = @"40桌";
    }else if ([_Model1.Maximum isEqualToString:@"7"]){
        cell.largestOrder.text = @"50桌以上";
    }
    NSMutableString *string = [NSMutableString string];
    NSArray *array = [_Model1.GoodAt componentsSeparatedByString:@"#"];
    for (int i = 0; i < array.count; i++) {
        switch ([array[i] integerValue]) {
            case 1:
                [string appendString:@"宁波本帮菜,"];
                break;
            case 2:
                [string appendString:@"鲁菜,"];
                break;
            case 3:
                [string appendString:@"川菜,"];
                break;
            case 4:
                [string appendString:@"粤菜,"];
                break;
            case 5:
                [string appendString:@"淮扬菜,"];
                break;
            case 6:
                [string appendString:@"闽菜,"];
                break;
            case 7:
                [string appendString:@"浙菜,"];
                break;
            case 8:
                [string appendString:@"湘菜,"];
                break;
            case 9:
                [string appendString:@"徽菜,"];
                break;
            default:
                [string appendString:@"西餐,"];
                break;
        }
    }
    
    
    if (!string) {
        NSString *str = [NSString string];
    }
    NSString *caiString = [string substringToIndex:string.length-1];
    cell.cuisine.text = caiString;
    if ([_Model1.BornDateTime isEqualToString:@""]) {
        NSString *str = @"";
        NSLog(@"%@",str);
    }else{
        cell.age.text = [_Model1.BornDateTime substringToIndex:9];
    }
    return cell;
}

#pragma mark == 个人厨师价格赋值 ==
- (void)PricesAssignment{
    _priceLabel.text = [NSString stringWithFormat:@"%@元",_Model1.Price];
    _priceLabel.textColor = [UIColor redColor];
}

- (void)showMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//        ReserveViewController *ReserveVC = [[ReserveViewController alloc]init];
//        ReserveVC.isOther = YES;
//        [self.navigationController pushViewController:ReserveVC animated:YES];
    }];
    [alert addAction:cancelAction];
}
- (void)showLoginMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc] init]];
        
        [self presentViewController:navVC animated:YES completion:nil];
    }];
    
    [alert addAction:cancelAction];
}
- (void)showmessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    WK(wwSelf)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [wwSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:cancelAction];
    
}

@end
