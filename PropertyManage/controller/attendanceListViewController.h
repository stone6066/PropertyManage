//
//  attendanceListViewController.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/4.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface attendanceListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;

@end
