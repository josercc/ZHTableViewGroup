//
//  GBTableGroup.h
//  GearBest
//
//  Created by 张行 on 16/8/31.
//  Copyright © 2016年 GearBest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHTableViewCell.h"
@interface ZHTableViewGroup : NSObject

@property (nonatomic, assign) NSUInteger rowNumber; // 组里面包含CELL的个数

/*!
 *  @brief 添加cell对象
 *
 *  @param cell cell管理对象
 */
- (void)addTableViewCell:(ZHTableViewCell *)cell;
/*!
 *  @brief 根据位置获取cell的高度
 *
 *  @param index cell所在的索引位置
 *
 *  @return cell的高度
 */
- (CGFloat)heightWithIndex:(NSInteger)index;
/*!
 *  @brief 根据索引获取cell的标识符
 *
 *  @param index 索引的位置
 *
 *  @return cell所在的标识符
 */
- (NSString *)identifierWithIndex:(NSInteger)index;
/*!
 *  @brief 根据位置获取重用的cell
 *
 *  @param indexPath 索引所在的位置
 *
 *  @return 重用的cell
 */
- (UITableViewCell *)cellWithIndexPath:(NSIndexPath *)indexPath;
/*!
 *  @brief 配置cell根据所在的位置
 *
 *  @param cell      配置的cell
 *  @param indexPath cell所在的索引
 */
- (void)configCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath;
/*!
 *  @brief 点击对应的cell进行回掉
 *
 *  @param index cell所在cell
 */
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
