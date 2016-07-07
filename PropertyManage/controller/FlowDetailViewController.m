//
//  FlowDetailViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "FlowDetailViewController.h"
#import "PublicDefine.h"
#import "stdCellVc.h"
#import "flowDoneViewController.h"

@interface FlowDetailViewController ()

@end

@implementation FlowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self loadVCData:_flowId];
    [self std_regsNotification];
    // Do any additional setup after loading the view.
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:k_Notification_Flow
                                                  object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"工单信息";
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
-(void)setFlowId:(NSString *)flowId{
    _flowId=flowId;
}
-(void)setFlowType:(NSInteger)flowType{
    _flowType=flowType;
}
-(void)setMendState:(NSString *)mendState{
    _mendState=mendState;
}
-(void)viewWillAppear:(BOOL)animated{

}
-(void)loadVCData:(NSString*)uid {
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    //http://192.168.0.21:8080/propies/flow/flowinfo?flowId=36
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"propies/flow/flowinfo?flowId=",uid];
    NSLog(@"flowdetailurl:%@",urlstr);
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
                                              [self loadFlowInfoView:jsonDic];
                                              
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



//"flowId":36,
//"flowType":"安全",
//"flowNo":"GD201604070902042",
//"commitType":"其他",
//"ownerId":null,
//"user":"超级管理员",
//"commitTime":"2016-04-07 09:02:04",
//"flowStatus":"处理",
//"paigong":"2-超级管理员",
//"paigongTime":"2016-04-07 09:02:58",
//"deal":"测试用户",
//"dealTime":"2016-07-04 01:45:37",
//"huifang":null,
//"huifangTime":null,
//"remark":null,
//"userPhone":"13000000000",
//"paigongPhone":"13000000000",
//"dealPhone":"15111111111",
//"huifangPhone":null,
//"flowDesc":"请派人查看",
//"paigongDesc":null,
//"dealDesc":"已进行盘问，为小区业主",
//"huifangDesc":null,
//"guidang":null,
//"guidangTime":null,
//"guidangDesc":null,
//"guidangPhone":null,
//"mendId":61,
//"paigongId":null,
//"dealId":68,
//"userId":2,
//"flowTitle":"5号楼门口有陌生男子徘徊",
//"mendNo":null,
//"repairpeople":"测试业主"
-(void)loadFlowInfoView:(NSDictionary*)dict{
    
    CGFloat listY=TopSeachHigh+20;
    CGFloat cellHeigh=50;
    CGRect firstCG=CGRectMake(0, listY, fDeviceWidth, cellHeigh);
    NSArray *dictArray = [dict objectForKey:@"data"];
    
    for (NSDictionary *dicttmp in dictArray) {
        
        
        stdCellVc *personNo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"bianhao" titleName:@"工单编号：" txtName:[dicttmp objectForKey:@"flowNo"] lookImg:@"" sendid:1];
        [self.view addSubview:personNo];
        
        firstCG=CGRectMake(0, listY+51, fDeviceWidth, cellHeigh);
        stdCellVc *personName=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"flowTitle" titleName:@"工单标题：" txtName:[dicttmp objectForKey:@"flowTitle"] lookImg:@"" sendid:2];
        [self.view addSubview:personName];
        
        firstCG=CGRectMake(0, listY+51*2, fDeviceWidth, cellHeigh);
        stdCellVc *personSex=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"gongzhong" titleName:@"工单类型：" txtName:[dicttmp objectForKey:@"flowType"] lookImg:@"" sendid:3];
        [self.view addSubview:personSex];
        
        firstCG=CGRectMake(0, listY+51*3, fDeviceWidth, cellHeigh);
        stdCellVc *personType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"addType" titleName:@"提交类型：" txtName:[dicttmp objectForKey:@"commitType"] lookImg:@"" sendid:4];
        [self.view addSubview:personType];
        
        firstCG=CGRectMake(0, listY+51*4, fDeviceWidth, cellHeigh);
        stdCellVc *gzType=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"name" titleName:@"提交人：" txtName:[dicttmp objectForKey:@"repairpeople"] lookImg:@"" sendid:5];
        [self.view addSubview:gzType];
        
        firstCG=CGRectMake(0, listY+51*5, fDeviceWidth, cellHeigh);
        stdCellVc *addTime=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"timeIcon" titleName:@"提交时间：" txtName:[dicttmp objectForKey:@"commitTime"] lookImg:@"" sendid:6];
        [self.view addSubview:addTime];
        
        firstCG=CGRectMake(0, listY+51*6, fDeviceWidth, cellHeigh);
        stdCellVc *flowStatus=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"flowStaus" titleName:@"工作状态：" txtName:[dicttmp objectForKey:@"flowStatus"] lookImg:@"" sendid:7];
        [self.view addSubview:flowStatus];
        
        firstCG=CGRectMake(0, listY+51*7, fDeviceWidth, cellHeigh);
        stdCellVc *flowDesc=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"checkContent" titleName:@"工作内容：" txtName:[dicttmp objectForKey:@"flowDesc"] lookImg:@"" sendid:8];
        [self.view addSubview:flowDesc];
        
       
        [self addReportBtn];
        
    }
    
}

-(void)addReportBtn{
    CGFloat yy=fDeviceHeight-60;
    _addReport=[[UIButton alloc]initWithFrame:CGRectMake(10, yy, fDeviceWidth-20, 40)];
    _addReport.backgroundColor=topSearchBgdColor;
    [_addReport.layer setMasksToBounds:YES];
    [_addReport.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //[_addReport.layer setBorderWidth:1.0]; //边框宽度
    [_addReport addTarget:self action:@selector(stdAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addReport];
    
    if (_flowType==0) {
        [_addReport setTitle:@"接单"forState:UIControlStateNormal];// 添加文字
    }
    else{
        if ([_mendState isEqualToString:@"2"]) {
            [_addReport setTitle:@"处理完成"forState:UIControlStateNormal];// 添加文字
        }
        else
            _addReport.hidden=YES;
    }
    
   
    
}
-(void)pushChangeState{
    flowDoneViewController *FDVC=[[flowDoneViewController alloc]init];
    [FDVC setFlowId:_flowId];
    [self.navigationController pushViewController:FDVC animated:NO];
}
-(void)stdAddClick{
    
    if (_flowType==0)
    [self changeStateFlowToSrv];
    else{
        [self pushChangeState];
    }
}


-(void)changeStateFlowToSrv{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
   // http://192.168.0.21:8080/propies/flow/flowupdate?flowId=36&userId=1
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@",BaseUrl,@"propies/flow/flowupdate?flowId=",_flowId,
                      @"&userId=",ApplicationDelegate.myLoginInfo.userId
                      ];
    NSLog(@"addcheckstr:%@",urlstr);
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
                                              
                                              [SVProgressHUD dismiss];
                                              [self clickleftbtn];
                                              
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

-(void)std_regsNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(execute:)
                                                 name:k_Notification_Flow
                                               object:nil];
    
}

- (void)execute:(NSNotification *)notification {
    if([notification.name isEqualToString:k_Notification_Flow] ){
        _addReport.hidden=YES;
    }
}
@end
