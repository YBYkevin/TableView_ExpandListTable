//
//  TableViewSectionHeaderView.h
//  TableView_ExpandListTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewSectionHeaderViewDelegate;

@interface TableViewSectionHeaderView : UIView

@property (nonatomic, assign) id <TableViewSectionHeaderViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber opened:(BOOL)isOpened delegate:(id<TableViewSectionHeaderViewDelegate>)delegate;

@end

@protocol TableViewSectionHeaderViewDelegate <NSObject> 

@optional
-(void)sectionHeaderView:(TableViewSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;

-(void)sectionHeaderView:(TableViewSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;

@end
