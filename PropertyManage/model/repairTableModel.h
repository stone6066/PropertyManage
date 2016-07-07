//
//  repairTableModel.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface repairTableModel : NSObject
@property (nonatomic,copy)NSString *noticeId;
@property (nonatomic,copy)NSString *noticeTitle;
@property (nonatomic,copy)NSString *noticeContent;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *userId;
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict;
@end
