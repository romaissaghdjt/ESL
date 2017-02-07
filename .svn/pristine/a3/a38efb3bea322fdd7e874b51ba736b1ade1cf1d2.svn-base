//
//  TCPChannel.m
//  TCPChannel
//
//  Created by 赵洁 on 16/9/23.
//  Copyright © 2016年 jie. All rights reserved.
//

#import "TCPChannel.h"

@interface TCPChannel ()
@property (nonatomic) BOOL isNoRegs_or_Fail;

@end

@implementation TCPChannel

+(TCPChannel *)getTcpChannel
{
    static TCPChannel*channel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        channel = [[TCPChannel alloc]init];
        channel.isNoRegs_or_Fail = NO;
    });
    return channel;
}
/**
 共外界调取链接
 参数
 SRV_CONNECTED = 0链接结束
 SRV_CONNECT_SUC=1链接成功
 SRV_CONNECT_FAIL=2链接失败
 */
- (int) connectServer:(NSString *) hostIP port:(int) hostPort{
    if (_asyncSocket == nil) {
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError *err = nil;
        if (![_asyncSocket connectToHost:hostIP onPort:hostPort error:&err]) {
            NSLog(@"%ld,%@",(long)[err code],[err localizedDescription]);
            [self notifyUI:NotificationCONNECT_FAIL_KEY withObject:nil];
            //失败重新连
            ///[self reConnect];
            return SRV_CONNECT_FAIL;
        }else {
            
            [self notifyUI:NotificationCONNECT_SC_KEY withObject:nil];
            return SRV_CONNECT_SUC;
            
        }
    }
    else{
        [_asyncSocket readDataWithTimeout:-1 tag:0];
        return SRV_CONNECTED;
    }
}
/**
 登陆操作
 */
- (void)sendLoginWithUesrName:(NSString *)userName passWord:(NSString *)passWord Add:(NSString *)Add
{
    //    [self connectServer:HOST_IP port:HOST_PORT];
    
    NSString*pass = [self md5HexDigestWithStr:passWord];
    NSString *string = [NSString stringWithFormat:@"HEAD=000000\r\nBODY={\"Module\":\"User\",\"Method\":\"Login\",\"UserTel\":%@,\"UserPwd\":\"%@\",\"UserPhyAdd\":\"%@\"}",userName,pass,Add];
    
    [self.asyncSocket writeData:[[NSString stringWithFormat:@"HEAD=%06lu\r\nBODY={\"Module\":\"User\",\"Method\":\"Login\",\"UserTel\":%@,\"UserPwd\":\"%@\",\"UserPhyAdd\":\"%@\"}",string.length - 5,userName,pass,Add] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    
}

- (void)sendHeartPack
{
    NSString *string = [NSString stringWithFormat:@"HEAD=000000\r\nBODY={\"Module\":\"User\",\"Method\":\"HeartBeat\"}"];
    [self.asyncSocket writeData:[[NSString stringWithFormat:@"HEAD=%06lu\r\nBODY={\"Module\":\"User\",\"Method\":\"HeartBeat\"}",string.length - 5] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}
/**
 重新进行tcp链接
 */
-(void) reConnect{
   
    int stat = [self connectServer:HOST_IP port:HOST_PORT];
    
    switch (stat) {
        case SRV_CONNECT_SUC:
            NSLog(@"连接成功");
            //重新连接成功并自动登录
            [self sendLoginWithUesrName:us passWord:pw Add:KUUID];
            NSLog(@"%@",KUUID);
            break;
        case SRV_CONNECTED:
            NSLog(@"已经连接不需要连接");
            break;
        default:
            break;
    }
    
}

#pragma mark - AsyncSocketDelegate method
/**
 asyncSocket链接
 */

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"登陆通道:%p 已经连接服务器ip:%@ port:%hu",sock,host,port);
    
    [sock readDataWithTimeout:-1 tag:0];
}
/**
 asyncSocket返回数据
 做后续操作
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"得到服务器返回数据 is :%@",aStr);
    NSString*str = [aStr substringFromIndex:18];
    NSData *dataStr =[str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:dataStr options:NSJSONReadingMutableLeaves error:nil];
    if ([resultDic[@"Method"] isEqualToString:@"LoginReturn"]) {
        if ([resultDic[@"Result"] isEqualToString:@"你还没有注册"]) {
            //_asyncSocket = nil;
            [self notifyUI:NotificationREG_KEY withObject:nil];
            _isNoRegs_or_Fail = YES;
            self.asyncSocket.userData = @"SocketOfflineByServer";

        }else if ([resultDic[@"Result"] isEqualToString:@"用户名或密码错误"])
        {
            //_asyncSocket = nil;
            _isNoRegs_or_Fail = YES;
            self.asyncSocket.userData = @"SocketOfflineByServer";

            [self notifyUI:NotificationFAIL_KEY withObject:nil];
        }else if ([resultDic[@"Result"] isEqualToString:@"登录成功"])
        {
            self.isNoRegs_or_Fail = NO;
            self.time = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.time forMode:NSDefaultRunLoopMode];
            [self notifyUI:NotificationSC_KEY withObject:nil];
            NSUserDefaults *info = [NSUserDefaults
                                    standardUserDefaults];
            [info setBool:YES forKey:Login_Suc];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"server"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"take"];
        }else
        {
            self.asyncSocket.userData = @"SocketOfflineByServer";


        }
    }
    else if([resultDic[@"Method"] isEqualToString:@"BeginGetCook"])
    {
        NSLog(@"%@", resultDic);
        if ([self.delegate respondsToSelector:@selector(getOrderWithNSDictionary:Type:)]) {
             [self.delegate getOrderWithNSDictionary:resultDic Type:WAITORDER];
        }
    }
    else if([resultDic[@"Method"] isEqualToString:@"SubmitCookReturn"])
    {
        NSLog(@"%@", resultDic);
        if ([self.delegate respondsToSelector:@selector(getOrderWithNSDictionary:Type:)]) {
            [self.delegate getOrderWithNSDictionary:resultDic Type:WAITCOMPLETE];
        }
    }
    else if([resultDic[@"Method"] isEqualToString:@"CookRequireBeRob"])
    {
        NSLog(@"%@", resultDic);
        if ([self.delegate respondsToSelector:@selector(getOrderWithNSDictionary:Type:)]) {
            [self.delegate getOrderWithNSDictionary:resultDic Type:ISBOOKED];
        }
    }else if([resultDic[@"Method"] isEqualToString:@"账号被顶"])
    {
        self.isNoRegs_or_Fail = YES;
       self.asyncSocket.userData = @"SocketOfflineByServer";
        [self notifyUI:NotificationTakeUPKEY withObject:nil];

    }
    else if([resultDic[@"Method"] isEqualToString:@"CookReturn"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CookReturn" object:nil];
    }
    else if([resultDic[@"Method"] isEqualToString:@"CookReport"])
    {
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:resultDic[@"Msg"],@"Msg", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CookReport" object:nil userInfo:dict];
    }
    [_asyncSocket readDataWithTimeout:-1 tag:0];
}
- (void)timer
{
    [self sendHeartPack];
    
}

/**
 asyncSocket断开链接
 这里可以重连
 */

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"%@",err);
    if ([sock.userData isEqualToString:@"SocketOfflineByServer"]) {
        NSLog(@"======服务断开");
        // 服务器掉线，重连
        _asyncSocket = nil;//断开后先把对象值空再连接
        if (self.isNoRegs_or_Fail == YES) {
            NSString*sss = @"takeup";
            [[NSUserDefaults standardUserDefaults]setObject:sss forKey:@"take"];
            
        }else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self reConnect];
            });
            
 
        }

    }
    else if ([sock.userData isEqualToString:@"SocketOfflineByUser"]) {
        // 如果由用户断开，不进行重连
        NSLog(@"======用户自己断开");
        NSString*sss = @"out";
        [[NSUserDefaults standardUserDefaults]setObject:sss forKey:@"server"];
        return;
    }else
    {
        _asyncSocket = nil;//断开后先把对象值空再连接

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self reConnect];
        });
        
    }
    
    
}
- (void)disConnect
{
    NSLog(@"===========3==============================断开连接了");
    
    self.asyncSocket.userData = @"SocketOfflineByUser";
    [_asyncSocket disconnect];
    _asyncSocket = nil;
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"succeed"];
    
    [_time invalidate];
    _time = nil;
}
-(NSString *) md5HexDigestWithStr:(NSString*)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
- (void)notifyUI:(NSString *)sNotifyName
      withObject:(id)obj {
    dispatch_block_t block = ^{ @autoreleasepool {
        [[NSNotificationCenter defaultCenter] postNotificationName:sNotifyName object:obj];
    }};
    dispatch_async(dispatch_get_main_queue(), block);
}

- (NSString *)getProperIPWithAddress:(NSString *)ipAddr port:(UInt32)port
{
    NSError *addresseError = nil;
    NSArray *addresseArray = [GCDAsyncSocket lookupHost:ipAddr
                                                   port:port
                                                  error:&addresseError];
    if (addresseError) {
        NSLog(@"");
    }
    
    NSString *ipv6Addr = @"";
    for (NSData *addrData in addresseArray) {
        if ([GCDAsyncSocket isIPv6Address:addrData]) {
            ipv6Addr = [GCDAsyncSocket hostFromAddress:addrData];
        }
    }
    
    if (ipv6Addr.length == 0) {
        ipv6Addr = ipAddr;
    }
    
    return ipv6Addr;
}

@end
