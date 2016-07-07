//
//  flowListModel.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface flowListModel : NSObject
@property(nonatomic,copy)NSString *flowId;
@property(nonatomic,copy)NSString *commitTime;
@property(nonatomic,copy)NSString *flowStatusType;
@property(nonatomic,copy)NSString *flowTitle;
@property(nonatomic,copy)NSString *mendState;
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
