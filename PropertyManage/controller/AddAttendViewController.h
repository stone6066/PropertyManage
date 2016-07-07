//
//  AddAttendViewController.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/4.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface AddAttendViewController : UIViewController
@property (nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,copy)NSString * provine;//省
@property(nonatomic,copy)NSString * city;//市
@property(nonatomic,copy)NSString * district;//区
@property(nonatomic,copy)NSString * street;//街道
@property(nonatomic,copy)NSString * streetNo;//街道号码
@property(nonatomic,strong)UILabel *addrInfo;
@end
