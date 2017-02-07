//
//  TCPChannel.h
//  TCPChannel
//
//  Created by 赵洁 on 16/9/23.
//  Copyright © 2016年 jie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#define SRV_CONNECTED 0
#define SRV_CONNECT_SUC 1
#define SRV_CONNECT_FAIL 2
#define HOST_IP @"ess8222.nbeysx.com"
#define HOST_PORT 20002
#define NotificationSC_KEY @"LoginSC"//成功通知
#define NotificationFAIL_KEY @"LoginFAIL"//失败通知
#define NotificationREG_KEY @"Regest_NO"//注册通知
#define NotificationCONNECT_SC_KEY @"Connect_Scuss"//连接成功通知
#define NotificationCONNECT_FAIL_KEY @"Connect_Fail"//连接失败通知

#define NotificationTakeUPKEY @"Connect_Fail"//账号被顶通知

typedef enum
{
    WAITORDER,WAITCOMPLETE,ISBOOKED
}ORDTYPE;

@protocol TCPChannelDelegate <NSObject>

-(void)getOrderWithNSDictionary:(NSDictionary *)dict Type:(ORDTYPE)type;

@end

@interface TCPChannel : NSObject<GCDAsyncSocketDelegate>
enum{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};
@property (nonatomic,strong)GCDAsyncSocket*asyncSocket;
@property (nonatomic,strong)NSTimer*time;
@property (nonatomic,assign)id<TCPChannelDelegate>delegate;
+ (TCPChannel*)getTcpChannel;
/**
 共外界调取连接TCP方法
 */
- (int) connectServer:(NSString *) hostIP port:(int) hostPort;
/**
 登陆操作
 */
- (void) sendLoginWithUesrName:(NSString*)userName passWord:(NSString*)passWord Add:(NSString*)Add;
/**
 重新进行tcp连接
 */
- (void) reConnect;
/**
 断开连接
 */
- (void) disConnect;
/**
 发送心跳
 */
//- (void) sendHeartJmp;

- (NSString *)getProperIPWithAddress:(NSString *)ipAddr port:(UInt32)port;
@end
