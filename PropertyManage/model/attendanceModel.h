//
//  attendanceModel.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/4.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface attendanceModel : NSObject
@property (nonatomic,copy)NSString *attendanceId;
@property (nonatomic,copy)NSString *empName;
@property (nonatomic,copy)NSString *attendanceTime;
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
