//
//  HomeView.m
//  ZHTableViewGroup
//
//  Created by 张行 on 16/9/14.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "HomeView.h"
#import "ZHTableViewDataSource.h"
#import "ZHTableViewGroup.h"
#import "ZHTableViewCell.h"
#import "HomeCellStyleOne.h"
#import "HomeCellStyleTwo.h"
NSString *const KHomeCellStyleOneIdentifier = @"KHomeCellStyleOneIdentifier";
NSString *const KHomeCellStyleTwoIdentifier = @"KHomeCellStyleTwoIdentifier";
@interface HomeView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) ZHTableViewDataSource *dataSource;
@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.homeTableView];
        [self stepTableViewData];
    }
    return self;
}

- (void)stepTableViewData {
    ZHTableViewGroup *group = [[ZHTableViewGroup alloc]init];
    ZHTableViewCell *cellOne = [[ZHTableViewCell alloc]initWithTableView:self.homeTableView range:NSMakeRange(0, 6) cellHeight:44 cellClass:[HomeCellStyleOne class] identifier:KHomeCellStyleOneIdentifier];
    cellOne.configCellComplete = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        HomeCellStyleOne *cellOne = (HomeCellStyleOne *)cell;
        cellOne.textLabel.text = @"One Title";
        cellOne.detailTextLabel.text = @"One Detail";
    };
    cellOne.didSelectRowComplete = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        NSLog(@"cell->%@,indexPath->%@",cell,indexPath);
    };
    [group addTableViewCell:cellOne];

    ZHTableViewCell *cellTwo = [[ZHTableViewCell alloc]initWithTableView:self.homeTableView range:NSMakeRange(6, 5) cellHeight:44 cellClass:[HomeCellStyleTwo class] identifier:KHomeCellStyleOneIdentifier];
    cellTwo.configCellComplete = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        HomeCellStyleOne *cellTwo = (HomeCellStyleOne *)cell;
        cellTwo.textLabel.text = @"Two Title";
        cellTwo.detailTextLabel.text = @"Two Detail";
    };
    cellTwo.didSelectRowComplete = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        NSLog(@"cell->%@,indexPath->%@",cell,indexPath);
    };

    [group addTableViewCell:cellTwo];
    [self.dataSource addTableViewGroup:group];

    [self.homeTableView reloadData];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZHTableViewGroup *group = [self.dataSource groupWithIndex:section];
    return group.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewGroup *group = [self.dataSource groupWithIndex:indexPath.section];
    UITableViewCell *cell = [group cellWithIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewGroup *group = [self.dataSource groupWithIndex:indexPath.section];
    [group didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Get
- (UITableView *)homeTableView {
	if (_homeTableView == nil) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _homeTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
	}
	return _homeTableView;
}

- (ZHTableViewDataSource *)dataSource {
	if (_dataSource == nil) {
        _dataSource = [[ZHTableViewDataSource alloc] init];
	}
	return _dataSource;
}
@end
