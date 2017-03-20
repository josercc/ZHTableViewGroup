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

- (instancetype)initWithStyle:(ZHTableViewHeaderFooterStyle)style;

@end
