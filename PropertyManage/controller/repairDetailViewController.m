//
//  repairDetailViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "repairDetailViewController.h"
#import "PublicDefine.h"

@interface repairDetailViewController ()

@end

@implementation repairDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setMendId:(NSString *)mendId{
    _mendId=mendId;
}

-(void)setMendState:(NSString *)mendState{
    _mendState=mendState;
}

-(void)setMendType:(NSInteger)mendType{
    _mendType=mendType;
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"报事信息";
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

@end
