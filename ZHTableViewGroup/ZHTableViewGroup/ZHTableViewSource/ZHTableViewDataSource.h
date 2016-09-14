//
//  ZHTableViewDataSource.h
//  GearBest
//
//  Created by 张行 on 16/8/31.
//  Copyright © 2016年 GearBest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHTableViewGroup.h"
@interface ZHTableViewDataSource : NSObject
@property (nonatomic, assign) NSUInteger sectionNumber; //section的数量
/*!
 *  @brief 添加分组
 *
 *  @param group 分组对象
 */
- (void)addTableViewGroup:(ZHTableViewGroup *)group;
/*!
 *  @brief 根据索引查询所在的组
 *
 *  @param index 索引位置
 *
 *  @return 所在的组
 */
- (ZHTableViewGroup *)groupWithIndex:(NSUInteger)index;
/*!
 *  @brief 清除托管的数据
 */
- (void)clearData;

@end
