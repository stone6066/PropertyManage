//
//  noticeDetailViewController.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "noticeDetailViewController.h"
#import "PublicDefine.h"

@interface noticeDetailViewController ()

@end

@implementation noticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadVCData:_noticeId];
}
-(void)setNoticeId:(NSString *)noticeId{
    _noticeId=noticeId;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"公告信息";
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
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@",BaseUrl,@"propies/index/notice?communityId=",ApplicationDelegate.myLoginInfo.communityId,@"&noticeId=",uid];
    
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
                                              [self loadDetailVc:jsonDic];
                                              
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

//"noticeId":2,
//"noticeTitle":"关于小区停车事宜通告",
//"noticeContent":"尊敬的业主，现小区可供免费停车位置为A门和C门旁的专用停车场，禁止在小区路边停放车辆，如违规停车，物业有权对车辆进行处罚，谢谢配合。",
//"createTime":"2016-03-12 09:12:28",
//"userId":2

-(void)loadDetailVc:(NSDictionary*)dict{
    
    UITextView *ContentText=[[UITextView alloc]initWithFrame:CGRectMake(0,TopSeachHigh*2, fDeviceWidth, fDeviceHeight-TopSeachHigh*2)];
    
    ContentText.textColor=txtColor;
    ContentText.backgroundColor=[UIColor whiteColor];
    ContentText.font=[UIFont systemFontOfSize:13];
    ContentText.editable=NO;
    
    UIView *topTitleVC=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, TopSeachHigh)];
    topTitleVC.backgroundColor=MyGrayColor;
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, fDeviceWidth, 25)];
    titleLbl.textAlignment=UITextAlignmentCenter;
    titleLbl.font=[UIFont systemFontOfSize:18];
    [titleLbl setTextColor:topSearchBgdColor];
    [topTitleVC addSubview:titleLbl];
    
    
    
    UILabel *noticeTime=[[UILabel alloc]initWithFrame:CGRectMake(0, 35, fDeviceWidth, 25)];
    noticeTime.textAlignment=UITextAlignmentCenter;
    noticeTime.font=[UIFont systemFontOfSize:13];
    [noticeTime setTextColor:txtColor];
    [topTitleVC addSubview:noticeTime];
    
    NSArray *dictArray = [dict objectForKey:@"data"];
   
    for (NSDictionary *dicttmp in dictArray) {
        
        
        ContentText.text=[dicttmp objectForKey:@"noticeContent"];
        titleLbl.text=[dicttmp objectForKey:@"noticeTitle"];
        noticeTime.text=[dicttmp objectForKey:@"createTime"];
        
       
        
        
    }
    [self.view addSubview:topTitleVC];
    [self.view addSubview:ContentText];
}


@end
