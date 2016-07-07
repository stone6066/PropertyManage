//
//  SettingViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SettingViewController.h"
#import "PublicDefine.h"
#import "stdCellVc.h"
#import "personInfoViewController.h"
#import "AlertPswViewController.h"

@interface SettingViewController ()<StdButtonDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self loadSettingView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"setting_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"设置";
        
        self.tabBarItem.title=tittxt;
        
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    topLbl.text=@"设置";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    [self.view addSubview:TopView];
}

-(void)loadSettingView{
    CGFloat listY=TopSeachHigh+20;
    CGFloat cellHeigh=50;
    CGRect firstCG=CGRectMake(0, listY, fDeviceWidth, cellHeigh);
    stdCellVc *personInfo=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"personInfo" titleName:@"个人信息" txtName:@"" lookImg:@"rightArrow" sendid:1];
    [self.view addSubview:personInfo];
    
    firstCG=CGRectMake(0, listY+51, fDeviceWidth, cellHeigh);
    stdCellVc *alterPsw=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"alertpsw" titleName:@"修改密码" txtName:@"" lookImg:@"rightArrow" sendid:2];
    [self.view addSubview:alterPsw];
    
    firstCG=CGRectMake(0, listY+51*2, fDeviceWidth, cellHeigh);
    stdCellVc *about=[[stdCellVc alloc]initWithFrame:firstCG iocnImg:@"about" titleName:@"关于 V1.0" txtName:@"" lookImg:@"rightArrow" sendid:3];
    [self.view addSubview:about];
    
    personInfo.stdDelegate=self;
    alterPsw.stdDelegate=self;
    [self addReportBtn];

}


-(void)pushPersonVC{
    personInfoViewController *personVc=[[personInfoViewController alloc]init];
    [personVc setUserId:ApplicationDelegate.myLoginInfo.userId];
    [self.navigationController pushViewController:personVc animated:NO];
}

-(void)pushPswVC{
    AlertPswViewController *pswVc=[[AlertPswViewController alloc]init];
    [self.navigationController pushViewController:pswVc animated:NO];
}
-(void)clickDelegate:(NSInteger)sendId{
    NSLog(@"%ld",(long)sendId);
    
    switch (sendId) {
        case 1://个人信息
            [self pushPersonVC];
            break;
        case 2://修改密码
            [self pushPswVC];
            break;
            
        default:
            break;
    }
}
-(void)addReportBtn{
    CGFloat yy=fDeviceHeight-MainTabbarHeight-60;
    UIButton *addReport=[[UIButton alloc]initWithFrame:CGRectMake(10, yy, fDeviceWidth-20, 40)];
    [addReport setTitle:@"退出登录"forState:UIControlStateNormal];// 添加文字
    addReport.backgroundColor=topSearchBgdColor;
    [addReport.layer setMasksToBounds:YES];
    [addReport.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //[_addReport.layer setBorderWidth:1.0]; //边框宽度
    [addReport addTarget:self action:@selector(stdAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReport];
    
}
-(void)stdAddClick{
    ApplicationDelegate.isLogin=NO;
    [ApplicationDelegate.tabBarViewController setSelectedIndex:0];
    [self hideTabBar];
    NSLog(@"退出登录");
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    self.tabBarController.tabBar.hidden = YES;
    
}
@end
