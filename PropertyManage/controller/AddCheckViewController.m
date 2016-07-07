//
//  AddCheckViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AddCheckViewController.h"
#import "PublicDefine.h"
#import "checkTypeModel.h"
#import "stdPubFunc.h"
#import "SYQRCodeViewController.h"

@interface AddCheckViewController ()<UITextFieldDelegate>
{
    NSMutableArray *pickerArr;
    NSArray *stateArr;
    NSMutableArray *typeArr;//picker名字
    NSMutableArray *typeDataArr;//名字、id
    checkTypeModel *checkTypeData;
    
}


@end

@implementation AddCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    typeArr=[[NSMutableArray alloc]init];
    typeDataArr=[[NSMutableArray alloc]init];
    [self loadTopNav];
    self.view.backgroundColor=MyGrayColor;
    [self loadAddView];
    [self textfieldRecognizer];
    [self loadPickViewWithToolBar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPickViewWithToolBar{
    //    typeArr=[[NSArray alloc]initWithObjects:@"电梯",@"煤气",@"水电",@"其他", nil];
    //    stateArr=[[NSArray alloc]initWithObjects:@"紧急",@"一般",@"不急",@"其他", nil];
    pickerArr=[[NSMutableArray alloc]init];
    self.pView=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight-300, fDeviceWidth, 250)];
    self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, fDeviceWidth, 210)];
    self.pickerView.backgroundColor =MyGrayColor;// [UIColor whiteColor];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [self.pView addSubview:self.pickerView];
    
    UIButton *okBtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-60, 5, 60, 40)];
    [okBtn addTarget:self action:@selector(okClickbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [okBtn setTitle:@"完成"forState:UIControlStateNormal];// 添加文字
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.pView addSubview:okBtn];
    
    UIButton *cancleBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 60, 40)];
    [cancleBtn addTarget:self action:@selector(cancleClickbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [cancleBtn setTitle:@"取消"forState:UIControlStateNormal];// 添加文字
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.pView addSubview:cancleBtn];
    
    
    self.pView.hidden=YES;
    self.pView.backgroundColor=MyGrayColor;//[UIColor yellowColor];
    [self.view addSubview:self.pView];
    
}
-(void)okClickbtn{
    self.pView.hidden=YES;
    
    if (checkTypeData) {
            _repairType.text=checkTypeData.checkTypeName;
        }
    else
        {
            checkTypeData=[typeDataArr objectAtIndex:0];
            _repairType.text=checkTypeData.checkTypeName;
            
        }
    
   
    NSLog(@"ok");
}
-(void)cancleClickbtn{
    self.pView.hidden=YES;
    NSLog(@"cancle");
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"新增巡检";
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
    
    _repairType=[[UILabel alloc]initWithFrame:CGRectMake(4, 5, 80, 30)];
    _repairType.text=@"巡检类型";
    [_repairType setTextColor:spritLineColor];
    [_repairType setFont:[UIFont systemFontOfSize:13]];
    [firstVc addSubview:_repairType];
    [firstVc.layer setMasksToBounds:YES];
    [firstVc.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.view addSubview:firstVc];
    
    UIButton *typeBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, VCWidth, VCHight)];
    [typeBtn addTarget:self action:@selector(typeClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [firstVc addSubview:typeBtn];
    
    
    UIView *secondVc=[[UIView alloc]initWithFrame:CGRectMake(10, firstY+50, VCWidth, VCHight)];
    secondVc.backgroundColor=[UIColor whiteColor];
    _repairState=[[UILabel alloc]initWithFrame:CGRectMake(4, 5, 80, 30)];
    _repairState.text=@"巡检点";
    [_repairState setFont:[UIFont systemFontOfSize:13]];
    [_repairState setTextColor:spritLineColor];
    [secondVc addSubview:_repairState];
    [secondVc.layer setMasksToBounds:YES];
    [secondVc.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.view addSubview:secondVc];
    UIButton *StateBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, VCWidth, VCHight)];
    [StateBtn addTarget:self action:@selector(stateClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [secondVc addSubview:StateBtn];
    UILabel *scanHint=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-80, 5, 80, 30)];
    scanHint.text=@"单击扫码";
    [scanHint setTextColor:[UIColor redColor]];
    
    [scanHint setFont:[UIFont systemFontOfSize:13]];
    [secondVc addSubview:scanHint];
    
    _repairTitle=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+2*50, VCWidth, VCHight)];
    [self stdInitTxtF:_repairTitle hintxt:@" 巡检内容"];
    [self.view addSubview:_repairTitle];
    
    _repaitText=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+3*50, VCWidth, VCHight)];
    [self stdInitTxtF:_repaitText hintxt:@" 操作备注"];
    [self.view addSubview:_repaitText];
    [self addReportBtn];
    
}

-(void)stateClickBtn{
//    self.pView.hidden=NO;
//    _pickerType=1;
    [self doScan];
    
    NSLog(@"state点击");
}

- (void)doScan
{
    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        _repairState.text=qrString;
        
    };
    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:qrcodevc animated:YES completion:nil];
    //    [self drawDropDownList:button.frame.origin.x+button.frame.size.width/2 ListY:button.frame.origin.y+button.frame.size.height];
}

-(void)typeClickBtn{
    self.pView.hidden=NO;
    _pickerType=0;
    [self loadTypeData];
    //[self loadPickerView:typeArr];
    NSLog(@"lbltype点击");
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
-(void)stdAddClick{
    if ([self checkAddState]) {
        [self addMendToSrv];
    }
    else{
        [stdPubFunc stdShowMessage:@"信息不完整，请完善后上传"];
    }
    
    NSLog(@"提交报修");
}
-(BOOL)checkAddState{
    if ([_repairType.text isEqualToString:@"巡检类型"]) {
        return NO;
    }
    if ([_repairState.text isEqualToString:@"巡检点"]) {
        return NO;
    }
    if (_repairTitle.text.length<1) {
        return NO;
    }
    if (_repaitText.text.length<1) {
        return NO;
        
    
    }
    return YES;
}
-(void)textfieldRecognizer{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_repairTitle resignFirstResponder];
    [_repaitText resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    return YES;
}


-(void)loadPickerView:(NSArray*)arr{
    
    [pickerArr removeAllObjects];
    [pickerArr addObjectsFromArray:arr];
    [self.pickerView reloadAllComponents];//刷新UIPickerView
}

#pragma mark PickerView delegete
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerArr.count;
}

//返回指定列的行高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20;
}
//返回指定列的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return fDeviceWidth-10;
}

//自定义指定列每行的视图、即指定列的每行视图行为一致
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth-10, 20)];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = [pickerArr objectAtIndex:row];
    [view addSubview:text];
    
    return view;}

//显示的标题
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString* str=[pickerArr objectAtIndex:row];
    return str;
}

//显示的标题字体、颜色等属性
-(NSAttributedString*)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [pickerArr objectAtIndex:row];
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    return AttributedString;}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    checkTypeData=[typeDataArr objectAtIndex:row];
    NSLog(@"选择:%@",[pickerArr objectAtIndex:row]);
    
}


-(void)loadTypeData{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
   //http://192.168.0.21:8080/propies/check/type
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"propies/check/type"];
    
    
    NSLog(@"baoxiuurlstr:%@",urlstr);
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
                                              
                                              [self operateData:jsonDic];
                                              
                                              [SVProgressHUD dismiss];
                                              
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

-(void)operateData:(NSDictionary*)jsonData{
    checkTypeModel *mtm=[[checkTypeModel alloc]init];
    typeDataArr=[mtm asignModelWithDict:jsonData];
    [typeArr removeAllObjects];
    for (checkTypeModel *CM in typeDataArr)
    {
        [typeArr addObject:CM.checkTypeName];
    }

    self.pView.hidden=NO;
    [self loadPickerView:typeArr];
    
}


-(void)addMendToSrv{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
    //http://192.168.0.21:8080/propies/check/checkadd?checkType=1&checkContent=阿瓦达阿瓦达&userId=68
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",BaseUrl,@"propies/check/checkadd?checkType=",checkTypeData.checkId,
                      @"&checkContent=",_repairTitle.text,
                      @"&userId=",ApplicationDelegate.myLoginInfo.userId,
                      @"&remark=",_repaitText.text,
                      @"&checkPoint=",_repairState.text,
                      @"&checkTime=",[self getCurrentTime]];
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


-(NSString *)getCurrentTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [dateFormatter stringFromDate:currentDate];
}
@end
