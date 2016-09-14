//
//  ZHTableViewCell.h
//  GearBest
//
//  Created by 张行 on 16/8/31.
//  Copyright © 2016年 GearBest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHTableViewCell : NSObject

@property (nonatomic, assign, readonly) CGFloat cellHeight; //cell的高度
@property (nonatomic, copy, readonly) NSString *identifier; // cell的标识符
@property (nonatomic, assign, readonly) NSRange range; // cell所在的位置范围
@property (nonatomic, copy) void(^configCellComplete)(UITableViewCell *cell, NSIndexPath *indexPath); //配置cell的block
@property (nonatomic, copy) void(^didSelectRowComplete)(UITableViewCell *cell, NSIndexPath *indexPath);// 点击cell的回掉
/*!
 *  @brief 初始化cell托管的对象
 *
 *  @param tableView  cell所注册的tableview
 *  @param range      cell的范围
 *  @param cellHeight cell的高度
 *  @param cellClass  注册cell的class
 *  @param identifier 注册cell的标识符
 *
 *  @return ZHTableViewCell
 */
- (instancetype)initWithTableView:(UITableView *)tableView range:(NSRange)range cellHeight:(CGFloat)cellHeight cellClass:(Class)cellClass identifier:(NSString *)identifier;
/*!
 *  @brief 查询索引是否存在cell
 *
 *  @param index 索引的位置
 *
 *  @return 如果是YES代表存在 如果是NO代表不存在
 */
- (BOOL)cellIsExitRangeWithIndex:(NSUInteger)index;
/*!
 *  @brief 根据索引获取重用的cell
 *
 *  @param indexPath 索引所在的位置
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)cellWithIndexPath:(NSIndexPath *)indexPath;

@end
