//
//  CLMapNavigationView.m
//  YY
//
//  Created by 陈龙 on 16/6/7.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLMapNavigationView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "LocationChange.h"

@interface CLMapNavigationView()<CLLocationManagerDelegate,UIActionSheetDelegate>
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)CLLocationManager *manager;
@property (nonatomic, assign)double targetLatitude;
@property (nonatomic, assign)double targetLongitute;
@property (nonatomic, assign)double currentLatitude;
@property (nonatomic, assign)double currentLongitute;
@property (nonatomic, assign)BOOL isUpdate;

@end


@implementation CLMapNavigationView

-(id)init{
    if (self = [super init]) {
        self.isUpdate = NO;
    }
    return self;
}

+(NSArray *)checkNavigationApp{
    NSArray *mapSchemeArr = @[@"comgooglemaps://",@"iosamap://navi",@"baidumap://map/",@"qqmap://"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果原生地图", nil];
    
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0) {
                [appListArr addObject:@"google地图"];
            }else if (i == 1){
                [appListArr addObject:@"高德地图"];
            }else if (i == 2){
                [appListArr addObject:@"百度地图"];
            }else if (i == 3){
                [appListArr addObject:@"腾讯地图"];
            }
        }
    }
    
    return appListArr;
}

- (void)showMapNavigationViewWithtargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name{
    [self startLocation];
    _targetLatitude = targetLatitude;
    _targetLongitute = targetLongitute;
    _name = name;
}

//获取经纬度
-(void)startLocation
{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
    {
        _manager=[[CLLocationManager alloc]init];
        _manager.delegate=self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestAlwaysAuthorization];
        _manager.distanceFilter=100;
        [_manager startUpdatingLocation];
    }
    else
    {
        UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alvertView show];
    }

    
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (self.isUpdate == NO) {
        [self showMapNavigationViewFormcurrentLatitude:newLocation.coordinate.latitude currentLongitute:newLocation.coordinate.longitude TotargetLatitude:_targetLatitude targetLongitute:_targetLongitute toName:_name];
        self.isUpdate = YES;
    }

    
}

- (void)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name{
    _currentLatitude = currentLatitude;
    _currentLongitute = currentLongitute;
    _targetLatitude = targetLatitude;
    _targetLongitute = targetLongitute;
    _name = name;
    NSArray *appListArr = [CLMapNavigationView checkNavigationApp];
    NSString *sheetTitle = [NSString stringWithFormat:@"导航到 %@",name];
    UIActionSheet *sheet;
    if ([appListArr count] == 1) {
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0], nil];
    }else if ([appListArr count] == 2) {
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1], nil];
    }else if ([appListArr count] == 3){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2], nil];
    }else if ([appListArr count] == 4){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3], nil];
    }else if ([appListArr count] == 5){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3],appListArr[4], nil];
    }
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    [self stopLocation];
    
}

-(void)stopLocation
{
    _manager = nil;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    double AdressLat,AdressLon;
    double NowLat,NowLon;
    
    bd_decrypt(_targetLatitude,_targetLongitute, &AdressLat, &AdressLon);
    bd_decrypt(_currentLatitude,_currentLongitute, &NowLat, &NowLon);
    NSLog(@"---%f,%f", AdressLat, AdressLon);
    NSLog(@"+++%f,%f", _targetLatitude, _targetLongitute);
    NSString *name = _name;
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (buttonIndex == 0) {
        CLLocationCoordinate2D from = CLLocationCoordinate2DMake(NowLat, NowLon);
        MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:from addressDictionary:nil]];
        currentLocation.name = @"我的位置";
            
            //终点
        CLLocationCoordinate2D to = CLLocationCoordinate2DMake(AdressLat, AdressLon);
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
        NSLog(@"网页google地图:%f,%f",to.latitude,to.longitude);
        toLocation.name = name;
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{
                                    MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                    MKLaunchOptionsMapTypeKey:
                                        [NSNumber numberWithInteger:MKMapTypeStandard],
                                    MKLaunchOptionsShowsTrafficKey:@YES
                                    };
            
        //打开苹果自身地图应用
        [MKMapItem openMapsWithItems:items launchOptions:options];
    }
    
    if ([btnTitle isEqualToString:@"google地图"]) {
        double AdressLat,AdressLon;
        double NowLat,NowLon;
        
        bd_decrypt(_targetLatitude,_targetLongitute, &AdressLat, &AdressLon);
        bd_decrypt(_currentLatitude,_currentLongitute, &NowLat, &NowLon);
        
        NSString *urlStr = [NSString stringWithFormat:@"comgooglemaps://?saddr=%.8f,%.8f&daddr=%.8f,%.8f&directionsmode=transit",NowLat,NowLon,AdressLat,AdressLon];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
    else if ([btnTitle isEqualToString:@"高德地图"]){
        double AdressLat,AdressLon;
        double NowLat,NowLon;
        
        bd_decrypt(_targetLatitude,_targetLongitute, &AdressLat, &AdressLon);
        bd_decrypt(_currentLatitude,_currentLongitute, &NowLat, &NowLon);
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",NowLat, NowLon,@"我的位置",AdressLat,AdressLon,_name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *r = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:r];
        //        NSLog(@"%@",_lastAddress);
        
    }
    
    else if ([btnTitle isEqualToString:@"腾讯地图"]){
        double AdressLat,AdressLon;
        double NowLat,NowLon;
        
        bd_decrypt(_targetLatitude,_targetLongitute, &AdressLat, &AdressLon);
        bd_decrypt(_currentLatitude,_currentLongitute, &NowLat, &NowLon);
        
        NSString *urlStr = [NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoord=%f,%f&tocoord=%f,%f&policy=1",NowLat,NowLon,AdressLat,AdressLon];
        NSURL *r = [NSURL URLWithString:urlStr];
        [[UIApplication sharedApplication] openURL:r];
    }
    else if([btnTitle isEqualToString:@"百度地图"])
    {
//        double AdressLat,AdressLon;
//        double NowLat,NowLon;
//        
//        bd_encrypt(_targetLatitude,_targetLongitute, &AdressLat, &AdressLon);
//        bd_encrypt(_currentLatitude,_currentLongitute, &NowLat, &NowLon);
        NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",_currentLatitude,_currentLongitute,_targetLatitude,_targetLongitute];
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
