//
//  ViewController.m
//  ZHTableViewGroupExample
//
//  Created by josercc on 2020/2/25.
//  Copyright © 2020 josercc. All rights reserved.
//

#import "ViewController.h"
#import <ZHTableViewGroupObjc/ZHTableViewGroupObjc.h>
#import "ReloadHeightViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ZHTableViewDataSource *tableViewDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableViewDataSource clearData];
    __weak typeof(self) weakSelf = self;
    [self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf addReloadHeightInGroup:group];
    }];
    [self.tableViewDataSource reloadTableViewData];
}

- (void)addReloadHeightInGroup:(ZHTableViewGroup *)group {
    [group addCellWithCompletionHandle:^(ZHTableViewCell<UITableViewCell *> *tableViewCell) {
        tableViewCell.anyClass = [UITableViewCell  class];
        tableViewCell.identifier = @"UITableViewCell";
        [tableViewCell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = @"刷新高度";
        }];
        [tableViewCell setDidSelectRowCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
            ReloadHeightViewController *controller = [[ReloadHeightViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }];
    }];
}

- (ZHTableViewDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[ZHTableViewDataSource alloc] initWithTableView:self.tableView];
    }
    return _tableViewDataSource;
}

@end
