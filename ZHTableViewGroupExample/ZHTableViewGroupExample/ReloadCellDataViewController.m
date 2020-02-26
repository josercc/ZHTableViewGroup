//
//  ReloadCellDataViewController.m
//  ZHTableViewGroupExample
//
//  Created by josercc on 2020/2/25.
//  Copyright © 2020 josercc. All rights reserved.
//

#import "ReloadCellDataViewController.h"

@interface ReloadCellDataViewController ()

@end

@implementation ReloadCellDataViewController {
    NSUInteger _index;
    NSMutableArray<NSString *> *_randoms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _randoms = [NSMutableArray arrayWithArray:@[@"random"]];
    [self.tableViewDataSource clearData];
    [self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
            cell.anyClass = [UITableViewCell class];
            cell.identifier = @"UITableViewCell";
            cell.cellNumber = _randoms.count;
            [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                cell.textLabel.text = _randoms[indexPath.row];
            }];
        }];
    }];
    [self.tableViewDataSource reloadTableViewData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
}

- (void)refresh {
    _index = MIN(3, _index);
    NSUInteger randomCount = random() % 9 + 1;
    [_randoms removeAllObjects];
    for (NSUInteger i = 0; i < randomCount; i++) {
        [_randoms addObject:[NSString stringWithFormat:@"random:%@",@(i)]];
    }
    if (_index == 0) {
        [self.tableViewDataSource reloadCellWithDataCount:_randoms.count identifier:@"UITableViewCell"];
    } else if (_index == 1) {
        [self.tableViewDataSource reloadCellWithDataCount:_randoms.count className:[UITableViewCell class]];
    } else if (_index == 2) {
        [self.tableViewDataSource reloadCellWithDataCount:_randoms.count tableViewCell:self.tableViewDataSource.groups[0].cells[0]];
    } else if (_index == 3) {
        [self.tableViewDataSource reloadCellWithDataCount:_randoms.count groupIndex:0 cellIndex:0];
    }
    _index += 1;
}

@end
