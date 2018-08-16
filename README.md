# Swift 版本请移步[这里](https://github.com/josercc/ZHTableViewGroupSwift)

# ZHTableViewGroup为 UITableView 而生

![](http://olg3v8vew.bkt.clouddn.com/2017-03-16-38.gif)

## 怎么安装

```ruby
pod 'ZHTableViewGroupObjc'
```



### 怎么使用

####  初始化 ZHTableViewDataSource

```objc
[[ZHTableViewDataSource alloc] initWithTableView:self.homeTableView]
```
### 初始化 ZHTableViewGroup

```objc
[self.dataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
  // 可以注册Header Footer 各种各样的Cell
}
```
#### 初始化 ZHTableViewCell

```objc
[group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {  
  // 可以配置一种cell 可以是多个一样的必须是连续的
}
```
#### 配置 ZHTableViewCell

```swift
 cell.anyClass = [UITableViewCell class]; // 配置 Class
 cell.cellNumber = self.cellTexts.count; //设置cell的个数
 cell.height = 44; // 设置cell的高度
 cell.identifier = @"UITableViewCellIdentifier"; // 设置标识符
 [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) { 
 }];
 [cell setDidSelectRowCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
 }];
```
#### 单独配置 UITableView的代理

> 仅仅只需要设置 UITableView Delegate 即可

```objc
tableView.delegate = self;
```
#### 清除配置

```objc
[self.dataSource clearData];
```

#### 注册和进行刷新

```objc
[self.tableViewDataSource reloadTableViewData];
```

#### 设置泛型

![](http://ipicimage-1251019290.coscd.myqcloud.com/2018-08-16-072220.jpg)

## 关于 UICollectionView

关于 UICollectionView 的数据源托管已经仿照 UITableView 实现，一样的配方。但是没有 UITableView 附加的功能多，但是基本功能都是有的。

其他功能正在逐渐完善。