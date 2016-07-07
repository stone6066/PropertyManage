//
//  addRepairViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addRepairViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UILabel *repairType;//报修类型
@property(nonatomic,strong)UILabel *repairState;//紧急程度
@property(nonatomic,strong)UITextField *repairTitle;//标题
@property(nonatomic,strong)UITextField *repaitText;//内容
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIView *pView;
@property(nonatomic,assign)NSInteger pickerType;//0类型  1状态
@end
