//
//  zJRequestManager.h
//
//  Created by 赵洁 on 15/12/22.
//  Copyright (c) 2015年 zj. All rights reserved.
//

#import "zJRequestManager.h"

@implementation zJRequestManager


static zJRequestManager *ZJ = nil;

//实例化对象为了代理对象
+ (instancetype)shareHelper
{
    @synchronized(self) {
        if (!ZJ) {
            ZJ = [[zJRequestManager alloc] init];
        }
        return ZJ;
    }
}
+ (void)requestWithUrl:(NSString *)urlstring parmDic:(NSDictionary *)parmDic method:(RequsetType)method succeedWithData:(void(^)(NSData *data))block
       failedWithError:(void(^)(NSError *Error))failblock{
    
    // 处理中文字符串
    NSString *string = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // NSURLSession *session = [NSURLSession sharedSession];
    // post 请求方式的处理
    if (method == POST1 ){
        [request setHTTPMethod:@"POST"];
        // 字典的参数不为空 需要把内容拼接起来
        if (parmDic.count != 0){
            NSMutableArray *strArray = [NSMutableArray array];
            for (NSString *key in parmDic) {
                NSString *str = [NSString stringWithFormat:@"%@=%@",key,parmDic[key]];
                [strArray addObject:str];
            }
            // 使用数组的方法 拼接数组内的元素
            NSString *parm = [strArray componentsJoinedByString:@"&"];
            [request setHTTPBody:[parm dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    //初始化
    [self shareHelper];
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: ZJ delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask*dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 缓存设置
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *savePath = [docPath stringByAppendingPathComponent:@"savePath"];
        
        if (error == nil){
            // 存入本地
            //            [MBProgressHUD hideHUDForView:view animated:YES];
            //
            //            NSString *path = [NSString stringWithFormat:@"%@/#%ld.cgtu",docPath,(unsigned long)data.hash];
            //            [NSKeyedArchiver archiveRootObject:data toFile:path];
            //            [NSKeyedArchiver archiveRootObject:path toFile:savePath];
            //NSLog(@" ********************  %@",data);
            block(data);
            
        }else{
            
            
            
            failblock(error);
            // 读取本地的上一次缓存文件
            NSString *s = [NSKeyedUnarchiver unarchiveObjectWithFile:savePath];
            NSString *str = [[s componentsSeparatedByString:@"#"] lastObject];
            NSString *path = [NSString stringWithFormat:@"%@/#%@",docPath,str];
            NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            if (pickData != nil && ![pickData isKindOfClass:[NSNull class]]){
                // block(pickData);
            }
        }
    }];
    
    [dataTask resume];

}
//主要就是处理HTTPS请求的
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = protectionSpace.serverTrust;
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

@end
