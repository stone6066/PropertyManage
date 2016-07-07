//
//  checkTypeModel.h
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface checkTypeModel : NSObject
@property(nonatomic,copy)NSString *checkId;
@property(nonatomic,copy)NSString *checkTypeName;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;

@end
