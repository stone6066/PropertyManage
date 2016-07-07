//
//  personInfoViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/1.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "personInfoViewController.h"
#import "PublicDefine.h"
#import "stdCellVc.h"
#import "stdCallBtn.h"

@interface personInfoViewController ()

@end

@implementation personInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MyGrayColor;
    [self loadTopNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUserId:(NSString *)userId{
    _userId=userId;
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadVCData:_userId];
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"个人信息";
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


//"positionName":"物业经理",
//"levelName":"超级管理员",
//"userName":"超级管理员",
//"userLogin":"admin",
//"userPhone":"13000000000",
//"userStatusName":"启用"
-(void)loadPersonInfoView:(NSDictionary*)dict{
    
    CGFloat listY=TopSeachHigh+20;
    CGFloat cellHeigh=50;
    CGRect firstCG=CGRectMake(0, listY, fDeviceWidth, cellHeigh);
    NSArray *dictArray = [dict objectForKey:@"data"];
    
    for (NSDictionary *dicttmp in dictArray) {
        
        
        stdCellVc *personNo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"bianhao" titleName:@"当前账号：" txtName:[dicttmp objectForKey:@"userLogin"] lookImg:@"" sendid:1];
        [self.view addSubview:personNo];
        
        firstCG=CGRectMake(0, listY+51, fDeviceWidth, cellHeigh);
        stdCellVc *personName=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"usrstate" titleName:@"账号状态：" txtName:[dicttmp objectForKey:@"userStatusName"] lookImg:@"" sendid:2];
        [self.view addSubview:personName];
        
        firstCG=CGRectMake(0, listY+51*2, fDeviceWidth, cellHeigh);
        stdCellVc *personSex=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"zhiye" titleName:@"用户职位：" txtName:[dicttmp objectForKey:@"positionName"] lookImg:@"" sendid:3];
        [self.view addSubview:personSex];
        
        firstCG=CGRectMake(0, listY+51*3, fDeviceWidth, cellHeigh);
        stdCellVc *personType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"usrlevel" titleName:@"用户级别：" txtName:[dicttmp objectForKey:@"levelName"] lookImg:@"" sendid:4];
        [self.view addSubview:personType];
        
        firstCG=CGRectMake(0, listY+51*4, fDeviceWidth, cellHeigh);
        stdCellVc *gzType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"name" titleName:@"用户姓名：" txtName:[dicttmp objectForKey:@"userName"] lookImg:@"" sendid:5];
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
        [txtLbl setLblText:[dicttmp objectForKey:@"userPhone"]];
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
    
   //http://192.168.0.21:8080/propies/user/userinfo?userId=2
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/user/userinfo?userId=",uid];
    
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
                                              [self loadPersonInfoView:jsonDic];
                                              
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
