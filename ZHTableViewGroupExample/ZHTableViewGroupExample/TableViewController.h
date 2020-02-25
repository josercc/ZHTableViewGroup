//
//  TableViewController.h
//  ZHTableViewGroupExample
//
//  Created by josercc on 2020/2/25.
//  Copyright © 2020 josercc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZHTableViewGroupObjc/ZHTableViewGroupObjc.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong, readonly) ZHTableViewDataSource *tableViewDataSource;

@end

NS_ASSUME_NONNULL_END
