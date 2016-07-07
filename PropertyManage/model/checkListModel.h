//
//  checkListModel.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface checkListModel : NSObject
@property (nonatomic,copy)NSString *checkId;
@property (nonatomic,copy)NSString *checkTime;
@property (nonatomic,copy)NSString *checkName;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
