//
//  ZHTableViewDataSource.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewDataSource.h"

@interface ZHTableViewDataSource ()

@property (nonatomic, strong) NSMutableArray<ZHTableViewGroup *> *groups;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZHTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        _tableView = tableView;
    }
    return self;
}

- (void)addGroupWithCompletionHandle:(ZHTableViewDataSourceAddGroupCompletionHandle)completionHandle {
    ZHTableViewGroup *group = [[ZHTableViewGroup alloc] init];
    if (completionHandle) {
        completionHandle(group);
    }
    [self.groups addObject:group];
}

- (void)reloadTableViewData {
    [self registerClasss];
    [self.tableView reloadData];
}

+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return 0;
    }
    return group.cellCount;
}

+ (UITableViewCell *)cellForRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (!group) {
        return cell;
    }
    UITableViewCell *resultCell = [group cellForTableViewWithTableView:dataSource.tableView indexPath:indexPath];
    if (!resultCell) {
        return cell;
    }
    return resultCell;
}

+ (NSInteger)numberOfSectionsWithDataSource:(ZHTableViewDataSource *)dataSource {
    if (!dataSource) {
        return nil;
    }
    return dataSource.groups.count;
}

+ (CGFloat)heightForRowAtDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHTableViewCell *cell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!cell) {
        return 0;
    }
    return [self heightWithCustomHandle:cell.height customCompletionHandle:customHeightCompletionHandle];
}

+ (void)didSelectRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
    ZHTableViewCell *tableViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!tableViewCell) {
        return;
    }
    UITableViewCell *cell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
    [tableViewCell didSelectRowAtWithCell:cell indexPath:indexPath];
}

+ (CGFloat)heightForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHTableViewHeaderFooterStyleHeader customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (CGFloat)heightForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHTableViewHeaderFooterStyleFooter customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (UITableViewHeaderFooterView *)viewForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHTableViewHeaderFooterStyleHeader];
}

+ (UITableViewHeaderFooterView *)viewForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHTableViewHeaderFooterStyleFooter];
}

- (void)clearData {
    [self.groups removeAllObjects];
}

+ (UITableViewHeaderFooterView *)viewHeaderFooterInSectionWithDtaSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section style:(ZHTableViewHeaderFooterStyle)style {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return nil;
    }
    return [group headerFooterForStyle:style tableView:dataSource.tableView];
}

+ (CGFloat)heightForHeaderFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section style:(ZHTableViewHeaderFooterStyle)style  customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if(!group) {
        return 0;
    }
    NSInteger height = 0;
    switch (style) {
        case ZHTableViewHeaderFooterStyleHeader: {
            height = group.header.height;
        }
            break;
        case  ZHTableViewHeaderFooterStyleFooter: {
            height = group.footer.height;
        }
            break;
    }
    return [self heightWithCustomHandle:height customCompletionHandle:customHeightCompletionHandle];
}

+ (CGFloat)heightWithCustomHandle:(CGFloat)height customCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customCompletionHandle {
    if (height == NSNotFound) {
        if (customCompletionHandle) {
            return customCompletionHandle();
        }
        return 0;
    }
    return height;
}


+ (ZHTableViewGroup *)groupForSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section {
    if (!dataSource) {
        return nil;
    }
    if (dataSource.groups <= section) {
        return nil;
    }
    return  dataSource.groups[section];
}

+ (ZHTableViewCell *)cellForIndexPath:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    if (!group) {
        return nil;
    }
    return [group tableViewCellForIndexPath:indexPath];
}

- (void)registerClasss {
    for (ZHTableViewGroup *group in self.groups) {
        [group registerHeaderFooterCellWithTableView:self.tableView];
    }
}

- (NSMutableArray<ZHTableViewGroup *> *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

@end
