//
//  HomeViewController.m
//  ZHTableViewGroup
//
//  Created by 张行 on 16/9/14.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"


@interface HomeViewController ()
@property (nonatomic, strong) HomeView *homeView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.homeView;
}

#pragma mark -  Get

- (HomeView *)homeView {
	if (_homeView == nil) {
        _homeView = [[HomeView alloc] initWithFrame:CGRectZero];
	}
	return _homeView;
}
@end
