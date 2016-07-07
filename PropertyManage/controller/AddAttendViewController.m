//
//  AddAttendViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/4.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AddAttendViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PublicDefine.h"
#import "stdPubFunc.h"
@interface AddAttendViewController ()<CLLocationManagerDelegate>

@end

@implementation AddAttendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self showFingerImg];
    [self loaction];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  开启定位服务
 */
- (void)loaction
{
    [SVProgressHUD showWithStatus:@"正在定位..."];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 1.0;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization]; // 永久授权
        [self.locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    //当前经度
    ApplicationDelegate.currentLong= [NSString stringWithFormat:@"%g",currentLocation.coordinate.longitude];
    //当前纬度
    ApplicationDelegate.currentLat = [NSString stringWithFormat:@"%g",currentLocation.coordinate.latitude];
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count >0) {
            [SVProgressHUD dismiss];
            CLPlacemark *placemark = [array objectAtIndex:0];
            //NSLog(@"placemark:%@",placemark);
            //获取城市
            NSString *city = placemark.locality;
            //NSLog(@"当前城市 = %@",city);
            
            NSString *province = placemark.administrativeArea;
            _provine = province;
            
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            _city = city;
            
            _district=placemark.subLocality;
            _street=placemark.thoroughfare;
            _streetNo=placemark.subThoroughfare;
            NSString *addrString=@"";
            //NSLog(@"省：%@市：%@区：%@街道：%@号码：%@",_provine,_city,_district,_street,_streetNo);
            if (_streetNo) {
                addrString=[NSString stringWithFormat:@"%@%@%@%@%@",_provine,_city,_district,_street,_streetNo] ;
            }
            else
                addrString=[NSString stringWithFormat:@"%@%@%@%@",_provine,_city,_district,_street] ;
            
            [self showAddrInfo:addrString];
           
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:placemark.subLocality forKey:@"area_country"];
            [defaults setObject:city forKey:@"city"];
            [defaults synchronize];
            
        } else if (error ==nil && [array count] ==0) {
            [SVProgressHUD dismiss];
            NSLog(@"No results were returned.");
        } else if (error !=nil) {
            [SVProgressHUD dismiss];
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //[SVProgressHUD dismiss];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

//检测是何种原因导致定位失败
- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    
    NSString *errorString;
    [manager stopUpdatingLocation];
    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            [SVProgressHUD dismiss];
            errorString = @"Access to Location Services denied by user";
            //Do something...
            [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"请打开该app的位置服务!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            break;
        case kCLErrorLocationUnknown:
            [SVProgressHUD dismiss];
            //Probably temporary...
            errorString = @"Location data unavailable";
            [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"位置服务不可用!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            //Do something else...
            break;
        default:
            [SVProgressHUD dismiss];
            errorString = @"An unknown error has occurred";
            [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"定位发生错误!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            break;
    }
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"新增考勤";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    [self.view addSubview:TopView];
}

-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)showAddrInfo:(NSString*)addStr{
    UIView *addVc=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight-100, fDeviceWidth, 100)];
    addVc.backgroundColor=MyGrayColor;
    UIImageView *addrImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 20, 20)];
    addrImg.image=[UIImage imageNamed:@"addr"];
    
    CGSize size = [addStr sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(fDeviceWidth-50,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
    _addrInfo=[[UILabel alloc]initWithFrame:CGRectMake(30, 18, size.width,size.height)];
   
    _addrInfo.numberOfLines = 0; // 最关键的一句
    _addrInfo.text=addStr;
    _addrInfo.font = [UIFont systemFontOfSize:15];
    
    [addVc addSubview:addrImg];
    [addVc addSubview:_addrInfo];
    UIView *xuLine=[[UIView alloc]initWithFrame:CGRectMake(6, 0, fDeviceWidth-12, 2)];
    
    [self drawDashLine:xuLine lineLength:5 lineSpacing:2 lineColor:txtColor];
    [addVc addSubview:xuLine];
    [self.view addSubview:addVc];
}
-(void)showFingerImg{
    UIView *topVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh-100)];
    UIImageView *fingerImg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth/4, 90, fDeviceWidth/2, (fDeviceWidth/6)*4+20)];
    fingerImg.image=[UIImage imageNamed:@"upAttend"];
    [topVc addSubview:fingerImg];
    
    UIButton *upBtn=[[UIButton alloc]initWithFrame:fingerImg.frame];
    [topVc addSubview:upBtn];
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    
    longPress.minimumPressDuration = 1.0; //定义按的时间
    [upBtn addGestureRecognizer:longPress];
    topVc.backgroundColor=MyGrayColor;
    
    UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-150)/2, fDeviceHeight-TopSeachHigh-100-68, 150, 50)];
    logobtnImg.image=[UIImage imageNamed:@"logBtn"];
    [topVc addSubview:logobtnImg];
    
    UIButton *refreshLocation=[[UIButton alloc]initWithFrame:CGRectMake((fDeviceWidth-150)/2, fDeviceHeight-TopSeachHigh-100-70, 150, 50)];
    
    [refreshLocation addTarget:self action:@selector(reLocationBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [refreshLocation setTitle:@"重新定位"forState:UIControlStateNormal];// 添加文字
    [topVc addSubview:refreshLocation];
    [self.view addSubview:topVc];
}

-(void)reLocationBtn{
    [SVProgressHUD showWithStatus:@"正在定位..."];
    [self.locationManager startUpdatingLocation];
}



-(void)btnLong:(UILongPressGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
        [self addAttendToSrv];
    }
}


-(void)addAttendToSrv{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
    //http://192.168.0.21:8080/propies/user/attendanceadd?empName=色粉色粉高僧&address=色发顺丰各公司&userId=68
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",BaseUrl,@"propies/user/attendanceadd?empName=",ApplicationDelegate.myLoginInfo.userName,@"&attendanceTime=",[self getCurrentTime],@"&address=",_addrInfo.text,@"&userId=",ApplicationDelegate.myLoginInfo.userId,@"&lat=",ApplicationDelegate.currentLat,@"&longt=",ApplicationDelegate.currentLong];
    NSLog(@"attendanceadd:%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"数据：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"msg"];
                                          if ([suc isEqualToString:@"success"]) {
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"上传成功"];
                                              [self clickleftbtn];
                                          }
                                          else {
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"上传失败"];
                                              
                                          }

                                          
                                      } else {
                                          [SVProgressHUD dismiss];
                                          [stdPubFunc stdShowMessage:@"上传失败"];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD dismiss];
                                      [stdPubFunc stdShowMessage:@"上传失败"];
                                      
                                  }];
    
}
-(NSString *)getCurrentTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [dateFormatter stringFromDate:currentDate];
}

/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
-(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
