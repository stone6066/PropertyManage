//
//  checkListViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "checkListViewController.h"
#import "PublicDefine.h"
#import "ListTableViewCell.h"
#import "checkListModel.h"
#import "checkDetailViewController.h"
#import "AddCheckViewController.h"
@interface checkListViewController ()
{
    NSMutableArray *_tableDataSource;
    NSInteger _pageindex;
}
@end

@implementation checkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self loadTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    _pageindex=1;
    [self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
}


-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    topLbl.text=@"巡检管理";
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
    
    
    UIImageView *addimg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, 28, 24, 24)];
    addimg.image=[UIImage imageNamed:@"add"];
    [TopView addSubview:addimg];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn setFrame:CGRectMake(fDeviceWidth-80, 22, 80, 42)];
    [addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:addBtn];
    //addBtn.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:TopView];
}
-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

//新增巡检
-(void)clickAddBtn{
    AddCheckViewController *addAttVc=[[AddCheckViewController alloc]init];
    [self.navigationController pushViewController:addAttVc animated:NO];
}
static NSString * const MarketCellId = @"checkListCellId";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:MarketCellId];
    
    //self.TableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.TableView];
    
    
    
    
    
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=1;
        [self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
        [weakSelf.TableView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_tableDataSource.count>0) {
            _pageindex+=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
        }
        else
        {
            _pageindex=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
        }
        
        // 结束刷新
        [weakSelf.TableView.mj_footer endRefreshing];
    }];
    
    
}
#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    checkListModel *dm=_tableDataSource[indexPath.item];
    [cell showUiCheckListCell:dm];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *svc =(ListTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    checkListModel *dm= [svc praseCheckData:svc];
    
    checkDetailViewController *checkVc=[[checkDetailViewController alloc]init];
    [checkVc setCheckId:dm.checkId];
    [checkVc setCheckName:dm.checkName];
    [self.navigationController pushViewController:checkVc animated:NO];
    
}


-(void)loadTableData:(NSString*)uid  pageNo:(NSInteger)pagenum{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
    //http://192.168.0.21:8080/propies/check/checklist?userId=2&page=1&pagesize=20
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%ld%@",BaseUrl,@"propies/check/checklist?userId=",ApplicationDelegate.myLoginInfo.userId,@"&page=",(long)pagenum,@"&pagesize=20"];
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
                                              checkListModel *SM=[[checkListModel alloc]init];
                                              NSMutableArray *datatmp=[SM asignModelWithDict:jsonDic];
                                              if (pagenum==1) {
                                                  _tableDataSource=datatmp;
                                              }
                                              else{
                                                  [_tableDataSource addObjectsFromArray:datatmp];
                                              }
                                              [self.TableView reloadData];
                                              
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
