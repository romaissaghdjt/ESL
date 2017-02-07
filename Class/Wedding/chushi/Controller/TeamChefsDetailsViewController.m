//
//  TeamChefsDetailsViewController.m
//  YY
//
//  Created by 徐恒 on 16/6/23.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "TeamChefsDetailsViewController.h"
#import "TeamChefsDetailsCell.h"
//#import "ReserveViewController.h"
#import "LoginViewController.h"
@interface TeamChefsDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tabView;
//@property (strong, nonatomic)UILabel *priceLabel;
@property (assign, nonatomic)NSInteger *first;
//@property (strong, nonatomic) DropdownMenu *Menu ;
@property (strong, nonatomic)UIButton *bb;
 @property (strong, nonatomic)UIButton *btn;
// @property (strong, nonatomic)XHIndetController *XHindetC;
@end

@implementation TeamChefsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"团队详情";
    [self createTabView];
    [self createFooterView];
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
-(void)clickA{
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
    UIView *serviceView = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT -44, KWIDTH, 44)];
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

-(void)appointment{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    if (![info boolForKey:@"success"]) {
        [self showLoginMessage:@"您还没有登陆快去登录吧!"];
        return;
    }
    
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"us"];
        NSString *url =[NSString
                        stringWithFormat:[PREURL stringByAppendingString:@"BookHandler.ashx?Action=AddIntoOrder&Type=Type_Cook&CookGrpID=%@&fkCusTel=%@&CustPhyAddr=%@"]
                        ,self.Model.CookGrpID,str,KUUID];
        NSLog(@"%@",url);
        [self requset:url];
}
- (void)requset:(NSString*)string
{
    [zJRequestManager requestWithUrl:string parmDic:nil method:GET1 succeedWithData:^(NSData *data) {
        NSDictionary*dic  = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSString *sss = dic[@"提示"];
        [self show:sss];
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
    }else if ([str isEqualToString:@"意外错误"]){
        [self showmessage:@"意外错误"];
    }
}
- (void)createTabView{
    
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT + 20) style:(UITableViewStylePlain)];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.rowHeight = 570;
    _tabView.separatorStyle = NO;
    _tabView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tabView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *ID = @"cella";
        TeamChefsDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"TeamChefsDetailsCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        cell.CookGrpID = _Model.CookGrpID;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_Model.ImageUrlGrp]];
        cell.name.text = _Model.NameGrp;
        cell.dateTime.text = [_Model.SetupDtGrp substringToIndex:9];
        cell.num1.text = _Model.NumCookGrp;
        cell.num2.text = _Model.NumServiceGrp;
        
        cell.realName.text = _Model.CookNameGrp;
        cell.workingTime.text = [NSString stringWithFormat:@"%@年",_Model.WorkingTimeGrp];
    cell.NumberService.text = _Model.ServiceNumGrp;
    
    NSMutableString  *str = [NSMutableString string];
    NSArray *ary = [_Model.ServiceAreaGrp componentsSeparatedByString:@"#"];
    for (int i = 0 ; i < ary.count; i ++) {
        switch ([ary[i] integerValue]) {
            case 1:
                [str appendString:@"鄞州区,"];
                break;
            case 2:
                [str appendString:@"北仑区,"];
                break;
            case 3:
                [str appendString:@"奉化区,"];
                break;
            default:
                break;
        }
    }
    if ([_Model.ServiceAreaGrp isEqualToString:@""]) {
        NSString *ss = @"";
        NSLog(@"%@",ss);
    }else{
        NSString *aa = [str substringToIndex:str.length-1];
        cell.address.text = aa;
    }

    if ([_Model.MaximumGrp isEqualToString:@"1"]) {
        cell.maximum.text = @"5桌";
    }else if ([_Model.MaximumGrp isEqualToString:@"2"]){
        cell.maximum.text = @"10桌";
    }else if ([_Model.MaximumGrp isEqualToString:@"3"]){
        cell.maximum.text = @"15桌";
    }
    else if ([_Model.MaximumGrp isEqualToString:@"4"]){
        cell.maximum.text = @"20桌";
    }
    else if ([_Model.MaximumGrp isEqualToString:@"5"]){
        cell.maximum.text = @"30桌";
    }else if ([_Model.MaximumGrp isEqualToString:@"6"]){
        cell.maximum.text = @"40桌";
    }else if ([_Model.MaximumGrp isEqualToString:@"7"]){
        cell.maximum.text = @"50桌以上";
    }
    NSMutableString *string = [NSMutableString string];
    NSArray *array = [_Model.GoodAtGrp componentsSeparatedByString:@"#"];
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
    NSString *caiString = [string substringToIndex:string.length-1];
    cell.goodAt.text = caiString;
    if ([_Model.StarLevelGrp isEqualToString:@"3"]) {
        cell.StarLevel.image = [UIImage imageNamed:@"3@3x(2)"];
    }
    else if ([_Model.StarLevelGrp isEqualToString:@"4"]){
        cell.StarLevel.image = [UIImage imageNamed:@"4@3x(2)"];
    }
    else if ([_Model.StarLevelGrp isEqualToString:@"5"]){
        cell.StarLevel.image = [UIImage imageNamed:@"5@3x(2)"];
    }
    
    if (_Model.StarNumGrp <= [NSString stringWithFormat:@"%d",1]) {
        cell.NumberStars.image = [UIImage imageNamed:@"11@3x(1).png"];
    }
    else if (_Model.StarNumGrp > [NSString stringWithFormat:@"%d",1]&&_Model.StarNumGrp <= [NSString stringWithFormat:@"%d",2] ) {
        cell.NumberStars.image = [UIImage imageNamed:@"22@3x(2)"];
    }else if (_Model.StarNumGrp > [NSString stringWithFormat:@"%d",2]&&_Model.StarNumGrp <=[NSString stringWithFormat:@"%d",3] ){
        cell.NumberStars.image = [UIImage imageNamed:@"33@3x(2)"];
    }else if (_Model.StarNumGrp > [NSString stringWithFormat:@"%d",3]&&_Model.StarNumGrp <=[NSString stringWithFormat:@"%d",4] ){
        cell.NumberStars.image = [UIImage imageNamed:@"44@3x(2)"];
    }else if (_Model.StarNumGrp > [NSString stringWithFormat:@"%d",4]&&_Model.StarNumGrp <=[NSString stringWithFormat:@"%d",5] ){
        cell.NumberStars.image = [UIImage imageNamed:@"55@3x(2)"];
    }else if (_Model.StarNumGrp >=[NSString stringWithFormat:@"%d",5] ){
        cell.NumberStars.image = [UIImage imageNamed:@"55@3x(2)"];
    }
    
    if ([_Model.sYsxRecommendGrp isEqualToString:@"1"]){
        cell.Recommend.image = [UIImage imageNamed:@"甬尚鲜推荐1-2"];
    }
    else
    {
        cell.Recommend.image = [[UIImage alloc]init];
    }
    
    if ([_Model.BornDateTime isEqualToString:@""]) {
        NSString *str = @"";
        NSLog(@"%@",str);
    }else{
        cell.bornDateTime.text = [_Model.BornDateTime substringToIndex:9];
    }
        return cell;
    }
#pragma mark == 团队厨师价格赋值 == 
//- (void)PricesAssignment{
//    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_Model.Price];
//    _priceLabel.textColor = [UIColor redColor];
//
//}
- (void)showmessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alert animated:YES completion:nil];
    WK(weakSelf)
    UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:cancelAction];
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
@end
