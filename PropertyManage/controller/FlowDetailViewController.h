//
//  FlowDetailViewController.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowDetailViewController : UIViewController
@property(nonatomic,copy)NSString *flowId;
@property(nonatomic,assign)NSInteger flowType;
@property(nonatomic,copy)NSString* mendState;
@property(nonatomic,strong)UIButton* addReport;

@end
