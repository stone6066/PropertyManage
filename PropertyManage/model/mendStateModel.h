//
//  mendStateModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mendStateModel : NSObject
@property (nonatomic,copy)NSString *mendLevelId;
@property (nonatomic,copy)NSString *mendLevelName;


- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
