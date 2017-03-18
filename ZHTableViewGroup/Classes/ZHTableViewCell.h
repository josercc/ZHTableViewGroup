//
//  ZHTableViewCell.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewBaseModel.h"

typedef void(^ZHTableViewCellCompletionHandle)(UITableViewCell *cell, NSIndexPath *indexPath);

@interface ZHTableViewCell : ZHTableViewBaseModel

@property (nonatomic, assign) NSInteger cellNumber;
@property (nonatomic, copy, readonly) ZHTableViewCellCompletionHandle configCompletionHandle;
@property (nonatomic, copy, readonly) ZHTableViewCellCompletionHandle didSelectRowCompletionHandle;

- (void)didSelectRowAtWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

- (void)configCellWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

- (void)setConfigCompletionHandle:(ZHTableViewCellCompletionHandle)configCompletionHandle;

- (void)setDidSelectRowCompletionHandle:(ZHTableViewCellCompletionHandle)didSelectRowCompletionHandle;

@end
