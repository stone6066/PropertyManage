//
//  flowDoneViewController.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface flowDoneViewController : UIViewController
@property(nonatomic,copy)NSString *flowId;
@property(nonatomic,strong)UITextField *mendFee;//维护费
@property(nonatomic,strong)UITextField *materialFee;//材料费
@property(nonatomic,strong)UITextField *mendTable;//所用材料
@end
