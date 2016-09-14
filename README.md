# ZHTableViewGroup
Manger UITableView DataSource Cells


# ZHTableViewGroup



之前遇到过很多复杂的UITableView的结构,里面包含了很多复杂的cell,甚至一个Section包含很多种类的cell。通常在代理

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
```

返回不同的cell,甚至需要在在

```objective-c
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
```

写很多判断逻辑的跳转

现在有了这个库，做一些复杂的表格十分的方便，而且十分的简洁。

## 怎么安装

### 1.使用cocoapods进行安装

```ruby
pod 'ZHTableViewGroup'
```

### 2.直接下载demo拖拽`ZHTableViewSource`到工程里面

## 怎么使用

### 文件的结构

![](https://raw.githubusercontent.com/15038777234/ZHTableViewGroup/master/ZHTableViewDataSource.png)

在例子里面声明一个变量

```objective-c
@property (nonatomic, strong) ZHTableViewDataSource *dataSource;
```

在UITableView的代理实现这些方法

```objective-c
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

```

我们只用在之前初始化数据添加到dataSource

```objective-c
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

```

更多的文档请查看[Wiki](https://github.com/15038777234/ZHTableViewGroup/wiki)
