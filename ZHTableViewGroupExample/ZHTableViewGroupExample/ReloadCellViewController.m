//
//  ReloadCellViewController.m
//  ZHTableViewGroupExample
//
//  Created by josercc on 2020/2/25.
//  Copyright © 2020 josercc. All rights reserved.
//

#import "ReloadCellViewController.h"

@interface ReloadCellViewController ()

@end

@implementation ReloadCellViewController {
    NSUInteger _index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableViewDataSource clearData];
    [self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
            cell.anyClass = [UITableViewCell class];
            cell.identifier = @"UITableViewCell";
            [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                cell.textLabel.text = [@(random() % 99 + 1) stringValue];
            }];
        }];
    }];
    [self.tableViewDataSource reloadTableViewData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
}

- (void)refresh {
    _index = MIN(3, _index);
    if (_index == 0) {
        [self.tableViewDataSource reloadCellWithIdentifier:@"UITableViewCell"];
    } else if (_index == 1) {
        [self.tableViewDataSource reloadCellWithClassName:[UITableViewCell class]];
    } else if (_index == 2) {
        [self.tableViewDataSource reloadCellWithTableViewCell:self.tableViewDataSource.groups[0].cells[0]];
    } else if (_index == 3) {
        [self.tableViewDataSource reloadCellWithGroupIndex:0 cellIndex:0];
    }
    _index += 1;
}

@end
