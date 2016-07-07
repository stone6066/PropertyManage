//
//  flowDoneViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "flowDoneViewController.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"
#import "FlowDetailViewController.h"
@interface flowDoneViewController ()<UITextFieldDelegate>

@end

@implementation flowDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    self.view.backgroundColor=MyGrayColor;
    [self loadAddView];
    [self textfieldRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setFlowId:(NSString *)flowId{
    _flowId=flowId;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"处理完成";
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

-(void)loadAddView{
    CGFloat firstY=TopSeachHigh+30;
    CGFloat VCWidth=fDeviceWidth-20;
    CGFloat VCHight=40;
    UIView *firstVc=[[UIView alloc]initWithFrame:CGRectMake(10, firstY, VCWidth, VCHight)];
    firstVc.backgroundColor=[UIColor whiteColor];
    
    _mendFee=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+0*50, VCWidth, VCHight)];
    [self stdInitTxtF:_mendFee hintxt:@" 维修费"];
    [self.view addSubview:_mendFee];
    
    _materialFee=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+1*50, VCWidth, VCHight)];
    [self stdInitTxtF:_materialFee hintxt:@" 材料费"];
    [self.view addSubview:_materialFee];
    
    _mendTable=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+2*50, VCWidth, VCHight)];
    [self stdInitTxtF:_mendTable hintxt:@" 所用材料"];
    [self.view addSubview:_mendTable];
    
    [self addReportBtn];
    
}

-(void)stdInitTxtF:(UITextField*)txtF hintxt:(NSString*)hintstr{
    txtF.backgroundColor = [UIColor whiteColor];
    [txtF setTintColor:spritLineColor];
    [txtF setFont:[UIFont systemFontOfSize:13]];
    txtF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    txtF.textColor=spritLineColor;
    [txtF.layer setMasksToBounds:YES];
    [txtF.layer setCornerRadius:5.0];
    txtF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:hintstr attributes:@{NSForegroundColorAttributeName: spritLineColor}];
    txtF.delegate=self;
}


-(void)addReportBtn{
    CGFloat yy=TopSeachHigh+30+200+10;
    UIButton *addReport=[[UIButton alloc]initWithFrame:CGRectMake(10, yy, fDeviceWidth-20, 40)];
    [addReport setTitle:@"提交"forState:UIControlStateNormal];// 添加文字
    addReport.backgroundColor=topSearchBgdColor;
    [addReport.layer setMasksToBounds:YES];
    [addReport.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //[_addReport.layer setBorderWidth:1.0]; //边框宽度
    [addReport addTarget:self action:@selector(stdAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReport];
    
}

-(void)textfieldRecognizer{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_mendFee resignFirstResponder];
    [_materialFee resignFirstResponder];
    [_mendTable resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    return YES;
}

-(void)stdAddClick{
    if ([self checkAddState]) {
        [self addFlowDownToSrv];
    }
    else{
        [stdPubFunc stdShowMessage:@"信息不完整，请完善后上传"];
    }
    
    NSLog(@"提交报修");
}
-(BOOL)checkAddState{
    
    if (_mendFee.text.length<1) {
        return NO;
    }
    if (_materialFee.text.length<1) {
        return NO;
    }
    if (_mendTable.text.length<1) {
        return NO;
    }
    return YES;
}
-(void)addFlowDownToSrv{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
   // http://192.168.0.21:8080/propies/flow/completeupdate?flowId=36&userId=68&mendFee=111.1&materialFee=55.1&mendTable=维修明细
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",BaseUrl,@"propies/flow/completeupdate?flowId=",_flowId,
                      @"&userId=",ApplicationDelegate.myLoginInfo.userId,
                      @"&mendFee=",_mendFee.text,
                      @"&materialFee=",_materialFee.text,
                      @"&mendTable=",_mendTable.text
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
                                              [[NSNotificationCenter defaultCenter]postNotificationName:k_Notification_Flow object:nil];
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


@end
