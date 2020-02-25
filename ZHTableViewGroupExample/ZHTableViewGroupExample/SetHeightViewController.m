//
//  SetHeightViewController.m
//  ZHTableViewGroupExample
//
//  Created by josercc on 2020/2/25.
//  Copyright © 2020 josercc. All rights reserved.
//

#import "SetHeightViewController.h"

@interface SetHeightViewController ()

@end

@implementation SetHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles = @[
        @"identifier更新自动高度",
        @"identifier更新固定250高度",
        @"Class更新自动高度",
        @"Class更新固定260高度",
        @"指定ZHTableViewCell更新自动高度",
        @"指定ZHTableViewCell更新固定270高度",
        @"指定索引更新自动高度",
        @"指定索引更新固定280高度",
    ];
    [self.tableViewDataSource clearData];
    [self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
            cell.anyClass = [UITableViewCell class];
            cell.identifier = @"UITableViewCell";
            cell.cellNumber = titles.count;
            [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                cell.textLabel.text = titles[indexPath.row];
            }];
            [cell setDidSelectRowCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                if (indexPath.row == 0) {
                    [self.updateTableViewDataSource reloadCellAutomaticHeightWithIdentifier:@"ReloadHeightCell1"];
                } else if (indexPath.row == 1) {
                    [self.updateTableViewDataSource reloadCellFixedHeight:250 identifier:@"ReloadHeightCell1"];
                } else if (indexPath.row == 2) {
                    [self.updateTableViewDataSource reloadCellAutomaticHeightWithClass:NSClassFromString(@"ReloadHeightCell1")];
                } else if (indexPath.row == 3) {
                    [self.updateTableViewDataSource reloadCellFixedHeight:260 className:NSClassFromString(@"ReloadHeightCell1")];
                } else if (indexPath.row == 4) {
                    [self.updateTableViewDataSource reloadCellAutomaticHeightWithTableViewCell:self.updateTableViewDataSource.groups[0].cells[0]];
                } else if (indexPath.row == 5) {
                    [self.updateTableViewDataSource reloadCellFixedHeight:270 tableViewCell:self.updateTableViewDataSource.groups[0].cells[0]];
                } else if (indexPath.row == 6) {
                    [self.updateTableViewDataSource reloadCellAutomicHeightWithGroupIndex:1 cellIndex:0];
                } else if (indexPath.row == 7) {
                    [self.updateTableViewDataSource reloadCellFixedHeight:280 groupIndex:1 cellIndex:0];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }];
    }];
    [self.tableViewDataSource reloadTableViewData];
}

@end
