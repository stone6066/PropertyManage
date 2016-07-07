//
//  staffDetailViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/1.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "staffDetailViewController.h"
#import "PublicDefine.h"
#import "stdCellVc.h"
#import "stdCallBtn.h"

@interface staffDetailViewController ()<StdButtonDelegate>

@end

@implementation staffDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MyGrayColor;
    [self loadTopNav];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setStaffId:(NSString *)staffId{
    _staffId=staffId;
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadVCData:_staffId];
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"员工信息";
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

-(void)loadStaffInfoView:(NSDictionary*)dict{
    
    CGFloat listY=TopSeachHigh+20;
    CGFloat cellHeigh=50;
    CGRect firstCG=CGRectMake(0, listY, fDeviceWidth, cellHeigh);
    NSArray *dictArray = [dict objectForKey:@"data"];
    
    for (NSDictionary *dicttmp in dictArray) {
        
        
        stdCellVc *personNo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"bianhao" titleName:@"员工编号：" txtName:[dicttmp objectForKey:@"staffNumber"] lookImg:@"" sendid:1];
        [self.view addSubview:personNo];
        
        firstCG=CGRectMake(0, listY+51, fDeviceWidth, cellHeigh);
        stdCellVc *personName=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"name" titleName:@"姓名：" txtName:[dicttmp objectForKey:@"staffName"] lookImg:@"" sendid:2];
        [self.view addSubview:personName];
        
        firstCG=CGRectMake(0, listY+51*2, fDeviceWidth, cellHeigh);
        stdCellVc *personSex=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"tie" titleName:@"性别：" txtName:[dicttmp objectForKey:@"staffSex"] lookImg:@"" sendid:3];
        [self.view addSubview:personSex];
        
        firstCG=CGRectMake(0, listY+51*3, fDeviceWidth, cellHeigh);
        stdCellVc *personType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"zhiye" titleName:@"职业类型：" txtName:[dicttmp objectForKey:@"staffPost"] lookImg:@"" sendid:4];
        [self.view addSubview:personType];
        
        firstCG=CGRectMake(0, listY+51*4, fDeviceWidth, cellHeigh);
        stdCellVc *gzType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"gongzhong" titleName:@"工种类型：" txtName:[dicttmp objectForKey:@"staffJobstype"] lookImg:@"" sendid:5];
        [self.view addSubview:gzType];
        
        
        firstCG=CGRectMake(0, listY+51*5, fDeviceWidth, cellHeigh);
        
        UIView * personPhone=[[UIView alloc]initWithFrame:firstCG];
        
        UIImageView *iocnImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, (cellHeigh-20)/2, 20, 20)];
        iocnImg.image=[UIImage imageNamed:@"telphone"];
        [personPhone addSubview:iocnImg];
        
        UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(45, (cellHeigh-20)/2, 88, 20)];
        titleLbl.text=@"联系电话：";
        [titleLbl setFont:[UIFont systemFontOfSize:13]];
        [personPhone addSubview:titleLbl];
        
        stdCallBtn *txtLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(45+72, (cellHeigh-20)/2, 120, 20)];
        [txtLbl setLblText:[dicttmp objectForKey:@"staffContact"]];
        [personPhone addSubview:txtLbl];
        personPhone.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:personPhone];
        
    }
    
}



-(void)loadVCData:(NSString*)uid {
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };

    //http://192.168.0.21:8080/propies/staff/staffinfo?staffId=1
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/staff/staffinfo?staffId=",uid];
    
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
                                              [self loadStaffInfoView:jsonDic];
                                              
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




@end
