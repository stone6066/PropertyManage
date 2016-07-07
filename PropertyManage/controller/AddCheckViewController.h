//
//  AddCheckViewController.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCheckViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UILabel *repairType;//巡检类型
@property(nonatomic,strong)UILabel *repairState;//巡检点
@property(nonatomic,strong)UITextField *repairTitle;//巡检内容
@property(nonatomic,strong)UITextField *repaitText;//备注
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIView *pView;
@property(nonatomic,assign)NSInteger pickerType;//0类型  1状态

@end
