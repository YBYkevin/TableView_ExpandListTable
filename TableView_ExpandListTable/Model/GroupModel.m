//
//  GroupModel.m
//  TableView_ExpandListTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

- (NSMutableArray *)groupFirends
{
    if (!_groupFirends) {
        _groupFirends = [NSMutableArray array];
    }
    return _groupFirends;
}

@end
