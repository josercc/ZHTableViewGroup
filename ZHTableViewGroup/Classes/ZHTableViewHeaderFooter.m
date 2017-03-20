//
//  ZHTableViewHeaderFooter.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewHeaderFooter.h"

@implementation ZHTableViewHeaderFooter

- (instancetype)initWithStyle:(ZHTableViewHeaderFooterStyle)style {
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

@end
