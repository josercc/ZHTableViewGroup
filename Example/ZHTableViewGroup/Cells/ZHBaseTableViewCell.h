//
//  ZHBaseTableViewCell.h
//  ZHTableViewGroup
//
//  Created by 张行 on 2017/3/18.
//  Copyright © 2017年 15038777234. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol ZHBaseTableViewCellDelegate <NSObject>

@property (nonatomic, assign, readonly) CGSize iconSize;

@property (nonatomic, assign, readonly) BOOL allowCorner;

@end

@interface ZHBaseTableViewCell : UITableViewCell

@end
