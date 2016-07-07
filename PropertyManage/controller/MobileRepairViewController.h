//
//  MobileRepairViewController.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobileRepairViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,assign)NSInteger listType;//0未受理、1已受理
@property(nonatomic,strong)UIButton *addReport;
@end
