//
//  ZHTableViewDataSource.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import <Foundation/Foundation.h>
#import "ZHTableViewGroup.h"

typedef void(^ZHTableViewDataSourceAddGroupCompletionHandle)(ZHTableViewGroup *group);
typedef CGFloat (^ZHTableViewDataSourceCustomHeightCompletionHandle)();

@interface ZHTableViewDataSource : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)addGroupWithCompletionHandle:(ZHTableViewDataSourceAddGroupCompletionHandle)completionHandle;

- (void)reloadTableViewData;

+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section;

+ (UITableViewCell *)cellForRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

+ (NSInteger)numberOfSectionsWithDataSource:(ZHTableViewDataSource *)dataSource;

+ (CGFloat)heightForRowAtDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle;

+ (void)didSelectRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

+ (CGFloat)heightForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle;

+ (CGFloat)heightForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle;

+ (UITableViewHeaderFooterView *)viewForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section;

+ (UITableViewHeaderFooterView *)viewForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section;

- (void)clearData;

@end
