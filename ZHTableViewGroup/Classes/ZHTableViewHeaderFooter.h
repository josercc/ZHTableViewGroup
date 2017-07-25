//
//  ZHTableViewHeaderFooter.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewBaseModel.h"

typedef NS_ENUM(NSUInteger, ZHTableViewHeaderFooterStyle) {
    ZHTableViewHeaderFooterStyleHeader,
    ZHTableViewHeaderFooterStyleFooter
};

@interface ZHTableViewHeaderFooter : ZHTableViewBaseModel

@property (nonatomic, assign) ZHTableViewHeaderFooterStyle style;
/**
 * 配置头部和尾部
 */
@property (nonatomic, copy) void(^configurationHeaderFooterViewCompletionHandle)(UITableViewHeaderFooterView *headerFooterView);

- (instancetype)initWithStyle:(ZHTableViewHeaderFooterStyle)style;

@end
