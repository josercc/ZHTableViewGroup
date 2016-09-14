//
//  ZHTableViewCell.m
//  GearBest
//
//  Created by 张行 on 16/8/31.
//  Copyright © 2016年 GearBest. All rights reserved.
//

#import "ZHTableViewCell.h"

@implementation ZHTableViewCell {
    UITableView *_tableView;
}

- (instancetype)initWithTableView:(UITableView *)tableView range:(NSRange)range cellHeight:(CGFloat)cellHeight cellClass:(Class)cellClass identifier:(NSString *)identifier {
    if (self = [super init]) {
        NSParameterAssert(tableView);
        NSParameterAssert(identifier);
        _tableView = tableView;
        NSDictionary *cellClassDict = [tableView valueForKey:@"_cellClassDict"];
        __block BOOL isExitRegister = NO;
        [cellClassDict.allKeys enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:identifier]) {
                isExitRegister = YES;
            }
        }];
        if (!isExitRegister) {
            [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
        }
        _range = range;
        _cellHeight = cellHeight;
        _identifier = identifier;
    }
    return self;
}

- (BOOL)cellIsExitRangeWithIndex:(NSUInteger)index {
    return NSLocationInRange(index,_range);
}

- (UITableViewCell *)cellWithIndexPath:(NSIndexPath *)indexPath {
    return [_tableView dequeueReusableCellWithIdentifier:_identifier forIndexPath:indexPath];
}

@end
