//
//  mendDetailViewController.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RatingBar;

@interface mendDetailViewController : UIViewController
@property(nonatomic,copy)NSString * mendId;
@property(nonatomic,strong)RatingBar * raBar;
@property(nonatomic,assign)NSInteger  lType;
@end
