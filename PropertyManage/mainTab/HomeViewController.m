//
//  HomeViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PublicDefine.h"
#import "stdImgBtn.h"
#import "attendanceListViewController.h"
#import "checkListViewController.h"
#import "MobileFlowViewController.h"
#import "MobileRepairViewController.h"
@interface HomeViewController ()<StdImgButtonDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawMainVc];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"首页";
        
        self.tabBarItem.title=tittxt;
        
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //self.navigationController.navigationBar.hidden=YES;
    if (!ApplicationDelegate.isLogin) {
        //显示登录页面
        LoginViewController *vc = [[LoginViewController alloc]init];
        vc.loginSuccBlock = ^(LoginViewController *aqrvc){
            NSLog(@"login_suc");
            [self showTabBar];
            //[self loadTableData:ApplicationDelegate.myLoginInfo.communityId  pageNo:1];
        };
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }
//    else
//        [self drawMainVc];
    
}
- (void)showTabBar
{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    self.tabBarController.tabBar.hidden = NO;
    
}
-(void)drawMainVc{
    UIImageView *topImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight*0.618)];
    
    topImg.image=[UIImage imageNamed:@"homeTop"];
    [self.view addSubview:topImg];
    
    
    UIView *bottomVc=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight*0.618, fDeviceWidth, fDeviceHeight*(1-0.618))];
    CGFloat widthXY=fDeviceWidth/4;
    CGFloat heighY=(fDeviceHeight*(1-0.618)-widthXY-30-TopSeachHigh)/2;
    stdImgBtn *firstbtn=[[stdImgBtn alloc]initWithFrame:CGRectMake(0, heighY, widthXY, widthXY+30) imgName:@"attendance" lblName:@"员工考勤" sendId:0];
    stdImgBtn *secondbtn=[[stdImgBtn alloc]initWithFrame:CGRectMake(widthXY, heighY, widthXY, widthXY+30) imgName:@"inspection" lblName:@"巡检管理" sendId:1];
    stdImgBtn *thirdbtn=[[stdImgBtn alloc]initWithFrame:CGRectMake(widthXY*2, heighY, widthXY, widthXY+30) imgName:@"ydjd" lblName:@"移动接单" sendId:2];
    stdImgBtn *fourbtn=[[stdImgBtn alloc]initWithFrame:CGRectMake(widthXY*3, heighY, widthXY, widthXY+30) imgName:@"ydbs" lblName:@"移动报事" sendId:3];
    
    firstbtn.stdImgBtnDelegate=self;
    secondbtn.stdImgBtnDelegate=self;
    thirdbtn.stdImgBtnDelegate=self;
    fourbtn.stdImgBtnDelegate=self;
    [bottomVc addSubview:firstbtn];
    [bottomVc addSubview:secondbtn];
    [bottomVc addSubview:thirdbtn];
    [bottomVc addSubview:fourbtn];
    [self.view addSubview:bottomVc];

}

-(void)pushAttendView{
    attendanceListViewController *attVc=[[attendanceListViewController alloc]init];
    attVc.hidesBottomBarWhenPushed=YES;
    attVc.navigationItem.hidesBackButton=YES;
    attVc.view.backgroundColor = MyGrayColor;
    [self.navigationController pushViewController:attVc animated:NO];
}

-(void)pushCheckView{
    checkListViewController *attVc=[[checkListViewController alloc]init];
    attVc.hidesBottomBarWhenPushed=YES;
    attVc.navigationItem.hidesBackButton=YES;
    attVc.view.backgroundColor = MyGrayColor;
    [self.navigationController pushViewController:attVc animated:NO];
}
-(void)pushFlowView{
    MobileFlowViewController *attVc=[[MobileFlowViewController alloc]init];
    attVc.hidesBottomBarWhenPushed=YES;
    attVc.navigationItem.hidesBackButton=YES;
    attVc.view.backgroundColor = MyGrayColor;
    [self.navigationController pushViewController:attVc animated:NO];
}

-(void)pushMendView{
    MobileRepairViewController *attVc=[[MobileRepairViewController alloc]init];
    attVc.hidesBottomBarWhenPushed=YES;
    attVc.navigationItem.hidesBackButton=YES;
    attVc.view.backgroundColor = MyGrayColor;
    [self.navigationController pushViewController:attVc animated:NO];
}

-(void)stdImgClickDelegate:(NSInteger)sendId{
    switch (sendId) {
        case 0:
            [self pushAttendView];
            break;
        case 1:
            [self pushCheckView];
            break;
        case 2:
            [self pushFlowView];
            break;
        case 3:
            [self pushMendView];
            break;
        default:
            break;
    }
}
@end
