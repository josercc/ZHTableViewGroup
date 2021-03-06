//
//  ZHTableViewCell.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewBaseModel.h"

/**
 注册 Cell 样式
 */
@interface ZHTableViewCell<CellType:UITableViewCell *> : ZHTableViewBaseModel

/**
  Cell 的个数 默认为1
 */
@property (nonatomic, assign) NSInteger cellNumber;
/**
 配置 Cell的回调
 */
@property (nonatomic, copy) void(^configCompletionHandle)(CellType cell, NSIndexPath *indexPath);
/**
  点击 Cell 的回调
 */
@property (nonatomic, copy) void(^didSelectRowCompletionHandle)(CellType cell, NSIndexPath *indexPath);

@property (nonatomic, copy) CGFloat(^customHeightBlock)(CellType cell, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL(^hiddenBlock)(NSIndexPath *indexPath);

/// 为指定的索引设置是否隐藏
/// @param hidden 是否隐藏
/// @param indexPath 指定索引
- (void)setHidden:(BOOL)hidden
        indexPath:(NSIndexPath *)indexPath;

/// 获取指定的索引已经显示内容是否隐藏 如果不存在默认位显示
/// @param indexPath 指定的索引
- (BOOL)isHiddenDisplayWithIndexPath:(NSIndexPath *)indexPath;

/// 获取最新当前索引是否隐藏
/// @param indexPath 指定索引
- (BOOL)isHiddenWithIndexPath:(NSIndexPath *)indexPath;
/**
 * 为了是支持泛型

 @param configCompletionHandle 设置的Block
 */
- (void)setConfigCompletionHandle:(void (^)(CellType cell, NSIndexPath * indexPath))configCompletionHandle;

/**
 * 为了支持泛型

 @param didSelectRowCompletionHandle 点击回调的block
 */
- (void)setDidSelectRowCompletionHandle:(void (^)(CellType cell, NSIndexPath * indexPath))didSelectRowCompletionHandle;

/**
 点击所在的 Cell 的执行方法

 @param cell 点击的 Cell
 @param indexPath 点击 cell 所在的索引
 */
- (void)didSelectRowAtWithCell:(CellType)cell
                     indexPath:(NSIndexPath *)indexPath;

/**
  配置 Cell 的执行方法

 @param cell 配置的 Cell
 @param indexPath 配置 Cell 所在的索引
 */
- (void)configCellWithCell:(CellType)cell
                 indexPath:(NSIndexPath *)indexPath;

/**
 一个方法配置所有的参数

 @param cellNumber cell 的数量
 @param identifier 标识符
 @param anyClass cell 的类名
 @param height 高度
 @param configCompletionHandle 配置 cell
 @param didSelectRowCompletionHandle 点击 cell 方法
 */
- (void)configurationCellWithCellNumber:(NSUInteger)cellNumber
                             identifier:(NSString *)identifier
                               anyClass:(Class)anyClass
                                 height:(CGFloat)height
configCompletionHandle:(void(^)(CellType cell, NSIndexPath *indexPath))configCompletionHandle
           didSelectRowCompletionHandle:(void(^)(CellType cell, NSIndexPath *indexPath))didSelectRowCompletionHandle;

@end
