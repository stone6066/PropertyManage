//
//  mendTypeModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mendTypeModel : NSObject
@property (nonatomic,copy)NSString *mendTypeId;
@property (nonatomic,copy)NSString *mendTypeName;
@property (nonatomic,copy)NSString *deleteStatus;

- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
