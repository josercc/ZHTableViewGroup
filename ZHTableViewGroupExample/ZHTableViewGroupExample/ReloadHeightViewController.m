//
//  ReloadHeightViewController.m
//  ZHTableViewGroupObjc
//
//  Created by josercc on 2020/2/25.
//  Copyright © 2020 josercc. All rights reserved.
//

#import "ReloadHeightViewController.h"
#import <ZHTableViewGroupObjc/ZHTableViewGroupObjc.h>
#import "SetHeightViewController.h"

@interface ReloadHeightViewController ()


@end

@implementation ReloadHeightViewController {
    __block ZHTableViewCell *_weakCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableViewDataSource clearData];
    [self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        [group addCellWithCompletionHandle:^(ZHTableViewCell<ReloadHeightCell1 *> *cell) {
            self->_weakCell = cell;
            cell.anyClass = [ReloadHeightCell1 class];
            cell.identifier = @"ReloadHeightCell1";
            [cell setConfigCompletionHandle:^(ReloadHeightCell1 *cell1, NSIndexPath *indexPath) {
                cell1.textLabel.text = @"ReloadHeightCell1";
            }];
        }];
    }];
    [self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        [group addCellWithCompletionHandle:^(ZHTableViewCell<ReloadHeightCell2 *> *cell) {
            cell.anyClass = [ReloadHeightCell2 class];
            cell.identifier = @"ReloadHeightCell2";
            cell.cellNumber = 2;
            [cell setConfigCompletionHandle:^(ReloadHeightCell2 *cell1, NSIndexPath *indexPath) {
                cell1.textLabel.text = @"ReloadHeightCell2";
            }];
        }];
    }];
    [self.tableViewDataSource reloadTableViewData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新高度"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(reloadHeight)];
}

- (void)reloadHeight {
    SetHeightViewController *controller = [[SetHeightViewController alloc] initWithNibName:nil bundle:nil];
    controller.updateTableViewDataSource = self.tableViewDataSource;
    [self presentViewController:controller animated:YES completion:nil];
}


@end

@implementation ReloadHeightCell1

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, 85);
}

@end

@implementation ReloadHeightCell2

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, 105);
}

@end
