//
//  ZHCollectionViewDataSource.m
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import "ZHCollectionViewDataSource.h"
#import "ZHAutoConfigurationCollectionViewDelegate.h"

@interface ZHCollectionViewDataSource ()

@property (nonatomic, strong) NSMutableArray<ZHCollectionViewGroup *> *groups;
@property (nonatomic, strong) UICollectionView *CollectionView;
@property (nonatomic, strong) ZHAutoConfigurationCollectionViewDelegate *autoConfiguration;

@end

@implementation ZHCollectionViewDataSource

- (instancetype)initWithCollectionView:(UICollectionView *)CollectionView {
    if (self = [super init]) {
        _CollectionView = CollectionView;
        self.autoConfigurationCollectionViewDelegate = YES;
    }
    return self;
}

- (void)setAutoConfigurationCollectionViewDelegate:(BOOL)autoConfigurationCollectionViewDelegate {
    _autoConfigurationCollectionViewDelegate = autoConfigurationCollectionViewDelegate;
    if (autoConfigurationCollectionViewDelegate) {
        _CollectionView.dataSource = self.autoConfiguration;
        _CollectionView.delegate = self.autoConfiguration;
    }
}

- (void)addGroupWithCompletionHandle:(ZHCollectionViewDataSourceAddGroupCompletionHandle)completionHandle {
    ZHCollectionViewGroup *group = [[ZHCollectionViewGroup alloc] init];
    if (completionHandle) {
        completionHandle(group);
    }
    [self.groups addObject:group];
}

- (void)reloadCollectionViewData {
    [self registerClasss];
    [self.CollectionView reloadData];
}

+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                         section:(NSInteger)section {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return 0;
    }
    return group.cellCount;
}

+ (UICollectionViewCell *)cellForRowAtWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                      indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] initWithFrame:CGRectZero];
    if (!group) {
        return cell;
    }
    UICollectionViewCell *resultCell = [group cellForCollectionViewWithCollectionView:dataSource.CollectionView indexPath:indexPath];
    if (!resultCell) {
        return cell;
    }
    return resultCell;
}

+ (NSInteger)numberOfSectionsWithDataSource:(ZHCollectionViewDataSource *)dataSource {
    if (!dataSource) {
        return 0;
    }
    return dataSource.groups.count;
}

+ (CGFloat)heightForRowAtDataSource:(ZHCollectionViewDataSource *)dataSource
                          indexPath:(NSIndexPath *)indexPath customHeightCompletionHandle:(ZHCollectionViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHCollectionViewCell *cell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!cell) {
        return 0;
    }
    UICollectionViewCell *automaticHeightCell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
    CGFloat automaticHeight = [automaticHeightCell sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
    if (cell.height == NSNotFound && automaticHeight != CGFLOAT_MAX) {
        cell.height = automaticHeight;
    }
    return [self heightWithCustomHandle:cell.height customCompletionHandle:customHeightCompletionHandle baseModel:cell];
}

+ (void)didSelectRowAtWithDataSource:(ZHCollectionViewDataSource *)dataSource
                           indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewCell *CollectionViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!CollectionViewCell) {
        return;
    }
    UICollectionViewCell *cell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    [CollectionViewCell didSelectRowAtWithCell:cell indexPath:[group indexPathWithCell:CollectionViewCell indexPath:indexPath]];
}

+ (CGFloat)heightForHeaderInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                          section:(NSInteger)section customHeightCompletionHandle:(ZHCollectionViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHCollectionViewHeaderFooterStyleHeader customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (CGFloat)heightForFooterInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                          section:(NSInteger)section customHeightCompletionHandle:(ZHCollectionViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHCollectionViewHeaderFooterStyleFooter customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (UICollectionReusableView *)viewForHeaderInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHCollectionViewHeaderFooterStyleHeader];
}

+ (UICollectionReusableView *)viewForFooterInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHCollectionViewHeaderFooterStyleFooter];
}

- (void)clearData {
    [self.groups removeAllObjects];
}

+ (UICollectionReusableView *)viewHeaderFooterInSectionWithDtaSource:(ZHCollectionViewDataSource *)dataSource
                                                                section:(NSInteger)section style:(ZHCollectionViewHeaderFooterStyle)style {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return nil;
    }
    return [group headerFooterForStyle:style CollectionView:dataSource.CollectionView section:section];
}

+ (CGFloat)heightForHeaderFooterInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                                section:(NSInteger)section style:(ZHCollectionViewHeaderFooterStyle)style
                           customHeightCompletionHandle:(ZHCollectionViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if(!group) {
        return 0;
    }
    NSInteger height = 0;
    ZHCollectionViewBaseModel *baseModel;
    UICollectionReusableView *headFooter = [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:style];
    CGFloat automaticHeight = [headFooter sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
    switch (style) {
        case ZHCollectionViewHeaderFooterStyleHeader: {
            height = group.header.height;
            baseModel = group.header;
            
        }
            break;
        case  ZHCollectionViewHeaderFooterStyleFooter: {
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
           customCompletionHandle:(ZHCollectionViewDataSourceCustomHeightCompletionHandle)customCompletionHandle
                        baseModel:(ZHCollectionViewBaseModel *)baseModel {
    if (customCompletionHandle) {
        return customCompletionHandle(baseModel);
    }
    if (height != 0) {
        return height;
    }
    return 44;
}


+ (ZHCollectionViewGroup *)groupForSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                            section:(NSInteger)section {
    if (!dataSource) {
        return nil;
    }
    if (dataSource.groups.count <= section) {
        return nil;
    }
    return  dataSource.groups[section];
}

+ (ZHCollectionViewCell *)cellForIndexPath:(ZHCollectionViewDataSource *)dataSource
                            indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    if (!group) {
        return nil;
    }
    return [group CollectionViewCellForIndexPath:indexPath];
}

+ (NSIndexPath *)indexPathWithDataSource:(ZHCollectionViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    ZHCollectionViewCell *CollectionViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
    return [group indexPathWithCell:CollectionViewCell indexPath:indexPath];
}

- (void)registerClasss {
    for (ZHCollectionViewGroup *group in self.groups) {
        [group registerHeaderFooterCellWithCollectionView:self.CollectionView];
    }
}

- (NSMutableArray<ZHCollectionViewGroup *> *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (ZHAutoConfigurationCollectionViewDelegate *)autoConfiguration {
    if (!_autoConfiguration) {
        _autoConfiguration = [[ZHAutoConfigurationCollectionViewDelegate alloc] initWithDataSource:self];
    }
    return _autoConfiguration;
}

@end

