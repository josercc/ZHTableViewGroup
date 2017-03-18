//
//  ZHTableViewGroup.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewGroup.h"

@interface ZHTableViewGroup ()

@property (nonatomic, strong) NSMutableArray<ZHTableViewCell *> *cells;

@end

@implementation ZHTableViewGroup

- (void)registerHeaderFooterCellWithTableView:(UITableView *)tableView {
    if (self.header && self.header.identifier) {
        [tableView registerClass:self.header.anyClass forHeaderFooterViewReuseIdentifier:self.header.identifier];
    }
    if (self.footer && self.footer.identifier) {
        [tableView registerClass:self.footer.anyClass forHeaderFooterViewReuseIdentifier:self.footer.identifier];
    }
    for (ZHTableViewCell *tableViewCell in self.cells) {
        if (tableViewCell.identifier) {
            [tableView registerClass:tableViewCell.anyClass forCellReuseIdentifier:tableViewCell.identifier];
        }
    }
}

- (void)addCellWithCompletionHandle:(ZHTableViewGroupAddCellCompletionHandle)completionHandle {
    ZHTableViewCell *cell = [[ZHTableViewCell alloc] init];
    if (completionHandle) {
        completionHandle(cell);
    }
    [self.cells addObject:cell];
}

- (void)addHeaderWithCompletionHandle:(ZHTableViewGroupAddHeaderFooterCompletionHandle)completionHandle {
    ZHTableViewHeaderFooter *header= [[ZHTableViewHeaderFooter alloc] initWithStyle:ZHTableViewHeaderFooterStyleHeader];
    if (completionHandle) {
        completionHandle(header);
    }
    _header = header;
}

- (void)addFooterWithCompletionHandle:(ZHTableViewGroupAddHeaderFooterCompletionHandle)completionHandle {
    ZHTableViewHeaderFooter *footer = [[ZHTableViewHeaderFooter alloc] initWithStyle:ZHTableViewHeaderFooterStyleFooter];
    if (completionHandle) {
        completionHandle(footer);
    }
    _footer = footer;
}

- (UITableViewCell *)cellForTableViewWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (!tableView) {
        return nil;
    }
    ZHTableViewCell *tableViewCell = [self tableViewCellForIndexPath:indexPath];
    if (!tableViewCell) {
        return nil;
    }
    if (!tableViewCell.identifier) {
        return nil;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell.identifier];
    [tableViewCell configCellWithCell:cell indexPath:indexPath];
    return cell;
}

- (ZHTableViewCell *)tableViewCellForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.cellCount) {
        return nil;
    }
    NSInteger count = 0;
    ZHTableViewCell *tableViewCell;
    for (ZHTableViewCell *cell in self.cells) {
        count += cell.cellNumber;
        if (indexPath.row < count) {
            tableViewCell = cell;
            break;
        }
    }
    return tableViewCell;
}

- (UITableViewHeaderFooterView *)headerFooterForStyle:(ZHTableViewHeaderFooterStyle)style tableView:(UITableView *)tableView {
    if (!tableView) {
        return nil;
    }
    ZHTableViewHeaderFooter *headerFooter;
    switch (style) {
        case ZHTableViewHeaderFooterStyleHeader: {
            headerFooter = self.header;
        }
            break;
        case ZHTableViewHeaderFooterStyleFooter: {
            headerFooter = self.footer;
        }
            break;
    }
    if (!headerFooter) {
        return nil;
    }
    if (!headerFooter.identifier) {
        return nil;
    }
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerFooter.identifier];
}


- (NSMutableArray<ZHTableViewCell *> *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}

- (NSInteger)cellCount {
    NSInteger count = 0;
    for (ZHTableViewCell *tableViewCell in self.cells) {
        count += tableViewCell.cellNumber;
    }
    return count;
}

@end
