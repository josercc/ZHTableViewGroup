//
//  ZHTableViewGroup.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import <Foundation/Foundation.h>
#import "ZHTableViewHeaderFooter.h"
#import "ZHTableViewCell.h"

typedef void(^ZHTableViewGroupAddCellCompletionHandle)(ZHTableViewCell *cell);
typedef void(^ZHTableViewGroupAddHeaderFooterCompletionHandle)(ZHTableViewHeaderFooter *headerFooter);

@interface ZHTableViewGroup : NSObject

@property (nonatomic, strong) ZHTableViewHeaderFooter *header;
@property (nonatomic, strong) ZHTableViewHeaderFooter *footer;
@property (nonatomic, assign, readonly) NSInteger cellCount;

- (void)registerHeaderFooterCellWithTableView:(UITableView *)tableView;

- (UITableViewCell *)cellForTableViewWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)addCellWithCompletionHandle:(ZHTableViewGroupAddCellCompletionHandle)completionHandle;

- (void)addHeaderWithCompletionHandle:(ZHTableViewGroupAddHeaderFooterCompletionHandle)completionHandle;

- (void)addFooterWithCompletionHandle:(ZHTableViewGroupAddHeaderFooterCompletionHandle)completionHandle;

- (ZHTableViewCell *)tableViewCellForIndexPath:(NSIndexPath *)indexPath;

- (UITableViewHeaderFooterView *)headerFooterForStyle:(ZHTableViewHeaderFooterStyle)style tableView:(UITableView *)tableView;

@end
