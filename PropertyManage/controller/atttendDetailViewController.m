//
//  atttendDetailViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/4.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "atttendDetailViewController.h"
#import "PublicDefine.h"
#import "stdCellVc.h"

@interface atttendDetailViewController ()

@end

@implementation atttendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MyGrayColor;
    [self loadTopNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAttendId:(NSString *)attendId{
    _attendId=attendId;
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadVCData:_attendId];
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"考勤信息";
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

-(void)loadVCData:(NSString*)uid {
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    //http://192.168.0.21:8080/propies/user/attendanceinfo?attendanceId=42
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/user/attendanceinfo?attendanceId=",uid];
    
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
                                          NSString *suc=[jsonDic objectForKey:@"result"];
                                          
                                          //
                                          if ([suc isEqualToString:@"true"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              [self loadAttendInfoView:jsonDic];
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:k_Error_WebViewError];
                                              
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      
                                  }];
    
}

//"attendanceId":42,
//"empName":"超级管理员",
//"attendanceTime":"2016-03-17 08:28:53",
//"address":"中国黑龙江省哈尔滨市香坊区香坊大街街道轴承四道街3-40号",
//"userId":2,
//"lat":"45.71996266074827",
//"longt":"126.6862994801513"
-(void)loadAttendInfoView:(NSDictionary*)dict{
    
    CGFloat listY=TopSeachHigh+20;
    CGFloat cellHeigh=50;
    CGRect firstCG=CGRectMake(0, listY, fDeviceWidth, cellHeigh);
    NSArray *dictArray = [dict objectForKey:@"data"];
    
    for (NSDictionary *dicttmp in dictArray) {
        
        
        stdCellVc *personNo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"name" titleName:@"姓名：" txtName:[dicttmp objectForKey:@"empName"] lookImg:@"" sendid:1];
        [self.view addSubview:personNo];
        
        firstCG=CGRectMake(0, listY+51, fDeviceWidth, cellHeigh);
        stdCellVc *personName=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"timeIcon" titleName:@"时间：" txtName:[dicttmp objectForKey:@"attendanceTime"] lookImg:@"" sendid:2];
        [self.view addSubview:personName];
        
        firstCG=CGRectMake(0, listY+51*2, fDeviceWidth, cellHeigh);
        stdCellVc *personSex=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"longt" titleName:@"经度：" txtName:[dicttmp objectForKey:@"longt"] lookImg:@"" sendid:3];
        [self.view addSubview:personSex];
        
        firstCG=CGRectMake(0, listY+51*3, fDeviceWidth, cellHeigh);
        stdCellVc *personType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"lat" titleName:@"纬度：" txtName:[dicttmp objectForKey:@"lat"] lookImg:@"" sendid:4];
        [self.view addSubview:personType];
        
        firstCG=CGRectMake(0, listY+51*4, fDeviceWidth, cellHeigh);
        stdCellVc *gzType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"addr" titleName:@"地址：" txtName:[dicttmp objectForKey:@"address"] lookImg:@"" sendid:5];
        [self.view addSubview:gzType];
        
        
        
    }
    
}

@end
