# ZHTableViewGroup

[![CI Status](http://img.shields.io/travis/15038777234/ZHTableViewGroup.svg?style=flat)](https://travis-ci.org/15038777234/ZHTableViewGroup)
[![Version](https://img.shields.io/cocoapods/v/ZHTableViewGroup.svg?style=flat)](http://cocoapods.org/pods/ZHTableViewGroup)
[![License](https://img.shields.io/cocoapods/l/ZHTableViewGroup.svg?style=flat)](http://cocoapods.org/pods/ZHTableViewGroup)
[![Platform](https://img.shields.io/cocoapods/p/ZHTableViewGroup.svg?style=flat)](http://cocoapods.org/pods/ZHTableViewGroup)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZHTableViewGroup is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
<<<<<<< HEAD
pod "ZHTableViewGroup"
=======
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

>>>>>>> origin/master
```

## Author

15038777234, 15038777234@163.com

## License

ZHTableViewGroup is available under the MIT license. See the LICENSE file for more info.
