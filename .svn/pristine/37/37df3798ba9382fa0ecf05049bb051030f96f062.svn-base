//
//  CLLotteryViewController.m
//  YY
//
//  Created by 陈龙 on 16/6/27.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLLotteryViewController.h"
#import "CLLotteryView.h"
#import "Masonry.h"
#import "CLXiShiTangNetanager.h"
#import "CLCheckViewController.h"
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"num.plist"]

@interface CLLotteryViewController ()
@property (weak, nonatomic) IBOutlet UIView *numView;
@property (nonatomic, strong)CLLotteryView *lotteryView;
@property (nonatomic, assign)BOOL isStart;
@property (nonatomic, strong)NSTimer *timer;
//所有抽中的号码
@property (nonatomic, strong)NSMutableArray *currentArr;
//获取验证码
@property (weak, nonatomic) IBOutlet UILabel *codeDraw;
@property (weak, nonatomic) IBOutlet UIButton *firstPrizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *SecondPrizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdPrizeBtn;
@property (nonatomic, strong)NSString *selectedPrize;
@end

@implementation CLLotteryViewController
-(NSMutableArray *)currentArr
{
    if (!_currentArr) {
        _currentArr = [NSMutableArray array];
    }
    return _currentArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.lotteryView.topView setAllLabel:@"00000000000"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WK(weakSelf)
    [CLXiShiTangNetanager getCodeDrawWithTel:[[NSUserDefaults standardUserDefaults]objectForKey:@"us"] CustPhyAddr:KUUID CompletionHandler:^(NSString *code, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:0 error:nil];
        
        NSTextCheckingResult *result2 = [regex firstMatchInString:code options:0 range:NSMakeRange(0, code.length)];
        if (result2) {
            weakSelf.codeDraw.text = code;
        }
        else
        {
            [UIViewController showMessage:code ViewController:self];
        }
    }];
    self.firstPrizeBtn.selected = YES;
    self.selectedPrize = self.firstPrizeBtn.titleLabel.text;
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.lotteryView = [[CLLotteryView alloc]initWithFrame:CGRectMake(7, 7, 305, 30)];
    [self.numView addSubview:self.lotteryView];
    self.isStart = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backClick:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
//开始抽奖
- (IBAction)startLottery:(UIButton *)sender {
    WK(weakSelf)
    if (self.isStart == NO) {
        [CLXiShiTangNetanager getStartLotteryWithDrowID:self.codeDraw.text DrawLevel:self.selectedPrize CreatorTel:[[NSUserDefaults standardUserDefaults]objectForKey:@"us"] CustPhyAddr:KUUID CompletionHandler:^(NSString *result, NSError *error) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:0 error:nil];
            
            NSTextCheckingResult *result2 = [regex firstMatchInString:result options:0 range:NSMakeRange(0, result.length)];
            if (result2) {
                [weakSelf.currentArr addObject:result];
                
                weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.1  target:weakSelf selector:@selector(changeContentOffset:) userInfo:nil repeats:YES];
                [weakSelf.lotteryView.scrollView setContentOffset:CGPointMake(0, 360) animated:NO];
                [weakSelf.lotteryView setupCurrentNum:result];
                weakSelf.isStart = !weakSelf.isStart;
            }
            else
            {
                [UIViewController showMessage:result ViewController:self];
            }
        }];
    
    }
    else
    {
        if (self.timer != nil) {
            [self.timer invalidate];
            self.timer = nil;
            [self.lotteryView.scrollView setContentOffset:CGPointMake(0, -30) animated:NO];
        }
        self.isStart = !self.isStart;
    }
    
}

-(void)changeContentOffset:(NSTimer *)timer
{
    [self.lotteryView.scrollView setContentOffset:CGPointMake(0, 360) animated:NO];
}

- (IBAction)checkNum:(UIButton *)sender {
    [CLXiShiTangNetanager getCurrentNumWithDrowID:self.codeDraw.text CompletionHandler:^(NSArray *array, NSError *error) {
        CLCheckViewController *cvc = [[CLCheckViewController alloc]initWithNibName:@"CLCheckViewController" bundle:nil];
        cvc.isFromCustom = NO;
        NSLog(@"%ld", array.count);
        cvc.numArr = array;
        [self.navigationController pushViewController:cvc animated:YES];
    }];
}
- (IBAction)PrizeClick:(UIButton *)sender {
    self.firstPrizeBtn.selected = NO;
    self.SecondPrizeBtn.selected = NO;
    self.thirdPrizeBtn.selected = NO;
    sender.selected = YES;
    self.selectedPrize = sender.titleLabel.text;
}
- (IBAction)exitClick:(id)sender {
    [CLXiShiTangNetanager stopDrawWithCreatorTel:[[NSUserDefaults standardUserDefaults]objectForKey:@"us"] CustPhyAddr:KUUID DrowID:self.codeDraw.text CompletionHandler:^(NSString *result, NSError *error) {
        if ([result isEqualToString:@"抽奖结束"]) {
            [@[] writeToFile:kFilePath atomically:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [UIViewController showMessage:result ViewController:self];
        }
    }];
}
@end
