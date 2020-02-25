//
//  TableViewController.m
//  ZHTableViewGroupExample
//
//  Created by josercc on 2020/2/25.
//  Copyright © 2020 josercc. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) ZHTableViewDataSource *tableViewDataSource;

@end

@implementation TableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    nibNameOrNil = nibNameOrNil ?: @"TableViewController";
    nibBundleOrNil = nibBundleOrNil ?: [NSBundle mainBundle];
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (ZHTableViewDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[ZHTableViewDataSource alloc] initWithTableView:self.tableView];
    }
    return _tableViewDataSource;
}

@end
