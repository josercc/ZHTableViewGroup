//
//  ZHBaseTableViewCell.m
//  ZHTableViewGroup
//
//  Created by 张行 on 2017/3/18.
//  Copyright © 2017年 15038777234. All rights reserved.
//

#import "ZHBaseTableViewCell.h"
#import <Masonry/Masonry.h>



@interface ZHBaseTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation ZHBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        BOOL allowCorner = NO;
        CGSize iconSize = CGSizeZero;
        if ([self conformsToProtocol:@protocol(ZHBaseTableViewCellDelegate)]) {
            id<ZHBaseTableViewCellDelegate> delegate = (id<ZHBaseTableViewCellDelegate>)self;
            allowCorner = delegate.allowCorner;
            iconSize = delegate.iconSize;
        }
        if (allowCorner) {
            self.iconImageView.layer.masksToBounds = YES;
            self.iconImageView.layer.cornerRadius = iconSize.height / 2.0;
        }
        self.iconImageView.backgroundColor = [UIColor darkGrayColor];
        self.textLabel.text = @"";
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-3);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(iconSize);
        }];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

@end
