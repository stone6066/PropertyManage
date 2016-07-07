//
//  staffGroupModel.h
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface staffGroupModel : NSObject
@property(nonatomic,copy)NSString *layerName;
@property(nonatomic,copy)NSMutableArray *layerContent;
-(NSMutableArray *)assignWithDict:(NSDictionary *)dict;
@end
