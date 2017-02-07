//
//  HUDView.m
//  ffjjjfj
//
//  Created by 赵洁 on 16/11/22.
//  Copyright © 2016年 jie. All rights reserved.
//

#import "HUDView.h"
//随机色
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define DISPATCH_TIME 0.5
#define DISPATCH_TIME_OUT 3
@interface HUDView()
@property (nonatomic,strong)UIActivityIndicatorView*rotateView;
@property (nonatomic,strong)UILabel*lable;

@end

@implementation HUDView
static HUDView*h = nil;

+ (HUDView *)sharedInstanceWithView:(UIView *)view
{
        if (h == nil) {
            h = [[HUDView alloc]initWithFrame:CGRectMake(KWIDTH/2-30, KHEIGHT/2-70, 80, 80)];
            h.backgroundColor = [UIColor blackColor];;
            [view addSubview:h];
            h.layer.cornerRadius = 10;
            h.alpha = 0.7;
            h.hidden = YES;
        }
    return h;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)creat_state:(BOOL)state
{
    if (state == YES) {
        
        UIActivityIndicatorView*vv =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        vv.hidesWhenStopped = YES;
        vv.color = RandColor;
        CGFloat W = 30;
        CGFloat H = 30;
        
        CGFloat X = self.frame.size.width/2- W/2;
        CGFloat Y = self.frame.size.height/2 - H/2-5;
        vv.frame = CGRectMake(X, Y, W, H);
        [vv startAnimating];
        [self addSubview:vv];
        self.rotateView = vv;
        _lable = [[UILabel alloc]initWithFrame:CGRectMake(10,self.frame.size.height-27, self.frame.size.width,20)];
        
            _lable.text = @" ";
            
        if (_lable.text.length >10) {
            _lable.font = [UIFont systemFontOfSize:10];

        }else
        {
            _lable.font = [UIFont systemFontOfSize:13];

        }
        _lable.textColor = [UIColor whiteColor];
        [self addSubview:_lable];
    }else
    {
        UIActivityIndicatorView*vv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        vv.hidesWhenStopped = YES;
        vv.color = RandColor;
        CGFloat W = 30;
        CGFloat H = 30;
        CGFloat X = self.frame.size.width/2- W/2;
        CGFloat Y = self.frame.size.height/2 - H/2;
        vv.frame = CGRectMake(X, Y, W, H);
        [vv startAnimating];
        [self addSubview:vv];
        self.rotateView = vv;
    }
    
    
}
- (void)setText:(NSString *)text
{
    if (text == nil) {
        _lable.text = @" ";
        
    }else
    {
        _lable.text = [NSString stringWithFormat:@"%@",text];
        _lable.textAlignment = NSTextAlignmentCenter;
        
    }
}
- (void)creatOnlyTextSummery
{
    //添加成功,在购物车等亲~√
    UIImageView*ll = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-10,20,20,20)];
    ll.image = [UIImage imageNamed:@"gouhao.png"];
    
    [self addSubview:ll];
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(5,self.frame.size.height-27, self.frame.size.width,20)];
    _lable.text = self.text;
    _lable.font = [UIFont systemFontOfSize:12];

    _lable.textColor = [UIColor whiteColor];
    [self addSubview:_lable];
    
}
- (void)showHUD
{
    self.hidden = NO;
    [self creat_state:NO];
    [self timeOutDismiss];
}
- (void)showTextHUD
{
    self.hidden = NO;
    [self creat_state:YES];
    [self timeOutDismiss];
    
}
- (void)showOnlyTextHUD
{
    self.hidden = NO;
    CGRect aa = self.frame;
    aa = CGRectMake(KWIDTH/2-70, KHEIGHT/2-40, 140, 80);
    self.frame = aa;
    [self creatOnlyTextSummery];
    [self timeOutDismiss];

}
- (void)timeOutDismiss
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DISPATCH_TIME_OUT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}
- (void)hiddenHUD
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DISPATCH_TIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.text = nil;
        self.hidden = YES;

    });
}
- (void)destroy
{
    //制空是为了更好的活着
    h = nil;
}

@end
