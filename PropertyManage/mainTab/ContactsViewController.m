//
//  ContactsViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ContactsViewController.h"
#import "PublicDefine.h"
#import "staffGroupModel.h"
#import "ListTableViewCell.h"
#import "staffDetailModel.h"
#import "staffDetailViewController.h"

@interface ContactsViewController ()
{
    NSMutableArray *_tableDataSource;
    NSInteger _pageindex;
}
@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self loadTableView];
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
    _pageindex=1;
    [self loadTableData:_pageindex];
    
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"contacts_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"通讯录";
        
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
    topLbl.text=@"通讯录";
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    [self.view addSubview:TopView];
}
static NSString * const MarketCellId = @"contacts";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=MyGrayColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:MarketCellId];
    
    //self.TableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.TableView];
    
    _pageindex=1;
    //[self loadTableData:@"uid" typeStr:_listType pageNo:_pageindex];
    
    
    
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=1;
        [self loadTableData:_pageindex];
        [weakSelf.TableView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_tableDataSource.count>0) {
            _pageindex+=1;
            [self loadTableData:_pageindex];
        }
        else
        {
            _pageindex=1;
            [self loadTableData:_pageindex];
        }
        
        // 结束刷新
        [weakSelf.TableView.mj_footer endRefreshing];
    }];
    
    
}
#pragma mark table delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableDataSource.count>0) {
        staffGroupModel *GOB=[[staffGroupModel alloc]init];
        GOB=_tableDataSource[section];
        return GOB.layerContent.count;
    }
    else
        return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_tableDataSource.count>0) {
        staffGroupModel *GOB=[[staffGroupModel alloc]init];
        GOB=_tableDataSource[section];
        return GOB.layerName;
    }
    return @"";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell， if (_tableDataSource.count>0)
    
    staffGroupModel *GOB=[[staffGroupModel alloc]init];
    GOB=_tableDataSource[indexPath.section];
    staffDetailModel *dm=GOB.layerContent[indexPath.item];
    [cell showUiStaffCell:dm];
    
    
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    if (_tableDataSource.count) {
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    }else{
    //        cell.accessoryType = UITableViewCellAccessoryNone;
    //    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *svc =(ListTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    staffDetailModel *dm= [svc praseContactData:svc];
    staffDetailViewController * staffDetailVc=[[staffDetailViewController alloc]init];
    [staffDetailVc setStaffId:dm.staffId];
    [self.navigationController pushViewController:staffDetailVc animated:NO];
    
}
-(void)loadTableData:(NSInteger)pagenum{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%ld%@",BaseUrl,@"propies/staff/stafflist?page=",(long)pagenum,@"&pagesize=3"];
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
                                              staffGroupModel *SGM=[[staffGroupModel alloc]init];
//                                              _tableDataSource=[SGM assignWithDict:jsonDic];
                                              if (_pageindex==1) {
                                                  _tableDataSource=[SGM assignWithDict:jsonDic];
                                              }
                                              else
                                              {
                                                  [_tableDataSource addObjectsFromArray:[SGM assignWithDict:jsonDic]];
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
