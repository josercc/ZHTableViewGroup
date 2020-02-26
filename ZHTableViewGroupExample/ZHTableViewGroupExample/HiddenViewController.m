//
//  HiddenViewController.m
//  ZHTableViewGroupExample
//
//  Created by josercc on 2020/2/26.
//  Copyright © 2020 josercc. All rights reserved.
//

#import "HiddenViewController.h"

@interface HiddenViewController ()

@end

@implementation HiddenViewController {
    BOOL _hidden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableViewDataSource clearData];
    [self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
            cell.anyClass = [UITableViewCell class];
            cell.identifier = @"UITableViewCell";
            cell.cellNumber = 10;
            [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                cell.textLabel.text = [@(indexPath.row + 1) stringValue];
            }];
            [cell setHiddenBlock:^BOOL(NSIndexPath *indexPath) {
                return _hidden && indexPath.row >= 5 && indexPath.row <= 8;
            }];
        }];
    }];
    [self.tableViewDataSource reloadTableViewData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
}

- (void)refresh {
    _hidden = !_hidden;
    [self.tableViewDataSource reloadAllHiddenCell];
}

@end
