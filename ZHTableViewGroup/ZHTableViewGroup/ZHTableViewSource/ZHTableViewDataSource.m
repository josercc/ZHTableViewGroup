//
//  ZHTableViewDataSource.m
//  GearBest
//
//  Created by 张行 on 16/8/31.
//  Copyright © 2016年 GearBest. All rights reserved.
//

#import "ZHTableViewDataSource.h"

@interface ZHTableViewDataSource ()

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation ZHTableViewDataSource

- (void)addTableViewGroup:(ZHTableViewGroup *)group {
    NSParameterAssert(group);
    [self.groups addObject:group];
}

- (ZHTableViewGroup *)groupWithIndex:(NSUInteger)index {
    if (self.groups.count > index) {
        return self.groups[index];
    }
    return nil;
}

- (void)clearData {
    [self.groups removeAllObjects];
}

#pragma mark - GET
- (NSMutableArray *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (NSUInteger)sectionNumber {
    return self.groups.count;
}

@end
