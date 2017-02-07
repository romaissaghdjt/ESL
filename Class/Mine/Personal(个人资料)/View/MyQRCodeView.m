//
//  MyQRCodeView.m
//  QRCode
//
//  Created by Apple on 16/5/9.
//  Copyright © 2016年 aladdin-holdings.com. All rights reserved.
//

#import "MyQRCodeView.h"
//#import "UIView+Layout.h"
//
//#import "QRCodeGenerator.h"

#define QRViewMargin 20

@implementation MyQRCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupContentView];
              self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 10;
    }
    return self;
}

- (void)setupContentView {
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(QRViewMargin, QRViewMargin, 60, 60)];
    //icon.image = [UIImage imageNamed:@"icon.png"];
    icon.layer.cornerRadius = 10;
    icon.clipsToBounds = YES;
    [self addSubview:icon];
    self.icon = icon;
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"林肯发球";
    name.left = CGRectGetMaxX(icon.frame) + 10;
    name.width = 100;
    name.height = 30;
    name.top = icon.top;
    [self addSubview:name];
    self.name = name;
    
  
    
    UIImageView *qrImg = [[UIImageView alloc] init];
    qrImg.top = CGRectGetMaxY(icon.frame) + 30;
    qrImg.left = QRViewMargin;
    qrImg.width = self.width - QRViewMargin * 2;
    qrImg.height = qrImg.width;
    qrImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    qrImg.layer.borderWidth = 0.5;
    qrImg.layer.cornerRadius = 10;
    qrImg.clipsToBounds = YES;
    
    [self addSubview:qrImg];
    self.qrImg = qrImg;
    
#warning ---正式时可以把字符串换成自己的个人主页url等...
//    qrImg.image = [QRCodeGenerator qrImageForString:@"https://www.baidu.com" imageSize:self.width - QRViewMargin * 4];
//    qrImg.contentMode = UIViewContentModeScaleAspectFit;
    //    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"us"];
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    self.qrImg.image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    
    
    
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    
    self.qrImg.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
    
    self.qrImg.layer.shadowRadius=1;//设置阴影的半径
    
    self.qrImg.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    
    self.qrImg.layer.shadowOpacity=0.3;
    

    
    UIImageView *appIcon = [[UIImageView alloc] init];
    appIcon.image = [UIImage imageNamed:@"icon.png"];
    appIcon.x = self.width * 0.5 - 40;
    appIcon.y = qrImg.y + qrImg.height * 0.5 - 40;
    appIcon.width = 80;
    appIcon.height = 80;
//    appIcon.layer.cornerRadius = 25;
//    appIcon.clipsToBounds = YES;
    
    [self addSubview:appIcon];
    
    self.appIcon = appIcon;
    
    
    
}
-(void)erweima

{
    
    
    
}



//改变二维码大小

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

@end
