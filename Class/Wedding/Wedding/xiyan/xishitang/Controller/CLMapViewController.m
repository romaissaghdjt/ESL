//
//  CLMapViewController.m
//  YY
//
//  Created by 陈龙 on 16/5/29.
//  Copyright © 2016年 徐恒. All rights reserved.
//

#import "CLMapViewController.h"
#import "VillageAnnotation.h"
//#import "Masonry.h"
#import "MapBottomView.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "CLMapNavigationView.h"
#import "CLXiShiTangNetanager.h"

@interface CLMapViewController ()<BMKMapViewDelegate>

@property (nonatomic, strong)BMKMapView *mapView;

@property (nonatomic, strong)MapBottomView *mapBottomView;

@property (nonatomic, strong)NSArray *villageArr;

@end

@implementation CLMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    WK(weakSelf)
//    [CLXiShiTangNetanager getTownXiShiTangInfoWithTownID:self.townID CompletionHandler:^(NSArray *result, NSError *error) {
//        weakSelf.villageArr = result;
//        [self addAnnotation];
//    }];
    self.title = @"地图";
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    
    self.view = self.mapView;
    BMKCoordinateRegion region = BMKCoordinateRegionMake(CLLocationCoordinate2DMake(_currentLatitude, _currentLongitude), BMKCoordinateSpanMake(0.148601,0.105500));
    
    [_mapView setRegion:region animated:YES];
    self.mapView.delegate = self;
    
    _mapBottomView = [[MapBottomView alloc]init];
    _mapBottomView.backgroundColor = [UIColor whiteColor];
    [_mapView addSubview:_mapBottomView];
    
    [_mapBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.mas_equalTo(100);
    }];
    UIButton *gotoVillageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [gotoVillageBtn addTarget:self action:@selector(startNavi) forControlEvents:UIControlEventTouchUpInside];
    [gotoVillageBtn setTitle:@"去这里" forState:UIControlStateNormal];
    [_mapBottomView addSubview:gotoVillageBtn];
    [gotoVillageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(_mapBottomView.villageAdd.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(70);
    }];
    [_mapBottomView setValueForVillageModel:_villageModel];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *ID = @"PIN";
    BMKPinAnnotationView *annoView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    annoView.tag = 100;
    if (annoView == nil) {
        annoView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
        
        if (annotation.coordinate.longitude == _currentLongitude && annotation.coordinate.latitude == _currentLatitude) {
            annoView.pinColor = BMKPinAnnotationColorRed;
        }else{
            annoView.pinColor = BMKPinAnnotationColorPurple;
            
        }
        annoView.animatesDrop = YES;
        
        annoView.canShowCallout = NO;
        
    }else{
        
        annoView.annotation = annotation;
    }
    return annoView;
    
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    for (id<BMKAnnotation> annotation in mapView.annotations) {
        ((BMKPinAnnotationView *)[mapView viewForAnnotation:annotation]).pinColor = BMKPinAnnotationColorPurple;
    }
    ((BMKPinAnnotationView *)view).pinColor = BMKPinAnnotationColorRed;
    [mapView setCenterCoordinate:((BMKPointAnnotation *)view.annotation).coordinate animated:YES];
    VillageAnnotation *anno = view.annotation;
    _villageModel = anno.model;
    self.completionHandler(_villageModel);
    [_mapBottomView setValueForVillageModel:_villageModel];
}


#pragma mark - 增加大头针
-(void)addAnnotation
{
    for (int i = 0; i < _villageArr.count; i++) {
        
        CLVillageModel *villageModel = _villageArr[i];
        VillageAnnotation *pointAnnotation = [[VillageAnnotation alloc]init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([villageModel.Latitude doubleValue], [villageModel.Longitude doubleValue]);
        pointAnnotation.title = villageModel.Name;
        pointAnnotation.model = villageModel;
        [_mapView addAnnotation:pointAnnotation];
    }
}

- (void)startNavi
{
    CLMapNavigationView *vc = [[CLMapNavigationView alloc] init];
    [vc showMapNavigationViewWithtargetLatitude:[self.villageModel.Latitude doubleValue] targetLongitute:[self.villageModel.Longitude doubleValue] toName:self.villageModel.Name];
    [self.view addSubview:vc];
}


-(void)dealloc
{
    self.mapView.delegate = nil;
    self.mapView = nil;
    [self.view removeFromSuperview];
    [self.mapView removeFromSuperview];
    NSLog(@"---");
}

@end
