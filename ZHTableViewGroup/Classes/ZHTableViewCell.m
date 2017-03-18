//
//  ZHTableViewCell.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewCell.h"

@implementation ZHTableViewCell {
}

- (instancetype)init {
    if (self = [super init]) {
        _cellNumber = 0;
    }
    return self;
}

- (void)didSelectRowAtWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (!self.didSelectRowCompletionHandle) {
        return;
    }
    self.didSelectRowCompletionHandle(cell,indexPath);
}

- (void)configCellWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (!self.configCompletionHandle) {
        return;
    }
    self.configCompletionHandle(cell,indexPath);
}

- (void)setConfigCompletionHandle:(ZHTableViewCellCompletionHandle)configCompletionHandle {
    _configCompletionHandle = configCompletionHandle;
}

- (void)setDidSelectRowCompletionHandle:(ZHTableViewCellCompletionHandle)didSelectRowCompletionHandle {
    _didSelectRowCompletionHandle = didSelectRowCompletionHandle;
}

@end
