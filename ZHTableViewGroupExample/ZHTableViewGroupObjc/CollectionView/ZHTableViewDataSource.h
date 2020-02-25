//
//  ZHTableViewDataSource.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import <Foundation/Foundation.h>
#import "ZHTableViewGroup.h"
#import "ZHAutoConfigurationTableViewDelegate.h"

/**
  添加分组的回调

 @param group 创建的分组对象
 */
typedef void(^ZHTableViewDataSourceAddGroupCompletionHandle)(ZHTableViewGroup *group);

/**
  自定义高度的回调

 @return 自定义算法返回的高度
 */
typedef CGFloat (^ZHTableViewDataSourceCustomHeightCompletionHandle)(ZHTableViewBaseModel *model);

/**
  进行 UITableView 进行数据托管的数据源
 */
@interface ZHTableViewDataSource : NSObject

/**
 自动配置 UITableView 的 DataSource 和 Delegate 默认为 YES
 */
@property (nonatomic, assign, getter=isAutoConfigurationTableViewDelegate) BOOL autoConfigurationTableViewDelegate;

/**
 * 是否开启即将展示 复制数据 默认为 NO
 */
@property (nonatomic, assign) BOOL isWillDisplayData;
/**
 添加优先级 如果 YES 启用新的优先级 先判断设置的高度 没有获取自定义 Block 的高度 其次是自动计算高度
 */
@property (nonatomic, assign) BOOL priorityHeight;

@property (nonatomic, strong, readonly) NSMutableArray<ZHTableViewGroup *> *groups;

/**
 唯一的初始化ZHTableViewDataSource

 @param tableView 托管的 UITableView 的对象 必须存在
 @return ZHTableViewDataSource的对象
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
  添加一个分组

 @param completionHandle 返回新注册的分组对象 可以进行配置
 */
- (void)addGroupWithCompletionHandle:(ZHTableViewDataSourceAddGroupCompletionHandle)completionHandle;

- (void)registerClass;

/**
  进行刷新 UITableView
 */
- (void)reloadTableViewData;

/**
 获取分组Cell的个数 如果autoConfigurationTableViewDelegate = YES 此方法不用调用

 @param dataSource ZHTableViewDataSource数据源
 @param section 所在组索引
 @return 分组 Cell 的个数
 */
+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section;

/**
 获取对应索引的UITableViewCell 如果autoConfigurationTableViewDelegate = YES 此方法不用调用

 @param dataSource ZHTableViewDataSource数据源
 @param indexPath 所在的索引
 @return UITableViewCell
 */
+ (UITableViewCell *)cellForRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

/**
 获取分组的个数 如果autoConfigurationTableViewDelegate = YES 此方法不用调用

 @param dataSource ZHTableViewDataSource的数据源
 @return 分组的个数
 */
+ (NSInteger)numberOfSectionsWithDataSource:(ZHTableViewDataSource *)dataSource;

/**
 获取Cell 所在索引的高度 如果autoConfigurationTableViewDelegate = YES 此方法不用调用

 @param dataSource ZHTableViewDataSource数据源
 @param indexPath 索引
 @param customHeightCompletionHandle 自定义高度回调 实现 ZHTableViewCell 属性 cellHeight 无效
 @return  Cell 的高度
 */
+ (CGFloat)heightForRowAtDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle;

/**
 点击 Cell 的回调

 @param dataSource ZHTableViewDataSource数据源
 @param indexPath 点击的索引
 */
+ (void)didSelectRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

/**
 获取 Header 的高度

 @param dataSource ZHTableViewDataSource数据源
 @param section 分组索引
 @param customHeightCompletionHandle 自定义高度回调
 @return 分组 Header 高度
 */
+ (CGFloat)heightForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle;

/**
 获取 Footer 的高度

 @param dataSource ZHTableViewDataSource数据源
 @param section 分组索引
 @param customHeightCompletionHandle 自定义高度回调
 @return 分组 Footer 高度
 */
+ (CGFloat)heightForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle;

/**
 获取Header

 @param dataSource ZHTableViewDataSource数据源
 @param section 分组的索引
 @return 分组 Header 试图
 */
+ (UITableViewHeaderFooterView *)viewForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section;
/**
 获取Footer

 @param dataSource ZHTableViewDataSource数据源
 @param section 分组的索引
 @return 分组 Footer 试图
 */
+ (UITableViewHeaderFooterView *)viewForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource section:(NSInteger)section;

/**
  清空之前数据
 */
- (void)clearData;

+ (NSIndexPath *)indexPathWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

+ (void)dataSource:(ZHTableViewDataSource *)dataSource willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, copy) void (^heightForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, CGFloat height);
@property (nonatomic, copy) void (^heightForHeaderInSection)(UITableView *tableView, NSUInteger section, CGFloat height);
@property (nonatomic, copy) void (^heightForFooterInSection)(UITableView *tableView, NSUInteger section, CGFloat height);
#pragma mark - Delegate Block
/* UITableView 滑动, scrollViewDidScroll的代理 */
@property (nonatomic, copy) void (^scrollViewDidScrollCompletionHandle)(UIScrollView *scrollView);
/* UITableView 滑动,scrollViewWillBeginDragging的代理 */
@property (nonatomic, copy) void (^scrollViewWillBeginDraggingCompletionHandle)(UIScrollView *scrollView);


@end

@interface ZHTableViewDataSource (ReloadHeight)

/// 根据标识符刷新自动计算高度
/// @param identifier 标识符
- (void)reloadCellAutomaticHeightWithIdentifier:(NSString *)identifier;
/// 根据标识符刷新固定高度
/// @param height 固定高度
/// @param identifier 标识符
- (void)reloadCellFixedHeight:(CGFloat)height
                   identifier:(NSString *)identifier;

/// 根据类类型刷新自动计算高度
/// @param className 类类型
- (void)reloadCellAutomaticHeightWithClass:(Class)className;
/// 根据类类型刷新固定高度
/// @param height 固定高度
/// @param className 类类型
- (void)reloadCellFixedHeight:(CGFloat)height
                    className:(Class)className;

/// 根据指定的`ZHTableViewCell`刷新自动计算高度
/// @param tableViewCell 指定的`ZHTableViewCell`
- (void)reloadCellAutomaticHeightWithTableViewCell:(ZHTableViewCell *)tableViewCell;
/// 根据指定的`ZHTableViewCell`刷新固定高度
/// @param height 固定的高度
/// @param tableViewCell 指定的`ZHTableViewCell`
- (void)reloadCellFixedHeight:(NSInteger)height
                tableViewCell:(ZHTableViewCell *)tableViewCell;

/// 根据对应分组个对应的`ZHTableViewCell`索引更新自动高度
/// @param groupIndex 分组的索引
/// @param cellIndex 对应的`ZHTableViewCell`索引
- (void)reloadCellAutomicHeightWithGroupIndex:(NSUInteger)groupIndex
                                    cellIndex:(NSUInteger)cellIndex;
/// 根据对应分组个对应的`ZHTableViewCell`索引更新固定高度
/// @param height 固定高度
/// @param groupIndex 分组的索引
/// @param cellIndex 对应的`ZHTableViewCell`索引
- (void)reloadCellFixedHeight:(CGFloat)height
                   groupIndex:(NSUInteger)groupIndex
                    cellIndex:(NSUInteger)cellIndex;

@end
