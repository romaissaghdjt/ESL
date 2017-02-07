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
#import "UIView+HUD.h"
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
    [CLXiShiTangNetanager getCodeDrawCompletionHandler:^(NSString *code, NSError *error) {
        if (error) {
            [self.view showWarning:@"服务器繁忙"];
        }
        else
        {
            weakSelf.codeDraw.text = code;
        }
    }];
    self.firstPrizeBtn.selected = YES;
    self.selectedPrize = [NSString stringWithFormat:@"%ld", self.firstPrizeBtn.tag];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}
//开始抽奖
- (IBAction)startLottery:(UIButton *)sender {
    WK(weakSelf)
    if (self.isStart == NO) {
        NSLog(@"===%@",self.selectedPrize);
        [CLXiShiTangNetanager getStartLotteryWithDrowID:self.codeDraw.text DrawLevel:self.selectedPrize CompletionHandler:^(NSDictionary *dict, NSError *error) {
            if (error) {
                [self.view showWarning:@"服务器繁忙"];
            }
            else
            {
                if ([dict[@"提示"] isEqualToString:@"成功"]) {
                    [weakSelf.currentArr addObject:dict[@"Resault"]];
                    weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.1  target:weakSelf selector:@selector(changeContentOffset:) userInfo:nil repeats:YES];
                    [weakSelf.lotteryView.scrollView setContentOffset:CGPointMake(0, 360) animated:NO];
                    [weakSelf.lotteryView setupCurrentNum:dict[@"Resault"]];
                    weakSelf.isStart = !weakSelf.isStart;
                }
                else
                {
                    [self.view showWarning:dict[@"Reason"]];
                }
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
    [CLXiShiTangNetanager getCurrentNumWithDrowID:self.codeDraw.text Tel:us CompletionHandler:^(NSArray *array, NSError *error) {
        CLCheckViewController *cvc = [[CLCheckViewController alloc]init];
        cvc.isFromCustom = NO;
        cvc.numArr = array;
        [self presentViewController:cvc animated:YES completion:nil];
    }];
}
- (IBAction)PrizeClick:(UIButton *)sender {
    self.firstPrizeBtn.selected = NO;
    self.SecondPrizeBtn.selected = NO;
    self.thirdPrizeBtn.selected = NO;
    sender.selected = YES;
    self.selectedPrize = [NSString stringWithFormat:@"%ld", (long)sender.tag];
}
- (IBAction)exitClick:(id)sender {
    [CLXiShiTangNetanager stopDrawWithDrowID:self.codeDraw.text CompletionHandler:^(NSDictionary *result, NSError *error) {
        if ([result[@"提示"] isEqualToString:@"结束成功"]) {
            [@[] writeToFile:kFilePath atomically:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.view showWarning:result[@"Reason"]];
        }

    }];
}
@end
