//
//  ZHTableViewDataSource.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewDataSource.h"
#import "ZHAutoConfigurationTableViewDelegate.h"

@interface ZHTableViewDataSource ()

@property (nonatomic, strong) NSMutableArray<ZHTableViewGroup *> *groups;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZHAutoConfigurationTableViewDelegate *autoConfiguration;

@end

@implementation ZHTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        _tableView = tableView;
        self.autoConfigurationTableViewDelegate = YES;
    }
    return self;
}

- (void)setAutoConfigurationTableViewDelegate:(BOOL)autoConfigurationTableViewDelegate {
    _autoConfigurationTableViewDelegate = autoConfigurationTableViewDelegate;
    if (autoConfigurationTableViewDelegate) {
        _tableView.dataSource = self.autoConfiguration;
        _tableView.delegate = self.autoConfiguration;
    }
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

+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                         section:(NSInteger)section {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return 0;
    }
    return group.cellCount;
}

+ (UITableViewCell *)cellForRowAtWithDataSource:(ZHTableViewDataSource *)dataSource
                                      indexPath:(NSIndexPath *)indexPath {
    return [self cellForRowAtWithDataSource:dataSource indexPath:indexPath config:!dataSource.isWillDisplayData];
}

+ (UITableViewCell *)cellForRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath config:(BOOL)config {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (!group) {
        return cell;
    }
    UITableViewCell *resultCell = [group cellForTableViewWithTableView:dataSource.tableView indexPath:indexPath config:config];
    if (!resultCell) {
        return cell;
    }
    return resultCell;
}

+ (NSInteger)numberOfSectionsWithDataSource:(ZHTableViewDataSource *)dataSource {
    if (!dataSource) {
        return 0;
    }
    return dataSource.groups.count;
}

+ (CGFloat)heightForRowAtDataSource:(ZHTableViewDataSource *)dataSource
                          indexPath:(NSIndexPath *)indexPath customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHTableViewCell *cell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!cell) {
        return 0;
    }
    UITableViewCell *automaticHeightCell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
    CGFloat automaticHeight = [automaticHeightCell sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
    if (cell.height == NSNotFound && automaticHeight != CGFLOAT_MAX) {
        cell.height = automaticHeight;
    }
    return [self heightWithCustomHandle:cell.height customCompletionHandle:customHeightCompletionHandle baseModel:cell];
}

+ (void)didSelectRowAtWithDataSource:(ZHTableViewDataSource *)dataSource
                           indexPath:(NSIndexPath *)indexPath {
    
    ZHTableViewCell *tableViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!tableViewCell) {
        return;
    }
    __block UITableViewCell *cell = ({
        cell = nil;
        /* 因为点击的 CELL 一定是在屏幕可见的范围之内 所以直接取 */
        [dataSource.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *visibleIndexPath = [dataSource.tableView indexPathForCell:obj];
            if ([indexPath compare:visibleIndexPath] == NSOrderedSame) {
                cell = obj;
            }
        }];
        cell;
    });
    if (!cell) {
        return;
    }
	ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    [tableViewCell didSelectRowAtWithCell:cell indexPath:[group indexPathWithCell:tableViewCell indexPath:indexPath]];
}

+ (CGFloat)heightForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                          section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHTableViewHeaderFooterStyleHeader customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (CGFloat)heightForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                          section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHTableViewHeaderFooterStyleFooter customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (UITableViewHeaderFooterView *)viewForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHTableViewHeaderFooterStyleHeader];
}

+ (UITableViewHeaderFooterView *)viewForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHTableViewHeaderFooterStyleFooter];
}

- (void)clearData {
    [self.groups removeAllObjects];
}

+ (UITableViewHeaderFooterView *)viewHeaderFooterInSectionWithDtaSource:(ZHTableViewDataSource *)dataSource
                                                                section:(NSInteger)section style:(ZHTableViewHeaderFooterStyle)style {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return nil;
    }
    return [group headerFooterForStyle:style tableView:dataSource.tableView section:section];
}

+ (CGFloat)heightForHeaderFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                                section:(NSInteger)section style:(ZHTableViewHeaderFooterStyle)style
                           customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if(!group) {
        return 0;
    }
    NSInteger height = 0;
    ZHTableViewBaseModel *baseModel;
    UITableViewHeaderFooterView *headFooter = [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:style];
    CGFloat automaticHeight = [headFooter sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
    switch (style) {
        case ZHTableViewHeaderFooterStyleHeader: {
            height = group.header.height;
            baseModel = group.header;
            
        }
            break;
        case  ZHTableViewHeaderFooterStyleFooter: {
            height = group.footer.height;
            baseModel = group.footer;
        }
            break;
    }
    if (height == NSNotFound && automaticHeight != CGFLOAT_MAX) {
        height = automaticHeight;
    }
    return [self heightWithCustomHandle:height customCompletionHandle:customHeightCompletionHandle baseModel:baseModel];
}

+ (CGFloat)heightWithCustomHandle:(CGFloat)height
           customCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customCompletionHandle
                        baseModel:(ZHTableViewBaseModel *)baseModel {
	if (customCompletionHandle) {
		return customCompletionHandle(baseModel);
	}
	if (height != 0) {
		return height;
	}
    return 44;
}


+ (ZHTableViewGroup *)groupForSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                            section:(NSInteger)section {
    if (!dataSource) {
        return nil;
    }
    if (dataSource.groups.count <= section) {
        return nil;
    }
    return  dataSource.groups[section];
}

+ (ZHTableViewCell *)cellForIndexPath:(ZHTableViewDataSource *)dataSource
                            indexPath:(NSIndexPath *)indexPath {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    if (!group) {
        return nil;
    }
    return [group tableViewCellForIndexPath:indexPath];
}

+ (NSIndexPath *)indexPathWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
	ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
	ZHTableViewCell *tableViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
	return [group indexPathWithCell:tableViewCell indexPath:indexPath];
}

+ (void)dataSource:(ZHTableViewDataSource *)dataSource
   willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!dataSource.isWillDisplayData) {
        return;
    }
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource
                                                          section:indexPath.section];
    ZHTableViewCell *tableViewCell = [self cellForIndexPath:dataSource
                                                  indexPath:indexPath];
    [group tableViewCell:tableViewCell
              configCell:cell
             atIndexPath:indexPath];
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

- (ZHAutoConfigurationTableViewDelegate *)autoConfiguration {
    if (!_autoConfiguration) {
        _autoConfiguration = [[ZHAutoConfigurationTableViewDelegate alloc] initWithDataSource:self];
    }
    return _autoConfiguration;
}

@end
