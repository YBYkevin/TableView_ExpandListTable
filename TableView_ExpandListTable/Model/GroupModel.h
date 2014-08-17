//
//  GroupModel.h
//  TableView_ExpandListTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSMutableArray *groupFirends;

@end
