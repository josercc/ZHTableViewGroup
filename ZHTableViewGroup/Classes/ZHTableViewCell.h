//
//  ZHTableViewCell.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewBaseModel.h"

typedef void(^ZHTableViewCellCompletionHandle)(UITableViewCell *cell, NSIndexPath *indexPath);

/**
 注册 Cell 样式
 */
@interface ZHTableViewCell : ZHTableViewBaseModel

/**
  Cell 的个数 默认为1
 */
@property (nonatomic, assign) NSInteger cellNumber;
/**
 配置 Cell的回调
 */
@property (nonatomic, copy) ZHTableViewCellCompletionHandle configCompletionHandle;
/**
  点击 Cell 的回调
 */
@property (nonatomic, copy) ZHTableViewCellCompletionHandle didSelectRowCompletionHandle;

/**
 点击所在的 Cell 的执行方法

 @param cell 点击的 Cell
 @param indexPath 点击 cell 所在的索引
 */
- (void)didSelectRowAtWithCell:(UITableViewCell *)cell
                     indexPath:(NSIndexPath *)indexPath;

/**
  配置 Cell 的执行方法

 @param cell 配置的 Cell
 @param indexPath 配置 Cell 所在的索引
 */
- (void)configCellWithCell:(UITableViewCell *)cell
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
                 configCompletionHandle:(ZHTableViewCellCompletionHandle)configCompletionHandle
           didSelectRowCompletionHandle:(ZHTableViewCellCompletionHandle)didSelectRowCompletionHandle;

@end
