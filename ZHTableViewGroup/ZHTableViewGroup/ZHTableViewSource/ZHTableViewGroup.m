//
//  GBTableGroup.m
//  GearBest
//
//  Created by 张行 on 16/8/31.
//  Copyright © 2016年 GearBest. All rights reserved.
//

#import "ZHTableViewGroup.h"

@interface ZHTableViewGroup ()
@property (nonatomic, strong) NSMutableArray *cells;
@end

@implementation ZHTableViewGroup

- (void)addTableViewCell:(ZHTableViewCell *)cell {
    NSParameterAssert(cell);
    if (cell) {
        [self.cells addObject:cell];
    }
}

- (CGFloat)heightWithIndex:(NSInteger)index {
    ZHTableViewCell *cell = [self cellWithIndex:index];
    if (cell) {
        return cell.cellHeight;
    }
    return 0;
}

- (NSString *)identifierWithIndex:(NSInteger)index {
    ZHTableViewCell *cell = [self cellWithIndex:index];
    if (cell) {
        return cell.identifier;
    }
    return nil;
}

- (UITableViewCell *)cellWithIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewCell *cell = [self cellWithIndex:indexPath.row];
    if (cell) {
        UITableViewCell *tableViewCell = [cell cellWithIndexPath:indexPath];
        if (cell.configCellComplete) {
            cell.configCellComplete(tableViewCell,indexPath);
        }
        return tableViewCell;
    }
    return nil;
}

- (void)configCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewCell *tableViewCell = [self cellWithIndex:indexPath.row];
    if (tableViewCell.configCellComplete) {
        tableViewCell.configCellComplete(cell,indexPath);
    }
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewCell *tableViewCell = [self cellWithIndex:indexPath.row];
    UITableViewCell *cell = [self cellWithIndexPath:indexPath];
    if (tableViewCell.didSelectRowComplete) {
        tableViewCell.didSelectRowComplete(cell,indexPath);
    }
}

- (ZHTableViewCell *)cellWithIndex:(NSUInteger)index {
    __block ZHTableViewCell *cell;
    [self.cells enumerateObjectsUsingBlock:^(ZHTableViewCell *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj cellIsExitRangeWithIndex:index]) {
            cell = obj;
        }
    }];

    return cell;
}

#pragma mark - GET
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}

- (NSUInteger)rowNumber {
    __block NSUInteger number = 0;
    [self.cells enumerateObjectsUsingBlock:^(ZHTableViewCell *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        number += obj.range.length;
    }];
    return number;
}

@end
