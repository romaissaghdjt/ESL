//
//  PhotoSController.m
//  YY
//
//  Created by 赵洁 on 16/7/15.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "PhotoSController.h"
#import <AVFoundation/AVFoundation.h>
@interface PhotoSController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic)BOOL isFrist;
@end

@implementation PhotoSController
- (void)viewWillAppear:(BOOL)animated{
    if (_isFrist  == YES) {
        _isFrist = NO;
    }else if(_isFrist == NO) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFrist = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 380, 50, 50)];
    self.imageView.backgroundColor = [UIColor redColor];
    //[self.view addSubview:self.imageView];
    UIView *view = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    
    [UIActionSheet showInView:view
                    withTitle:nil
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
            otherButtonTitles:@[@"拍照",@"从手机相册选择"]
                     tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex)
     {
         NSLog(@"%ld",(long)buttonIndex);
         switch (buttonIndex) {
             case 0:
                 [self takePhoto];
                 break;
             case 1:
                 [self choosePhoto];
                 break;
             case 2:
                 [self Cancel];
                 break;
             default:
                 break;
         }
         
     }];
    
    // Do any additional setup after loading the view.
}
- (void)Cancel
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)takePhoto
{
    if (![self hasAuthorizationForMediaType:AVMediaTypeVideo]) {
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
    
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL)hasAuthorizationForMediaType:(NSString *)mediaType
{
    BOOL hasAuthorization = YES;
    
    if (IOS7_OR_LATER) {
        hasAuthorization = !([AVCaptureDevice authorizationStatusForMediaType:mediaType] == AVAuthorizationStatusDenied);
    }
    
    if (!hasAuthorization) {
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        
        NSString *message = [NSString stringWithFormat:@"请在iPhone的“设置-隐私-相机”选项中，允许%@访问你的相机。", appName];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法拍照"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    return hasAuthorization;
}
- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)type
{
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if (type == UIImagePickerControllerSourceTypeCamera && mediaTypes.count <= 0) {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = type;
    picker.wantsFullScreenLayout = YES;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}
- (void)choosePhoto
{
    
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    UIImage*images = [self imageYS:image];
    self.imageView.image = [self saveImage:images str:_str path:_path];
    
   // NSLog(@"%@",self.imageView.image);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"chanage" object:nil];
    [picker dismissViewControllerAnimated:NO completion:^{
       
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}
- (UIImage*)imageYS:(UIImage*)image
{
    UIImage *SFimage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(60, 80)];
    
    NSData *Sdata = UIImageJPEGRepresentation(SFimage, 0.5);
    image = [UIImage imageWithData:Sdata];
    return image;
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize

{
    
    // Create a graphics image context
    
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    
    UIGraphicsEndImageContext();
    
    // Return the new image.
    
    return newImage;
    
}
- (UIImage*)saveImage:(UIImage*)image str:(NSString*)str path:(NSString*)path
{
    UIImage *newimage  = [[UIImage alloc]init];;
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:str];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:path] stringByAppendingPathComponent:str];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    newimage = savedImage;
    
    return newimage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}


@end
