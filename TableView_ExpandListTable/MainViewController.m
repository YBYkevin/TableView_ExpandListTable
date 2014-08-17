//
//  MainViewController.m
//  TableView_ExpandListTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewSectionHeaderView.h"
#import "FriendModel.h"
#import "GroupModel.h"

#define CELL_HEIGHT 50.0f
#define HEADVIEW_HEIGHT 54.0f

@interface MainViewController ()<TableViewSectionHeaderViewDelegate>

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    self.title = @"好友分组";
}
- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
    NSArray *dataList = [NSArray arrayWithContentsOfFile:path];
    
    [dataList enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
        GroupModel *group = [[GroupModel alloc] init];
        group.groupName = dic[@"groupname"];
        NSArray *friendsArray = dic[@"list"];
        [friendsArray enumerateObjectsUsingBlock:^(NSDictionary *subDic, NSUInteger idx, BOOL *stop) {
            FriendModel *friend = [[FriendModel alloc] init];
            friend.name = subDic[@"name"];
            friend.isOnline = [subDic[@"isonline"] boolValue];
            [group.groupFirends addObject:friend];
        }];
        [self.groups addObject:group];
    }];
    
}

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}



#pragma mark -
#pragma mark - TableView DataSource And Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADVIEW_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GroupModel *group = [self.groups objectAtIndex:section];
    NSInteger count = group.isOpened ? [group.groupFirends count]:0;
    return count;
    
}


-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    GroupModel *group = [self.groups objectAtIndex:section];
	NSString *headString = [NSString stringWithFormat:@"%@",group.groupName];
    TableViewSectionHeaderView *sectionHeadView = [[TableViewSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, HEADVIEW_HEIGHT)
                                                                                              title:headString
                                                                                            section:section
                                                                                             opened:group.isOpened
                                                                                           delegate:self] ;
    
	return sectionHeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    GroupModel *group = [self.groups objectAtIndex:indexPath.section];
    FriendModel *friend = [group.groupFirends objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.isOnline ? @"在线" : @"不在线";
    
    return cell;
}


#pragma mark - TableViewSectionHeaderViewDelegate

-(void)sectionHeaderView:(TableViewSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section
{
    [self refreshTableViewSection:section];//不需要动画，直接reloadData
}

-(void)sectionHeaderView:(TableViewSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section
{
    [self refreshTableViewSection:section];//不需要动画，直接reloadData
}

-(void)refreshTableViewSection:(NSInteger)section
{
    GroupModel *group = [self.groups objectAtIndex:section];
	group.isOpened = !group.isOpened;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
