//
//  staffDetailModel.h
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

//"staffId":1,
//"staffName":"马三一",
//"staffContact":"13555951990",
//"staffJobstype":"保安"

@interface staffDetailModel : NSObject
@property(nonatomic,copy)NSString *staffId;
@property(nonatomic,copy)NSString *staffName;
@property(nonatomic,copy)NSString *staffContact;
@property(nonatomic,copy)NSString *staffJobstype;

@end
