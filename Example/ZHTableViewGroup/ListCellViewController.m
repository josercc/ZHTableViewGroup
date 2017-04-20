//
//  ListCellViewController.m
//  ZHTableViewGroup
//
//  Created by 张行 on 2017/3/18.
//  Copyright © 2017年 15038777234. All rights reserved.
//

#import "ListCellViewController.h"
#import <ZHTableViewGroupObjc/ZHTableViewDataSource.h>

@interface ListCellViewController ()
@property (nonatomic, strong) ZHTableViewDataSource *dataSource;
@property (nonatomic, strong) NSArray<NSString *> *cellTexts;

@end

@implementation ListCellViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[ZHTableViewDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.autoConfigurationTableViewDelegate = NO;
    [self.dataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
            cell.anyClass = [UITableViewCell class];
            cell.cellNumber = self.cellTexts.count;
            cell.height = 44;
            cell.identifier = @"UITableViewCellIdentifier";
            [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                NSString *string = self.cellTexts[indexPath.row];
                cell.textLabel.text = string;
                if ([self.selectTitles containsObject:string]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }];
            [cell setDidSelectRowCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                NSString *string = self.cellTexts[indexPath.row];
                if ([self.selectTitles containsObject:string]) {
                    [self.selectTitles removeObject:string];
                } else {
                    [self.selectTitles addObject:string];
                }
                [self.tableView reloadData];
            }];
        }];
    }];
    [self.dataSource reloadTableViewData];
    // Do any additional setup after loading the view.
}
- (IBAction)save:(id)sender {
    if (self.saveCompletionHandle) {
        self.saveCompletionHandle(self.selectTitles);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZHTableViewDataSource heightForRowAtDataSource:self.dataSource indexPath:indexPath customHeightCompletionHandle:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZHTableViewDataSource numberOfRowsInSectionWithDataSource:self.dataSource section:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZHTableViewDataSource cellForRowAtWithDataSource:self.dataSource indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ZHTableViewDataSource didSelectRowAtWithDataSource:self.dataSource indexPath:indexPath];
}

- (NSArray<NSString *> *)cellTexts {
    if (!_cellTexts) {
        _cellTexts = @[@"Your Image",@"Your Background",@"E-mail",@"Name",@"Gender",@"Interest List",@"Blank Cell",@"Shipping Address Book"];
    };
    return _cellTexts;
}

- (NSMutableArray *)selectTitles {
    if (!_selectTitles) {
        _selectTitles = [NSMutableArray array];
    }
    return _selectTitles;
}

@end
