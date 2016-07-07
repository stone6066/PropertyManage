//
//  MobileFlowViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MobileFlowViewController.h"
#import "PublicDefine.h"
#import "flowListModel.h"
#import "ListTableViewCell.h"
#import "FlowDetailViewController.h"
@interface MobileFlowViewController ()
{
    NSMutableArray *_tableDataSource;
    NSInteger _pageindex;
}
@end

@implementation MobileFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    
    _pageindex=0;
    _tableDataSource=[[NSMutableArray alloc]init];
    [self drawSegmentedView];
    [self loadTableView];
    _pageindex=1;
    _listType=0;
    [self loadTableData:ApplicationDelegate.myLoginInfo.userId typeStr:_listType pageNo:_pageindex];
    // Do any additional setup after loading the view.
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
    topLbl.text=@"移动接单";
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
-(void)drawSegmentedView{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"未受理工单",@"已受理工单",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    CGFloat sgWidth=fDeviceWidth-40;
    segmentedControl.frame = CGRectMake(20,TopSeachHigh+10,sgWidth,30);
    // 设置默认选择项索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = topSearchBgdColor;
    
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)Index);
    [_tableDataSource removeAllObjects];
    if (Index==0) {//未受理
        _listType=0;
        
        _pageindex=1;
        [self loadTableData:ApplicationDelegate.myLoginInfo.userId typeStr:_listType pageNo:_pageindex];    }
    else{
        _listType=1;
        
        _pageindex=1;
        [self loadTableData:ApplicationDelegate.myLoginInfo.userId typeStr:_listType pageNo:_pageindex];
        
    }

}
-(void)loadTableData:(NSString*)uid typeStr:(NSInteger)strTmp pageNo:(NSInteger)pagenum{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
   
    NSString *urlstr=@"";
    if (strTmp==0) {
        urlstr=[NSString stringWithFormat:@"%@%@%@%@%ld%@",BaseUrl,@"propies/flow/notaccept?userId=",uid,@"&page=",(long)pagenum,@"&pagesize=20"];
    }
    else
        urlstr=[NSString stringWithFormat:@"%@%@%@%@%ld%@",BaseUrl,@"propies/flow/accept?userId=",uid,@"&page=",(long)pagenum,@"&pagesize=20"];
    NSLog(@"complainstr:%@",urlstr);
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
                                              flowListModel *SM=[[flowListModel alloc]init];
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

#pragma mark -loadTableView

static NSString * const MarketCellId = @"flowTableCell";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+50, fDeviceWidth, fDeviceHeight-TopSeachHigh-50)];
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
        [self loadTableData:ApplicationDelegate.myLoginInfo.userId typeStr:_listType pageNo:_pageindex];
        [weakSelf.TableView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_tableDataSource.count>0) {
            _pageindex+=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.userId typeStr:_listType pageNo:_pageindex];
            
        }
        else
        {
            _pageindex=1;
            [self loadTableData:ApplicationDelegate.myLoginInfo.userId typeStr:_listType pageNo:_pageindex];
            
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
    flowListModel *dm=_tableDataSource[indexPath.item];
    if (_listType==0) {
        [cell showUiFlowCell:dm icon_type:@"NOSL"];
    }
    else
        [cell showUiFlowCell:dm icon_type:@"YSL"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *svc =(ListTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    flowListModel *dm= [svc praseFlowData:svc];
    FlowDetailViewController *shortCutView=[[FlowDetailViewController alloc]init];

    [shortCutView setFlowId:dm.flowId];
    [shortCutView setFlowType:_listType];
    [shortCutView setMendState:dm.mendState];
    shortCutView.view.backgroundColor = MyGrayColor;
    [self.navigationController pushViewController:shortCutView animated:NO];
    
}
@end
