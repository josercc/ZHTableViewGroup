---
filename:images
---



## Swift 版本请移步[这里](https://github.com/josercc/SwiftTableViewGroup)

`ZHTableViewGroup`为 `UITableView`和 `UICollectionView` 而生

## 演示

### 简单的列表

![image-20200928175235608](https://gitee.com/joser_zhang/upic/raw/master/uPic/image-20200928175235608.png)

```objc
ZHTableViewDataSource *dataSource = [[ZHTableViewDataSource alloc] initWithTableView:self.tableView];
[dataSource clearData];
[dataSource addGroupWithCompletionHandle:^(ZHTableViewGroup * _Nonnull group) {
    [group addCellWithCompletionHandle:^(ZHTableViewCell *tableViewCell) {
        tableViewCell.anyClass = [UITableViewCell  class];
        tableViewCell.identifier = @"UITableViewCell";
        NSArray<NSString *> *titles = @[@"刷新高度",@"刷新Cell",@"刷新数据",@"显示和隐藏"];
        tableViewCell.cellNumber = titles.count;
        [tableViewCell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = titles[indexPath.row];
        }];
    }];
}];
[dataSource reloadTableViewData];
```

### 动态刷新高度

![image-20200928175932428](https://gitee.com/joser_zhang/upic/raw/master/uPic/image-20200928175932428.png)

```objc
[self.tableViewDataSource clearData];
[self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
    [group addCellWithCompletionHandle:^(ZHTableViewCell<ReloadHeightCell1 *> *cell) {
        self->_weakCell = cell;
        cell.anyClass = [ReloadHeightCell1 class];
        cell.identifier = @"ReloadHeightCell1";
        [cell setConfigCompletionHandle:^(ReloadHeightCell1 *cell1, NSIndexPath *indexPath) {
            cell1.textLabel.text = @"ReloadHeightCell1";
        }];
    }];
}];
[self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
    [group addCellWithCompletionHandle:^(ZHTableViewCell<ReloadHeightCell2 *> *cell) {
        cell.anyClass = [ReloadHeightCell2 class];
        cell.identifier = @"ReloadHeightCell2";
        cell.cellNumber = 2;
        [cell setConfigCompletionHandle:^(ReloadHeightCell2 *cell1, NSIndexPath *indexPath) {
            cell1.textLabel.text = @"ReloadHeightCell2";
        }];
    }];
}];
[self.tableViewDataSource reloadTableViewData];
```

#### identifier更新自动高度

```objc
[self.tableViewDataSource reloadCellAutomaticHeightWithIdentifier:@"ReloadHeightCell1"]
```

#### identifier更新固定250高度

```objc
[self.tableViewDataSource reloadCellFixedHeight:250 identifier:@"ReloadHeightCell1"]
```

#### Class更新自动高度

```objc
[self.tableViewDataSource reloadCellAutomaticHeightWithClass:NSClassFromString(@"ReloadHeightCell1")]
```

#### Class更新固定260高度

```objc
[self.tableViewDataSource reloadCellFixedHeight:260 className:NSClassFromString(@"ReloadHeightCell1")]
```

#### 指定ZHTableViewCell更新自动高度

```objc
[self.tableViewDataSource reloadCellAutomaticHeightWithTableViewCell:self.tableViewDataSource.groups[0].cells[0]]
```

#### 指定ZHTableViewCell更新固定270高度

```objc
[self.tableViewDataSource reloadCellFixedHeight:270 tableViewCell:self.tableViewDataSource.groups[0].cells[0]]
```

#### 指定索引更新自动高度

```objc
[self.tableViewDataSource reloadCellAutomicHeightWithGroupIndex:1 cellIndex:0]
```

#### 指定索引更新固定280高度

```objc
[self.tableViewDataSource reloadCellFixedHeight:280 groupIndex:1 cellIndex:0]
```

### 刷新值

![image-20200928180955425](https://gitee.com/joser_zhang/upic/raw/master/uPic/image-20200928180955425.png)

```objc
[self.tableViewDataSource clearData];
[self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
    [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
        cell.anyClass = [UITableViewCell class];
        cell.identifier = @"UITableViewCell";
        [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = [@(random() % 99 + 1) stringValue];
        }];
    }];
}];
[self.tableViewDataSource reloadTableViewData];
```

#### 通过Identifier刷新

```objc
[self.tableViewDataSource reloadCellWithIdentifier:@"UITableViewCell"]
```

#### 通过Class刷新

```objc
[self.tableViewDataSource reloadCellWithClassName:[UITableViewCell class]]
```

#### 通过指定UITableViewCell更新

```objc
[self.tableViewDataSource reloadCellWithTableViewCell:self.tableViewDataSource.groups[0].cells[0]]
```

#### 通过索引更新

```objc
[self.tableViewDataSource reloadCellWithGroupIndex:0 cellIndex:0]
```

### 刷新个数

![image-20200928181349639](https://gitee.com/joser_zhang/upic/raw/master/uPic/image-20200928181349639.png)

```objc
_randoms = [NSMutableArray arrayWithArray:@[@"random"]];
[self.tableViewDataSource clearData];
[self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
    [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
        cell.anyClass = [UITableViewCell class];
        cell.identifier = @"UITableViewCell";
        cell.cellNumber = _randoms.count;
        [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = _randoms[indexPath.row];
        }];
    }];
}];
[self.tableViewDataSource reloadTableViewData];
```

#### identifier刷新个数

```objc
[self.tableViewDataSource reloadCellWithDataCount:_randoms.count identifier:@"UITableViewCell"]
```

#### Class刷新个数

```objc
[self.tableViewDataSource reloadCellWithDataCount:_randoms.count className:[UITableViewCell class]]
```

#### UITableViewCell刷新个数

```swift
[self.tableViewDataSource reloadCellWithDataCount:_randoms.count tableViewCell:self.tableViewDataSource.groups[0].cells[0]]
```

#### 索引刷新个数

```objc
[self.tableViewDataSource reloadCellWithDataCount:_randoms.count groupIndex:0 cellIndex:0]
```

### 显示和隐藏

![image-20200928190127141](https://gitee.com/joser_zhang/upic/raw/master/uPic/image-20200928190127141.png)

```objc
[self.tableViewDataSource clearData];
[self.tableViewDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
    [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
        cell.anyClass = [UITableViewCell class];
        cell.identifier = @"UITableViewCell";
        cell.cellNumber = 10;
        [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = [@(indexPath.row + 1) stringValue];
        }];
        [cell setHiddenBlock:^BOOL(NSIndexPath *indexPath) {
            return _hidden && indexPath.row >= 5 && indexPath.row <= 8;
        }];
    }];
}];
[self.tableViewDataSource reloadTableViewData];
```

#### 隐藏Cell

```objc
[self.tableViewDataSource reloadAllHiddenCell]
```

## 怎么安装

### Cocoapods

```ruby
pod 'ZHTableViewGroup'
```

### Carthage

```ruby
github "josercc/ZHTableViewGroup"
```

### Swift Package Manager

```swift
.package(url: "https://github.com/josercc/ZHTableViewGroup.git", from: "3.0.0")
```

