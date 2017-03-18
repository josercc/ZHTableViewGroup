//
//  ListCellViewController.h
//  ZHTableViewGroup
//
//  Created by 张行 on 2017/3/18.
//  Copyright © 2017年 15038777234. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ListCellViewControllerSaveCompletionHandle)(NSArray<NSString *> *list);

@interface ListCellViewController : UITableViewController

@property (nonatomic, copy) ListCellViewControllerSaveCompletionHandle saveCompletionHandle;
@property (nonatomic, strong) NSMutableArray *selectTitles;

@end
