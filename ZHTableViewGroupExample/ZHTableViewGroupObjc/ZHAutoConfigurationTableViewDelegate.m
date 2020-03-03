//
//  ZHAutoConfigurationTableViewDelegate.m
//  Pods
//
//  Created by 张行 on 2017/4/20.
//
//

#import "ZHAutoConfigurationTableViewDelegate.h"
#import "ZHTableViewDataSource.h"

@interface ZHAutoConfigurationTableViewDelegate ()

@property (nonatomic, weak) ZHTableViewDataSource *dataSource;

@end

@implementation ZHAutoConfigurationTableViewDelegate

- (instancetype)initWithDataSource:(ZHTableViewDataSource *)dataSource {
    if (self = [super init]) {
        _dataSource = dataSource;
    }
    return self;
}

- (ZHTableViewDataSourceCustomHeightCompletionHandle)completionHandleWithTableView:(UITableView *)tableView
                                                                 heightAtIndexPath:(NSIndexPath *)indexPath {
    return ^CGFloat(ZHTableViewBaseModel *model) {
        if (!model.customHeightCompletionHandle) {
            return model.height;
        }
        NSIndexPath *reallyIndexPath = [ZHTableViewDataSource indexPathWithDataSource:self->_dataSource
                                                                            indexPath:indexPath];
        return model.customHeightCompletionHandle(tableView,reallyIndexPath,model);
    };;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewDataSourceCustomHeightCompletionHandle handle = [self completionHandleWithTableView:tableView
                                                                                 heightAtIndexPath:indexPath];
    CGFloat height = [ZHTableViewDataSource heightForRowAtDataSource:_dataSource
                                                           indexPath:indexPath
                                        customHeightCompletionHandle:handle];
    if (_dataSource.heightForRowAtIndexPath) {
        _dataSource.heightForRowAtIndexPath(tableView, indexPath, height);
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [ZHTableViewDataSource heightForHeaderInSectionWithDataSource:_dataSource
                                                                           section:section
                                                      customHeightCompletionHandle:[self completionHandleWithTableView:tableView
                                                                                                     heightAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                                                                          inSection:section]]];
    if (_dataSource.heightForHeaderInSection) {
        _dataSource.heightForHeaderInSection(tableView, section, height);
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    CGFloat height = [ZHTableViewDataSource heightForFooterInSectionWithDataSource:_dataSource section:section customHeightCompletionHandle:[self completionHandleWithTableView:tableView heightAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]]];
    if (_dataSource.heightForFooterInSection) {
        _dataSource.heightForFooterInSection(tableView, section, height);
    }
    return height;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [ZHTableViewDataSource viewForHeaderInSectionWithDataSource:_dataSource section:section];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [ZHTableViewDataSource viewForFooterInSectionWithDataSource:_dataSource section:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZHTableViewDataSource numberOfRowsInSectionWithDataSource:_dataSource section:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZHTableViewDataSource cellForRowAtWithDataSource:_dataSource indexPath:indexPath];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ZHTableViewDataSource numberOfSectionsWithDataSource:_dataSource];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ZHTableViewDataSource didSelectRowAtWithDataSource:_dataSource indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [ZHTableViewDataSource dataSource:_dataSource willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewDidScrollCompletionHandle) {
        _dataSource.scrollViewDidScrollCompletionHandle(scrollView);
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewDidZoom) {
        _dataSource.scrollViewDidZoom(scrollView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewWillBeginDraggingCompletionHandle) {
        _dataSource.scrollViewWillBeginDraggingCompletionHandle(scrollView);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (_dataSource.scrollViewWillEndDragging) {
        _dataSource.scrollViewWillEndDragging(scrollView, velocity, targetContentOffset);
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_dataSource.scrollViewDidEndDragging) {
        _dataSource.scrollViewDidEndDragging(scrollView, decelerate);
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewWillBeginDecelerating) {
        _dataSource.scrollViewWillBeginDecelerating(scrollView);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewDidEndDecelerating) {
        _dataSource.scrollViewDidEndDecelerating(scrollView);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewDidEndScrollingAnimation) {
        _dataSource.scrollViewDidEndScrollingAnimation(scrollView);
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (_dataSource.viewForZoomingInScrollView) {
        return _dataSource.viewForZoomingInScrollView(scrollView);
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    if (_dataSource.scrollViewWillBeginZooming) {
        _dataSource.scrollViewWillBeginZooming(scrollView,view);
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if (_dataSource.scrollViewDidEndZooming) {
        _dataSource.scrollViewDidEndZooming(scrollView,view,scale);
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewShouldScrollToTop) {
        return _dataSource.scrollViewShouldScrollToTop(scrollView);
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewDidScrollToTop) {
        _dataSource.scrollViewDidScrollToTop(scrollView);
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewDidChangeAdjustedContentInset) {
        _dataSource.scrollViewDidChangeAdjustedContentInset(scrollView);
    }
}

@end
