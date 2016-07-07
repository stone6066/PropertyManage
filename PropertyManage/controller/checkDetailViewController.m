//
//  checkDetailViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "checkDetailViewController.h"
#import "PublicDefine.h"
#import "stdCellVc.h"
@interface checkDetailViewController ()

@end

@implementation checkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MyGrayColor;
    [self loadTopNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCheckId:(NSString *)checkId{
    _checkId=checkId;
}
-(void)setCheckName:(NSString *)checkName{
    _checkName=checkName;
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadVCData:_checkId];
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"巡检信息";
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
    //http://192.168.0.21:8080/propies/check/checkinfo?checkId=14
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/check/checkinfo?checkId=",uid];
    
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
                                          
                                          //
                                          if ([suc isEqualToString:@"success"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              [self loadCheckInfoView:jsonDic];
                                              
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

//"checkId":14,
//"checkType":"常规",
//"checkNo":"XJ201605110954582",
//"checkPoint":"6926892522083",
//"checkTime":"2016-05-11 09:54:58",
//"checkContent":"挺好的",
//"userId":67,
//"remark":"测试"

-(void)loadCheckInfoView:(NSDictionary*)dict{
    
    CGFloat listY=TopSeachHigh+20;
    CGFloat cellHeigh=50;
    CGRect firstCG=CGRectMake(0, listY, fDeviceWidth, cellHeigh);
    NSArray *dictArray = [dict objectForKey:@"data"];
    
    for (NSDictionary *dicttmp in dictArray) {
        
        
        stdCellVc *personNo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"bianhao" titleName:@"巡检编号：" txtName:[dicttmp objectForKey:@"checkNo"] lookImg:@"" sendid:1];
        [self.view addSubview:personNo];
        
        firstCG=CGRectMake(0, listY+51, fDeviceWidth, cellHeigh);
        stdCellVc *personName=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"gongzhong" titleName:@"巡检类型：" txtName:[dicttmp objectForKey:@"checkType"] lookImg:@"" sendid:2];
        [self.view addSubview:personName];
        
        firstCG=CGRectMake(0, listY+51*2, fDeviceWidth, cellHeigh);
        stdCellVc *personSex=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"checkPoint" titleName:@"巡检点：" txtName:[dicttmp objectForKey:@"checkPoint"] lookImg:@"" sendid:3];
        [self.view addSubview:personSex];
        
        firstCG=CGRectMake(0, listY+51*3, fDeviceWidth, cellHeigh);
        stdCellVc *personType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"timeIcon" titleName:@"巡检时间：" txtName:[dicttmp objectForKey:@"checkTime"] lookImg:@"" sendid:4];
        [self.view addSubview:personType];
        
        firstCG=CGRectMake(0, listY+51*4, fDeviceWidth, cellHeigh);
        stdCellVc *gzType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"checkContent" titleName:@"巡检内容：" txtName:[dicttmp objectForKey:@"checkContent"] lookImg:@"" sendid:5];
        [self.view addSubview:gzType];
        
        firstCG=CGRectMake(0, listY+51*5, fDeviceWidth, cellHeigh);
        stdCellVc *checkPerson=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"name" titleName:@"巡检人：" txtName:_checkName lookImg:@"" sendid:6];
        [self.view addSubview:checkPerson];
        
        firstCG=CGRectMake(0, listY+51*6, fDeviceWidth, cellHeigh);
        stdCellVc *checkMemo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"remark" titleName:@"备注：" txtName:[dicttmp objectForKey:@"remark"] lookImg:@"" sendid:7];
        [self.view addSubview:checkMemo];
        
        
        
    }
    
}

@end
